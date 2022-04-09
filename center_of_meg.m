meanLoc = zeros(102, 3);

for i=1:102

cmeg=chmeg.Channel(i).Loc;
S1=cmeg(:,1);
S2=cmeg(:,2);
S3=cmeg(:,3);
S4=cmeg(:,4);
X=[S1(1), S2(1), S3(1), S4(1)];
Y=[S1(2), S2(2), S3(2), S4(2)];
Z=[S1(3), S2(3), S3(3), S4(3)];
e=mean(X);
f=mean(Y);
g=mean(Z);
meanLoc(i,:) = [e f g];



end