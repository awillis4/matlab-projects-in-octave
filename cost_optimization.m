clc clear all close all

min = fminunc(@FMin,[1;1])
function[K] = FMin(a)
measure=table2array(readtable('measurements.csv'));
Qin=measure(:,2);Qout=measure(:,3);M=measure(:,4);Mamb=measure(:,5);
E1=6;d=3600;A=1-d*a(1);B=[-d*a(2),d*a(2)];tempArray = zeros(1,100+E1);
for k=1:length(100+E1)   
ck=d*a(1)*Mamb(k);tempArray(k)=(T(k+1)-(A*M(k)+B*[Qout(k);Qin(k)]+ck))^2;K=sum(tempArray);end end

% Energy Trade Minimization 
clc clear all close all
% Different E-values
E1=6;E2=1;E3=9;
%Read in files
heatDemand = table2array(readtable('heatDemand.csv'));
inputPrices = table2array(readtable('inputPrices.csv'));
measurements = table2array(readtable('measurements.csv'));

#Params
a1=1.96e-7;a2=3.8e-9;d=3600;M1=330+E3;Mmin=315;Qmax=(100+E2)*1000;Mamb=275+E1;
Qout=heatDemand(:,2);L=inputPrices(1:360,2);f=[L/1e6;zeros(360,1)];
# Mat A
del1 = zeros(360,360);del2 = del1;del1(1,1) = -d*a2;del2(1,1) = 1;
for i=2:1:360
    del1(i,i)=-d*a2;del2(i,i)=1;del2(i,i-1)=d*a1-1;end
A=[del1 del2];
# vect b
del1b=zeros(360,1);del1b(1)=-d*a2*Qout(1)+d*a1*Mamb+(1-d*a1)*M1;
for i = 2:1:360
    del1b(i) = -d*a2*Qout(i) + d*a1*Mamb;end
b=[del1b];

%Make upper and lower bounds
del1Lb=zeros(360,1);del2Lb=del1Lb;del1Ub=del1Lb;del2Ub=del1Lb;
del1Ub=del1Ub+Qmax;del2Lb=del2Lb+Mmin;del2Ub=del2Ub+inf;
Lb=[del1Lb;del2Lb];Ub=[del1Ub;del2Ub];

o = optimoptions('linproj','Alg','2-simp');
[X,Fval,flag]=linproj(f,[],[],A,b,Lb,Ub,[],o);

%Exercise 2.4
Mref = 323;ecost = (0.1+E2/10)/360;Mmax = 368;
Ub2 = Ub;Ub2(361:720) = Mmax;
H = zeros(720,720);H(720,720) = ecost;
f2 = f;f2(720,1) = -2*Mref*ecost;
[X2,Fval2,flag2]=4-proj(H,f,[],[],A,b,Lb,Ub,[]);
res=Fval2-Mref*ecost;