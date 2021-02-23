function chi = computechisquare(data1,data2)
s1 = size(data1);
s2 = size(data2);
if s1(2)~=s2(2)
    disp('both data windows should have same number of features'); 
    chi = inf; return;
end
chidif = data1- data2;
chi = ((chidif)^2)/data2;
d1cv = cov(data1);
d2cv = cov(data2);
wcv = (s1(1)*d1cv+s2(1)*d2cv)/(s1(1)+s2(1));
md = (mudif/wcv)*mudif';
end