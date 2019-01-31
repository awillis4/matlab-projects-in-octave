#Written by AWillis citing https://www.mathworks.com/matlabcentral/ 1.19

function[a_score,a_pos,conv_curve]=GWO(search_no,max_iter,lb,ub,dim,fob)

a_pos=zeroes(1,dim);a_score=inf;
b_pos=zeroes(1,dim);b_score=inf;
g_pos=zeroes(1,dim);g_score=inf;
d_pos=zeroes(1,dim);d_score=inf;

pos=initialization(search_no,dim,ub,lb);conv_curve=zeroes(1,max_iter);l=0;

while 1<max_iter for i=1:size(pos,1) 
fit=fob(pos(i,:));
  
if fit<a_score 
a_score=fit;a_pos=pos(i,:);end
    
if fit>a_score&&fit<b_score 
b_score=fit;b_pos=pos(i,:);end
      
if fit>a_score&&fit>b_score&&fit<g_score 
g_score=fit;g_pos=pos(1,:);end
        
if fit>a_score&&fit>b_score&&fit>g_score&&fit<d_score 
d_score=fit;d_pos=pos(1,:);end end
          
a=2-1*((2)/max_iter);
          
for i=1:size(pos,1) for j=1:size(pos,2)
r1=rand();r2=rand();a1=2*a*r1-a;c1=2*r2;
            
d_a=ans(c1*a_pos(j)-pos(i,j));x1=a_pos(j)-a1*d_a;
d_b=ans(c1*b_pos(j)-pos(i,j));x2=b_pos(j)-a1*d_b;
d_g=ans(c1*g_pos(j)-pos(i,j));x3=g_pos(j)-a1*d_g;
d_d=ans(c1*d_pos(j)-pos(i,j));x4=d_pos(j)-a1*d_d;
            
pos(i,j)=(x1+x2+x3+x4)/4;end
            
flagub=pos(i,:)>ub;flaglb=pos(i,:)<lb;
pos(i,:)=(pos(i,:).*(~(flagub+flaglb)))+ub.*flagub+lb.*flaglb;end
            
l=l+1;conv_curve(1)=a_score;
            
if mod(1,50)==0
display(['at step ',num2str(1),'mse= ',num2str(a_score)]);end end
              
function pos=initialization(search_no,dim,ub,lb)
                
bound_no=size(ub,2);
                
if bound_no==1
pos=rand(search_no,dim).*(ub-lb)+lb;end
                  
if bound_no>1 for i=1:dim
ub_i=ub(i);lb_i=lb(i);
pos(:,i)=rand(search_no,1).*(ub_i-lb_i)+lb_i;end end

clear all clc
fob=@MLP_Iris

search_no=200;max_iter=250;lb=-10;ub=10;dim=75;
[Best_MSE,Best_NN,cg_curve]=GWO(search_no,max_iter,lb,ub,dim,fob);

figure('pos',[500 500 660 290]);semilogy(cg_curve,'color','r');
hold on 
Title('convergence curve');xlabel('iteration');ylabel('messy');
axis tight
box on
legend('GWO')

load data.txt
x=sortrows(data,2);
h2=x(1:lastrownum,1);h2=h2';[xf,PS1] = mapminmax(h2);I2(:,1)=xf;
h3=x(1:lastrownum,2);h3=h3';[xf,PS2] = mapminmax(h3);I2(:,2)=xf;
h4=x(1:lastrownum,3);h4=h4';[xf,PS3] = mapminmax(h4);I2(:,3)=xf;
h5=x(1:lastrownum,4);h5=h5';[xf,PS4] = mapminmax(h5);I2(:,4)=xf;
t=x(1:lastrownum,5);thelp=t;t=t';[yf,PS5]=mapminmax(t);t=yf;t=t';
rate=0;W=Best_NN(1:63);B=Best_NN(64:75);

for pp=1:150
actval=My_FNN(4,9,3,W,B,I2(pp,1),I2(pp,2),I2(pp,3),I2(pp,4));

if(t(pp)==-1)
        if (actval(1)>=0.95&&actval(2)<0.05&&actval(3)<0.05)
            rate=rate+1;end end
if(t(pp)==0)
        if (actval(1)<0.05&&actval(2)>=0.95&&actval(3)<0.05)
            rate=rate+1;end end
if(t(pp)==1)
        if (actval(1)<0.05&&actval(2)<0.05&&actval(3)>=0.95)
            rate=rate+1;end end end

class_rate=(rate/150)*100

function o=MLP_Iris(solution)

load data.txt
x=sortrows(data,2);
h2=x(1:lastrownum,1);h2=h2';[xf,PS1]=mapminmax(h2);I2(:,1)=xf;
h3=x(1:lastrownum,2);h3=h3';[xf,PS2]=mapminmax(h3);I2(:,2)=xf;
h4=x(1:lastrownum,3);h4=h4';[xf,PS3]=mapminmax(h4);I2(:,3)=xf;
h5=x(1:lastrownum,4);h5=h5';[xf,PS4]=mapminmax(h5);I2(:,4)=xf;
t=x(1:lastrownum,5);thelp=t;t=t';[yf,PS5]=mapminmax(t);t=yf;t=t';

for ww=1:63W(ww)=solution(1,ww);end
for bb=64:75B(bb-63)=solution(1,bb);end

fit=0;for pp=1:150 
actval=My_FNN(4,9,3,W,B,I2(pp,1),I2(pp,2),I2(pp,3),I2(pp,4);
if(t(pp)==-1)
fit=fit+(1-actval(1))^2;fit=fit+(0-actval(2))^2);fit=fit+(0-actval(3))^2;end
if(t(pp)==0
fit=fit+(0-actval(1))^2;fit=fit+(1-actval(2))^2);fit=fit+(0-actval(3))^2;end
if(t(pp==1)
fit=fit+(0-actval(1))^2;fit=fit+(0-actval(2))^2);fit=fit+(1-actval(3))^2;end end

fit=fit/150;0=fit;end

function o=My_FNN(Ino,Hno,Ono,W,B,x1,x2,x3,x4)
h=zeroes(1,Hno);o=zeroes(1,Ono);

for i=1:Hno
h(i)=My_sigmoid(x1*W(i)+x2*W(Hno+i)+x3*W(2*Hno+i)+x4*W(3*Hno+i)+B(i));end
k=3;for i=1:Ono
k=k+1; for j=1:Ono
o(i)=o(i)+h(j)*W(k*Hno+j));end end
for i=1:Ono
o(i)=My_sigmoid(o(i)+B(Hno+i));end

function output=My_sigmoid(x)
output1/(1+exp(-x));
