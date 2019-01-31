htmldata=urlread('https://transferwise.com/gb/currency-converter/usd-to-eur-rate?amount=1');

startplace=strfind(htmldata,'data-rate="EUR"');

us2euro= sscanf(htmldata(startplace+17:startplace+23),'%g');

numcurr=50;
fprintf('US$g=%g Euros;',numCurr,numCurr*us2euro)
fprintf('%g Euros=US$%g.\n',numCurr,numCurr*(1/us2euro));

urlread('https://www.udemy.com/user/mike-x-cohen/');