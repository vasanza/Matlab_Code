function z = fR2(ym,ycal)
yav = mean(ym);
s1 = sum((ym-yav).^2);
s2 = sum((ym-ycal).^2);
z = 1 - s2/s1;