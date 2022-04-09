%Topography power



n=gainopmn(:,1)
pow_n=gainopmn.^2
hist(pow_n,50);

pow_t1 = gainopmt1.^2
hist(pow_n./pow_t1,50);




