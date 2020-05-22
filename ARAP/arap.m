function [embeddingPoints] = arap(npoints, initPos, neighbors, patchCoordMatrix)

IterNum=40;
tol=1e-7;

I=0;
J=0;
S=0;
row=0;
cnt=0;
nnz=0;

% Constraint
kc=1;
for kc=1:npoints
    if neighbors(kc,1)>2
        break;
    end
end

% Prefactor coefficient matrix
for i=1:npoints
    ind=neighbors(i,:);
    nbrNum=ind(1);
    s=cat(2,[i],ind(2:nbrNum+1));
    s=sort(s);
    num=nbrNum+1;
    
    d=0;
    if i==kc
        d=1.0/2;
    end
    
    row=row+1;
    for j=1:num
        cnt=cnt+1;
        I(cnt)=row;
        J(cnt)=s(j);
        if s(j)==i
            S(cnt)=nbrNum+d;
        else
            S(cnt)=-1;
        end
    end        
    nnz=nnz+num;
end

m=row;
n=npoints;
A=sparse(I',J',S',m,n,nnz);
[L,U]=lu(A);    

pos=initPos;
toIter=1;
iter=0;
while toIter
    initPos=pos;
    R=zeros(npoints, 4);
    for i=1:npoints
        ind=neighbors(i,:);
        X=patchCoordMatrix(i,:,1);
        Y=patchCoordMatrix(i,:,2);
        nbrNum=ind(1);
        P=zeros(nbrNum,2);
        Q=zeros(nbrNum,2);
        for j=2:nbrNum+1
            Q(j-1,:)=[X(ind(j))-X(i),Y(ind(j))-Y(i)];
            P(j-1,:)=pos(ind(j),:)-pos(i,:);
        end
        [E,S,F]=svd(Q'*P);
        H=E*F';
        R(i,:)=reshape(H,1,4);
    end
    
    r=zeros(npoints,2);
    ind=neighbors(kc,:);
    Xi=patchCoordMatrix(kc,:,1);
    Yi=patchCoordMatrix(kc,:,2);
    r(kc,:)=[Xi(kc),Yi(kc)];
    nbrNum=ind(1);
    for j=2:nbrNum+1
        r(ind(j),:)=[Xi(ind(j)),Yi(ind(j))]*0.5;
    end
    
    for i=1:npoints
        ind=neighbors(i,:);
        Xi=patchCoordMatrix(i,:,1);
        Yi=patchCoordMatrix(i,:,2);
        nbrNum=ind(1);
        Ri=reshape(R(i,:),2,2);
        
        t=[0,0];
        
        for j=2:nbrNum+1
            Xj=patchCoordMatrix(ind(j),:,1);
            Yj=patchCoordMatrix(ind(j),:,2);
            Rj=reshape(R(ind(j),:), 2, 2);
            t=t+[Xi(i)-Xi(ind(j)), Yi(i)-Yi(ind(j))]*Ri+[Xj(i)-Xj(ind(j)), Yj(i)-Yj(ind(j))]*Rj;
        end
        t=t*0.5;
        r(i,:)=r(i,:)+t;
    end
    
    pos=U\(L\r);
    
    iter=iter+1;
    d=norm(initPos-pos, 'fro');
    
    if iter>IterNum || d<tol
        toIter=0;
    end
end

embeddingPoints=pos;
end

