%%http://www.mathworks.com/matlabcentral/answers/27408-reading-a-csv-file-with-header-and-times

pre = 1;
post = 0;
index = 1:1:length(xm);
x = xm(pre:length(xm)-post);
y = ym(pre:length(ym)-post);
z = zm(pre:length(zm)-post);
index=index(pre:length(index)-post);
hold all
subplot(3,1,1)
plot(index,x, 'r')
%axis([0 length(z) 0 0.02]);
subplot(3,1,2)
plot(index,y, 'b')
%axis([0 length(z) 0 0.02]);
subplot(3,1,3)
plot(index,z, 'y')
%axis([0 length(z) 0 0.02]);
hold off