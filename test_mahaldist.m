m=50;
n=70;
data1 = 2*rand(m,3)+253;
data2 = rand(n,3);
md = computemahal(data1,data2);
disp(md)
%disp(cov(data1));
%disp(cov(data2));