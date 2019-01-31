clc clf clear all #AWillis citing serpent999 1.19

fc='1+(y/t)';f=inline(fc,'t','y');t0=1;y0=2;tf=2;n=10;h=(tf-t0)/n;

ta(1)=t0;w(1)=y0; for i=1:n 
  
  ta(i+1)=ta(i)+h;
  rk1=f(ta(i),w(i));
  rk2=f(ta(i)+.5*h,w(i)+.5*rk1*h);
  rk3=f(ta(i)+.5*h,w(i)+.5*rk2*h);
  rk4=f(ta(i)+h,w(i)+rk3*h);

  w(i+1)=w(i)+1/6*(rk1+2*rk2+2*rk3+rk4)*h;end 
  for i=1:n

ta(i+1)=ta(i)+h; if(i>3)

k1=f(ta(i),w(i));
k2=f(ta(i-1),w(i-1));
k3=f(ta(i-2),w(i-2));
k4=f(ta(i-3),w(i-3));

w(i+1)=(w(i)+h/24*(55*k1-59*k2+37*k3-9*k4));end end

t=ta;y=t .*(log(t)+2);

hold on 
xlabel=('x');ylabel=('y');
title('exact and approximate solutions for 4th order bashforth method');
plot(t,y,'-','Linewidth',2,'color',[1 0 0]);
plot(ta,w,'--','Linewidth',2,'color',[0 0 1]);
legend('exact','approx');

for j=1:n+1, disp(sprintf('t=%f,w=%0.11f,y(t)=%0.11f',t(j),w(j),y(j)));end