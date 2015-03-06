clear x y z xs ys zs p;
for i = 1:(length(xm)-1)
	xs(i) =  (xm(i)-xm(i+1));
	ys(i) =  (ym(i)-ym(i+1));
	zs(i) =  (zm(i)-zm(i+1));
  p(i) = (xs(i)+ys(i)+zs(i));
end

pre = 1;
post = 0;
index = pre:1:(length(xs)-post);
x = xs(pre:length(xs)-post);
y = ys(pre:length(ys)-post);
z = zs(pre:length(zs)-post);
p = p(pre:length(p)-post);
axisSum=xm+ym+zm;
axisSum = axisSum(1:end-1);
index=index(pre:length(index)-post);
hold all
subplot(3,1,1)
plot(index,axisSum, 'r')
axis([0 length(index) min(axisSum) mean(axisSum)*2-min(axisSum)]);
hold all
subplot(3,1,2)
plot(index,p, 'r')
axis([0 length(index) (mean(p)-0.02) (mean(p)+0.02)]);

colors = ['y';'g';'r';'b'];
gradients = [2 4 6 16];
for outeri = 1:4
clear axisSmooth smoothIndex;
  j=1;
  aveRange = gradients(outeri);
  for i = (aveRange/2):aveRange:(length(p)-(aveRange/2))
    axisSmooth(j) = abs(mean(p((i-(aveRange/2)+1):(i+(aveRange/2)))));
    smoothIndex(j) = i;
    j=j+1;
  end
  hold all
  subplot(3,1,3)
  plot(smoothIndex,axisSmooth, colors(outeri))
  axis([0 length(index) 0 (mean(axisSmooth)+0.05)]);
end