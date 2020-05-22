function g2o_pos=g2o(edge_noise_rate,initPos,distMatrix,ConnectivityM,enum,n)
% edge_noise_rate: ���ϵ���������
% initPos: g2o�ĳ�ʼ��
% lneighbor: n*n ÿһ�д�����i�Ľ��о���������ھ��б�����lneighbor(i,1)���ھӸ������������ھ��б�
% distMatrix��n*n ����ߵĲ�������
% ConnectivityM�����Ӿ���1�����о����������2����ֻ�нǶȱ�������3�����о���ͽǶȱ�������NAN����û������
% enum: m, ����
% n: Ҫ��ls_slam�Ż��㷨�ĵ�������

     
     %g2o�Ż�
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