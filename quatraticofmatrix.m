% Q=Wt*A*W v A

 A=[2 1; 1  3];
 A=[2 1; 4  2];
 A=[2 1; 1 -1];

xi=-2:.1:2;

quadform=zeros(length(xi));

for i=1:length(xi) for j=1:length(xi)
  
  w=[xi(i) xi(j)]';
  normfact=w'*w;  
  quadform(i,j)=w'*A*w;
    
  end end
  
  figure(1),clf
  surf(xi,xi,quadform'), shading interp 
  title('Quadratic of a 2x2')
  xlabel('W1'),ylabel('W2'),zlabel('joules')
  rotate3d on, axis square