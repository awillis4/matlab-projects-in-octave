N=64;multidata=0;

prop2corrupt=.1; 
%removes a fraction of channels

badsensors=randperm(N^2);
badsensors=badsensors(1:ceil(prop2corrupt*N^2));
% replaces these sensors with noise
multidataC=multidata;

for ti=1:npnts
  %loop through time then replaces pixels
  tmp=squeeze(multidata(ti,:,:));
  % gets data from this time point
  tmp(badsensors)= 100*randn(length(badsensors),1);
  multidata(ti,:,:)=tmp;
  %puts this data over bad data
  end
  
  figure(1),clf
  
  subplot(131);
  oh=imagesc(squeeze(mean(multidata,1)));
  set(gca,'clim',[-1 1]*2),axis square
  title('original data');
  
  subplot(132)
  ch=imagsc(squeeze(mean(multidata,1)));
  set(gca,'clim',[-1 1]*2),axis square
  title('corrupted data');
  
  for ti=1:npnts
    set(oh,'CData',squeeze(multidata (ti,:,:)))
    set(ch,'CData',squeeze(multidataC(ti,:,:)))
    pause(.05)
    end
    
    figure(2),clf
    imagesc(squeeze(stdmultidataC,[],1))
    
    tmp=reshape(squeeze(std(multidataC,[],1)),1,[]);
    tmpz=(tmp-mean(tmp)/std(tmp));
    histogram(tmpz,30);
    
    sensors2interp=tmpz>2;
    
    multidataR=zeros(npnts,N,N);
    
    for ti=1:npnts
      
      oneframe=squeeze(multidataC(ti,:,:));
      P=scatteredInterpolant(X(~sensors2interp)',Y(~senors2interp)',oneframe(~sensors2interp)');
      
      x=X(~sensors2interp)';
      y=Y(~sensors2interp)';
      z=oneFrame(~ensors2interp)';
      p=P(X(sensors2interp)',Y(sensors2interp)');
      
      oneframe(sensors2interp)=p;
      multidataR(ti,:,:)=oneframe
      end
      
      subplot(131)
      imgh1= imagesc(squeeze(mean(multidata,1)));
      set(gca,'clim',[-1 1]*2),axis square
      title('original data');
      
      subplot(132)
      imgh2= imagesc(squeeze(mean(multidata,1)));
      set(gca,'clim',[-1 1]*2),axis square
      title('measured data');
      
      subplot(133)
      imgh3= imagesc(squeeze(mean(multidata,1)));
      set(gca,'clim',[-1 1]*2),axis square
      title('redone data');
      
      for ti=i:npnts
        
        set(imgh1,'CData',squeeze(multiddata(ti,:,:)))
        set(imgh2,'CDara',squeeze(multiddataC(ti,:,:)))
        set(imgh3,'CData',squeeze(multiddataR(ti,:,:)))
        pause(.05)
        end