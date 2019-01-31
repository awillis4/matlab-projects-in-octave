function [ x, y ] = ab2 ( f_ode, range, init, steps )

x=zeros(numSteps+1,1);x(1)=range(1);h=(range(2)-range(1))/steps;y(:,1)=init;

k=1;val=f_ode(x(k),y(:,k));
  xhalf=x(k)+.5*h;yhalf=y(:,k)+.5*h*val;vhalf=f_ode(xhalf,yhalf);
  x(1,k+1)=x(1,k)+h;y(:,k+1)=y(:,k)+h*vhalf;

for k=2:steps
  vold=val;val=f_ode(x(k),y(:,k));
  x(1,k+1)=x(1,k)+h;y(:,k+1)=y(:,k)+h*(3*val-vold)/2;
  
  figure(1);subplot(2,1,1);plot(x,y);
  title('Adams-Bashforth second order method');
  xlabel('x');ylabel('f');
end #Written by Armani Willis citing math.pitt.edu