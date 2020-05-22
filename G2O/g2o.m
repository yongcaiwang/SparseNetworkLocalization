function g2o_pos=g2o(edge_noise_rate,initPos,distMatrix,ConnectivityM,enum,n)
% edge_noise_rate: 边上的噪声幅度
% initPos: g2o的初始解
% lneighbor: n*n 每一行代表顶点i的仅有距离测量的邻居列表。其中lneighbor(i,1)是邻居个数，后面是邻居列表。
% distMatrix：n*n 距离边的测量矩阵
% ConnectivityM：连接矩阵，1代表有距离边相连；2代表只有角度边相连；3代表有距离和角度边相连；NAN代表没有连边
% enum: m, 边数
% n: 要求ls_slam优化算法的迭代次数

     
     %g2o优化
    npoints = size(initPos,1); 
    vmeans=zeros(2,npoints);
    eids=zeros(2,enum);
    emeans=zeros(2,enum);
    etype=zeros(enum,1);
    einfs=zeros(enum,1);
    for j=1:npoints
        vmeans(:,j)=[initPos(j,1),initPos(j,2)];
    end
    count=1;
       for j=1:npoints
           for k=1:npoints  
               if ConnectivityM(j,k)==1
                    etype(count)=1;
                    eids(1,count)=j;
                    eids(2,count)=k;
                    emeans(:,count)=[distMatrix(j,k),0];
                    einfs(count) = 1/edge_noise_rate;
                    count=count+1;
               end
           end
       end
    size(eids);
    g2o_pos=ls_slam(vmeans, eids, emeans, einfs, etype, n)';

end