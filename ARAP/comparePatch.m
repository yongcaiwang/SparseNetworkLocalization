function [ patchKA ] = comparePatch( points , patchCoordMatrix , npoints , neighbors , distMatrix)
for i=1:npoints
    opt=find(neighbors(i,:)>0);
    neigh=neighbors(i,opt);
    if(size(neigh,2)==0)
        continue;
    end
    n=neigh(1)+1;
    neigh(1)=i;
    truth = points(neigh,:);
    patch = patchCoordMatrix(i,neigh,:);
    patch = squeeze(patch);
    
    [D,Z,T]=procrustes(truth, patch, 'Scaling', false);
%     DD=zeros(n+1)+1-eye(n+1);
%     plotgraph(truth'*100,DD);
%     plotgraph(patch'*100,DD);
%     plotgraph(Z'*100,DD);
    residual = getresidual( truth*100 , patch*100 )
    patchKA(i) = getKA_patch(neigh, patch ,distMatrix);

end;


end

