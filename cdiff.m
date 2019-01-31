function[d,e]=cdiff(f,x,n)

if ~isa(f,'function_handle')||nargin(f)~=1||nargout(f)~=-1
  error('cdiff:NotFunctionHandle',['f must be 1 in:1 out']); end
  
  if isempty(x)||~isfloat(x)
    error('cdiff:Invalid x','x array not empty'); end
    
    if nargin<3 n=1; elseif ~isscalar(n)||~isnumeric(n)||~any(n==[0 1 2])
      error('cdiff:InvalidOrder','d must be 0,1,2.');end
      
      if n==1 
        h=2^-28 
        d=imag(f(x+i*h))/h;
        elseif n==2 fx=f(x);
        if isa(fx,'single')||isa(x,'single') h=2^-7
          else h=2^-13 end
          
          d=(fx-real(f(x+i*h)))*2/h^2; else d=f(x); end
          
          if nargout>1 if n==0; e=cast(0,class(d));
           else e=cast(abs(d-double(subs(diff(sym(f),n),x))),class(d));
           
         end end 
         
         function cdiff_test
           
           syms t
           Phi=[cos(t) cos(t)*sin(t) sin(t)];
           Phi_d2=diff(Phi,t)
           double(subs(Phi_d2,t,0))
           
           syms t
           Phi=[cos(t) cos(t)*sin(t) sin(t)];
           Phi_d2s=diff(Phi,t)
           double(Phi_d2s(0))
           
           Phi=@(t)[cos(t) cos(t).*sin(t) sin(t)];
           h=2^-28;cdiff=@(f,x)imag(f(x(:)+i*h))/h;
           Phi_d2=cdiff(Phi,0)
           
           t=linspace(0,2*pi,1000);
           Phi_d2=cdiff(Phi,t);figure
           plot(t',Phi_d2(:,1),'b',t,Phi_d2(:,2),'g',t,Phi_d2(:,3),'r')
           
           t=linspace(0,2*pi,1000);
           Phi=[cos(t);cos(t).*sin(t);sin(t)];
           dPhi=gradient(Phi,t(2)-t(1));
           
           dPhis=Phi_d2s(t) 
           dPhis=reshape(double([dphis{:}]),1000,3)';
           
           figure plot(t,dPhis(1,:),'b',t,dPhis(2,:),'g',t,dPhis(3,:),'r') whos
           
           figure e1=abs(dPhis-dPhi);plot(t,e1(1,:),'b',t,e1(2,:),'g',t,e1(3,:),'r')
           
           #Written by Armani Willis citing horchler