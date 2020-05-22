function [patchCoordMatrix]=patchLocalization(npoints, neighbors, distMatrix, ConnectivityM)

IterNum=50;         % maximum iteration of SMACOF
tol=1e-7;           % tolerance for SMACOF iteration

maxNbrNum=max(neighbors(:,1));
patchCoordMatrix=zeros(npoints, maxNbrNum+1, 2);

for i=1:npoints

    nbrNum=neighbors(i,1);
    ind=[neighbors(i,2:nbrNum+1), [i]];
    pairDistMatrix=zeros(nbrNum+1, nbrNum+1);
    num=nbrNum+1;
    
    for j=1:num
        for k=j:num
            if j==k
                pairDistMatrix(j,k)=0;
            elseif ConnectivityM(ind(j),ind(k))==1
                pairDistMatrix(j,k)=distMatrix(ind(j),ind(k));
            else
                pairDistMatrix(j,k)=NaN;
            end
        end
    end
       
    for j=1:num
        for k=j:num
            if isnan(pairDistMatrix(j,k))
                maxDist_j=max(distMatrix(ind(j),:));
                maxDist_k=max(distMatrix(ind(k),:));
                lowDist=max(maxDist_j, maxDist_k);
                upDist=Inf;
                for p=1:npoints
                    if ConnectivityM(ind(j),p)==1 && ConnectivityM(ind(k),p)==1
                        len=distMatrix(ind(j),p)+distMatrix(ind(k),p);
                        upDist=min(upDist, len);
                    end
                end
                pairDistMatrix(j,k)=(lowDist+upDist)*0.5;
            end
        end
    end
    
    % Make matrix symmetry
    for j=1:num
        for k=j:num
            pairDistMatrix(k,j)=pairDistMatrix(j,k);
        end
    end
    
    % MDS
    [Y, e] = cmdscale(pairDistMatrix);
%     [Y, e] = mdscale(pairDistMatrix,2);
     [a,b]=size(Y);
     if(b<2)
         continue;
     end
     pos=Y(:,1:2);
    
    % SMACOF
    toIter=1;
    iter=0;
    while toIter
        upos=pos;
        for k=1:num
            nbr=0;
            t=[0,0];
            for p=1:num
                if ConnectivityM(ind(k),ind(p))==1
                    nbr=nbr+1;
                    z=upos(k,:)-upos(p,:);
                    l=norm(z);
                    if l>0
                        l=1.0/l;
                    end
                    t=t+upos(p,:)+z*l*distMatrix(ind(k),ind(p));
                end
            end
            if nbr>0
                t=t*1.0/nbr;
                pos(k,:)=t;
            end
        end
        iter=iter+1;
        d=norm(pos-upos,'fro');%what this means
        if iter>IterNum || d<tol
            toIter=0;
        end
    end
    
    for k=1:nbrNum+1
        patchCoordMatrix(i,ind(k),:) = pos(k,:);
    end
end
