function [ x, y ] = ab2 ( f, range, init, steps )

x=zeros(steps+1,1);x(1)=range(1);
h=(range(2)-range(1))/steps;y(1,:)=transpose(init);
yprime(1,:)=transpose(feval(f,x(1),y(1,:)));

k = 1;
  xhalf = x(k) + 0.5 * h;
  yhalf = y(k,:) + 0.5 * h * yprime(k,:);
  yprime1 = transpose(feval ( f, xhalf, yhalf ));

  x(k+1) = x(k) + h;
  y(k+1,:) = y(k,:) + h * yprime1;
  yprime(k+1,:) = transpose(feval ( f, x(k+1), y(k+1,:) ));

for k = 2 : steps
  x(k+1) = x(k) + h;
  y(k+1,:) = y(k,:) + ...
    h * ( 3.0 * yprime(k,:) - yprime(k-1,:) ) / 2.0;
  if k<steps
    yprime(k+1,:) = transpose(feval ( f, x(k+1), y(k+1,:) ));
    
  figure(1);subplot(2,1,1);plot(x,y);
  title('Adams-Bashforth second order method');
  xlabel('x');ylabel('y');
  end end #AWillis citing math.pitt.edu 1.19