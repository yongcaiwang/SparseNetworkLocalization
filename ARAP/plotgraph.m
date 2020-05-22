%%**************************************************************
%% Plot connectivity graph
%%
%%**************************************************************

  function plotgraph(PP,DD)
  figure;
  axes('FontSize',14,'FontWeight','bold');
  markersize = 8; 

  [dim,npts] = size(PP); 

  Ds = DD(1:npts,1:npts); 
  r1 = 1; r2 = 2; 
  h = plot(PP(r1,1),PP(r2,1),'or','markersize',6);    
  set(h,'linewidth',3);
  hold on;      
  for j = 2:npts           
     idx = find(Ds(1:j,j)); 
     if ~isempty(idx)
        len = length(idx); 
        Pj = PP(:,j)*ones(1,len); 
        plot([Pj(r1,:); PP(r1,idx)],[Pj(r2,:); PP(r2,idx)],'g');
     end
     h = plot(PP(r1,j),PP(r2,j),'or','markersize',6);    
     set(h,'linewidth',3);      
  end
  grid on
  axis('square');
  legend('groundtruth');
  hold off
%%**************************************************************
