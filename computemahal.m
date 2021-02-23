function md = computemahal(data1,data2)
s1 = size(data1);
s2 = size(data2);
if s1(2)~=s2(2)
    disp('both data windows should have same number of features'); 
    md = inf; return;
end
mudif = mean(data1)- mean(data2);
d1cv = cov(data1);
d2cv = cov(data2);
wcv = (s1(1)*d1cv+s2(1)*d2cv)/(s1(1)+s2(1));
md = sqrt((mudif/wcv)*mudif');
end