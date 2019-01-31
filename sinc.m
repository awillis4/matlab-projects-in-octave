x=linspace(-8,8,50);
y=linspace(-8,8,48);

% sincsurf=zeros(length(x),length(y));

% for i=1:length(x) for j=1:length(y)
    
%    z=complex(x(i),y(j));sincsurf(i,j)=sin(z)/z;
    
%    end end
    
    z=bsxfun(@plus,x,1i*y')'; z=(x+1i*y')';
    
    sincsurf=sin(z)./z;
    
    f2plot=real(sincsurf)-abs(sincsurf);
    
    figure(1), clf, surf(y,x,f2plot)
    shading interp, rotate3d on
    xlabel('real'), ylabel('im'), zlabel('f(z)')
    axis square 