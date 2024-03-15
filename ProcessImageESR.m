global gESR
%test2=squeeze(yellowData2(:,1,:));
test=gESR.data(:,:);
test=squeeze(test);
xstart=2.78;
xend=3.3;
ystart=0;
yend=200;


leng=size(test,1);
sweep=size(test,2);


for i=1:leng
    test(i,:)=test(i,:)-mean(test(i,:));
    test(i,:)=test(i,:)/std(test(i,:));
end

xaxis=xstart:(xend-xstart)/(sweep-1):xend;
yaxis=ystart:(yend/(leng-1)):yend;

figure; imagesc(xaxis,yaxis, test)
xlabel('Frequency (GHz)');
ylabel('Position (um)');
%ylim([0 200])
%xticks([2.85:.005:2.89])
set(gcf, 'Position', [100, 100, 400, 250])