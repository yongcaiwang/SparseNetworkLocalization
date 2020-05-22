function [embeddingPoints] = aaap(npoints, neighbors, patchCoordMatrix)

I=0;
J=0;
S=0;
row=0;
cnt=0;
nnz=0;
for i=1:npoints
    ind=neighbors(i,:);
    X=patchCoordMatrix(i,:,1);
    Y=patchCoordMatrix(i,:,2);
    nbrNum=ind(1);
    for j=2:nbrNum+1
        nbr=ind(j);
        row=row+1;
        
        cnt=cnt+1;
        I(cnt)=row;
        J(cnt)=nbr;
        S(cnt)=1;
        cnt=cnt+1;
        I(cnt)=row;
        J(cnt)=i;
        S(cnt)=-1;
        cnt=cnt+1;
        I(cnt)=row;
        J(cnt)=npoints+2*i-1;
        S(cnt)=-(X(nbr)-X(i));
        cnt=cnt+1;
        I(cnt)=row;
        J(cnt)=npoints+2*i;
        S(cnt)=-(Y(nbr)-Y(i));
        
        nnz=nnz+4;
    end
end

k=0;
for k=1:npoints
    if neighbors(k,1)>2
        break;
    end
end
CX=patchCoordMatrix(k,:,1);
CY=patchCoordMatrix(k,:,2);
ind=neighbors(k,:);
nbrNum=ind(1);
b=zeros(row+nbrNum+1,2);
row=row+1;
b(row,:)=[CX(k),CY(k)];
for h=2:nbrNum+1
    nbr=ind(h);
    row=row+1;
    cnt=cnt+1;
    
    I(cnt)=row;
    J(cnt)=nbr;
    S(cnt)=1;
    
    b(row,:)=[CX(ind(h)),CY(ind(h))];   
    nnz=nnz+1;
end

m=row;
n=npoints*3;

% Solve
A=sparse(I',J',S',m,n,nnz);
b=A'*b;
A=A'*A;

R = chol(A + 1e-13*eye(size(A)));
 % Whether this is a bad thing to do depends on how you continue to use R.
 
%R=chol(A);

r=R\(R'\b);

embeddingPoints=r(1:npoints,:);

end

