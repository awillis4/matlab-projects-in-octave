function [f, g] = rosenbrock(x)
x=x(1);y=x(2);
if(nargin < 1)
    f = @(x, y)(100*(x.^2-y).^2+(x-1).^2);ezsurf(f);
else
f = 100*(x.^2-y).^2+(x-1).^2;
g(1) = 2*(200*x*(x^2 - y) + x -1);
g(2) = -200*(x^2 -y);
g1=g(1);g2=g(2);

 figure(1)
  subplot(2,1,1); plot(x,f); title('x to f');xlabel('x');ylabel('f');
  subplot(2,1,2);plot(x,g1); title('x to g1');xlabel('x');ylabel('g1');
  subplot(2,1,3); plot(x,g2); title('x to g2');xlabel('x');ylabel('g2');
  end #AWillis citing wololorin 1.19
