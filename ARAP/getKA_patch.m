function [ patchKA ] = getKA_patch(neigh, patch ,distMatrix)
    num=size(neigh,2);
    MatrixD = zeros(num-1,2);
    for i=2:num
        MatrixD(i,1) = (patch(1,1) - patch(i,1))/distMatrix(neigh(i),neigh(1));
        MatrixD(i,2) = (patch(1,2) - patch(i,2))/distMatrix(neigh(i),neigh(1));
        
    end;
    B=inv(MatrixD'*MatrixD);
    MatrixB=B*MatrixD';
    patchKA=sqrt(sum(sum(MatrixB.*MatrixB)));

end

