function [ reKA ] = getKA( Xopt,DD,AnchorID,Dis )
    num=nnz(DD)/2;
    [dim,npts] = size(Xopt);
    MatrixD=zeros(num,2*npts);
    numedge=1;
    for i=1:npts;
        for j=i+1:npts;
            if(DD(i,j)>0)
                MatrixD(numedge,2*i-1)=(Xopt(1,i)-Xopt(1,j))/Dis(i,j);
                MatrixD(numedge,2*i)=(Xopt(2,i)-Xopt(2,j))/Dis(i,j);
                MatrixD(numedge,2*j-1)=(Xopt(1,j)-Xopt(1,i))/Dis(i,j);
                MatrixD(numedge,2*j)=(Xopt(2,j)-Xopt(2,i))/Dis(i,j);
                numedge=numedge+1;
            end;            
        end;
    end;
    num=1;
    point=1;
    for i=1:npts
        if( point<size(AnchorID,2)+1 && i>AnchorID(point)-1)
            point=point+1;
        else
            MatD(:,2*num-1:2*num)=MatrixD(:,2*i-1:2*i);
            num=num+1;
        end
    end;
    B=inv(MatD'*MatD);
    MatrixB=B*MatD';
    
    %[U,S,V]=svd(MatrixD);
    reKA=sum(MatrixB.*MatrixB,2);
    reKA=[0;0;0;0;0;0;reKA]
end

