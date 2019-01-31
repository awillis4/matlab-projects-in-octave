% Sigmoid function: f=a/(1+e^(-b(x-c)))

a=1.4; b=2; c=2;
x=linspace(-5,5,400);
sigmoid= a ./ (1+exp(-b*(x-c)));

figure(5),clf
plot(x,sigmoid,'linew',3)
hold on

plot([0 0],get(gca,'ylim'),'k--') % line at x=0
plot([c c],get(gca,'ylim'),'r--') % line at x=c
plot(get(gca,'xlim'),[1 1]*a/2,'m--') % line at y=a/2

xlabel('x'),ylabel('y')
