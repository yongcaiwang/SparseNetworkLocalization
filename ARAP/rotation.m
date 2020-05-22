function [ Topt ] = rotation( Xopt,AnchorID,Anchorpos)
    num=size(AnchorID);
    [dim,npts] = size(Xopt); 
%     T = Xopt(:,AnchorID(1)) - Anchorpos(:,1);
%     Ted = Xopt - T*(zeros(1,npts)+1);
%     theta1=atan2(Anchorpos(2,2)-Anchorpos(2,1),Anchorpos(1,2)-Anchorpos(1,1));
%     theta2=atan2(Ted(2,AnchorID(2))-Anchorpos(2,1),Ted(1,AnchorID(2))-Anchorpos(1,1));
%     theta = theta1-theta2;
%     for i=1:npts;
%         Topt(1,i)=(Ted(1,i)-Anchorpos(1,1))*cos(theta)-(Ted(2,i)-Anchorpos(2,1))*sin(theta)+Anchorpos(1,1);
%         Topt(2,i)=(Ted(2,i)-Anchorpos(2,1))*cos(theta)+(Ted(1,i)-Anchorpos(1,1))*sin(theta)+Anchorpos(2,1);
%     end
    Cresult=Xopt(:,AnchorID);
    [D,Z,T]=procrustes(Anchorpos', Cresult', 'Scaling', false);
    R=T.T;
    translation=T.c(1,:);
    Topt= Xopt'*R + (zeros(1,npts)+1)'*translation;
    Topt=Topt';
end

