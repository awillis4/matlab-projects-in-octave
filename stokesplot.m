l=100;x=0;g=9.81;k=(2*pi/l);o=sqrt(2*pi*g/l);t=0:.1:20;

for r=.01:.01:.09;
  
  z0=r*l;z1=z0*sin(o*t-k*x);z2=z0*cos(o*t-k*x)+.5*k*(z0^2)*cos(2*(o*t-k*x));
  
  figure(1)
  
  subplot(2,1,1) 
  plot(t,z1) 
  title('First order wave profile @ l=100,x=0')
  xlabel('seconds past') 
  ylabel('wave profile m')
  legend('z=.01','z=.02','z=.03','z=.04','z=.05','z=.06','z=.07','z=.08','z=.09')
  
  subplot(2,1,2) 
  plot(t,z2) 
  title('Stokes second order wave profile @ ;=100,x=0')
  xlabel('seconds past') 
  ylabel('wave profile m')
  legend('z=.01','z=.02','z=.03','z=.04','z=.05','z=.06','z=.07','z=.08','z=.09')
  
  hold on grid on 
  end # Written by Armani Willis citing ctretow 1.19