function plotnoise( Xopt,DD,reKA )
    figure;
    hold on;
    markersize = 8; 
    [dim,npts] = size(Xopt); 
    
    Ds = DD(1:npts,1:npts); 
    r1 = 1; r2 = 2; 
    box on
    figure_FontSize=16;
    set(get(gca,'XLabel'),'FontSize',figure_FontSize,'Vertical','top');
    set(get(gca,'YLabel'),'FontSize',figure_FontSize,'Vertical','middle');
    set(findobj('FontSize',10),'FontSize',figure_FontSize);
    XLabel('X','fontsize',18)
    YLabel('Y','fontsize',18)
    set(gca,'linewidth',2) 
    hold on
    for i=1:npts;
        idx=find(DD(i,:)>0);
        idy=find(idx<npts+1);
        idx=idx(idy);
        len = length(idx); 
        Pj = Xopt(:,i)*ones(1,len); 
        plot([Pj(r1,:); Xopt(r1,idx)],[Pj(r2,:); Xopt(r2,idx)],'g','linewidth',2);
    end;
    hold on;
    h = plot(Xopt(r1,:),Xopt(r2,:),'.r','markersize',16);  
    set(h,'linewidth',3);
    hold on;
    for i=1:npts;
        t=0:0.005*pi:2*pi;
        x=reKA(2*i-1)*cos(t)+Xopt(1,i);
        y=reKA(2*i)*sin(t)+Xopt(2,i);
        h=plot(x,y,'b');
        set(h,'linewidth',2);
    end;


end

