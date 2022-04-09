%T=P+V

%%%%%%%%%%%%%%%%%
megv=Gain_normal_squid - Gain_normal_squidp;

Tmeg=sqrt(sum(Gain_normal_squid.^2, 1));
Pmeg=sqrt(sum(Gain_normal_squidp.^2, 1));
Vmeg=sqrt(sum(megv.^2, 1));

TPmeg=Tmeg./Pmeg;
meanTPmeg=mean(TPmeg);

PVmeg=Pmeg./Vmeg;
meanPVmeg=mean(PVmeg);

%%%%%%%%%%%%%%%%%%%%
opmnv=Gain_normal_opmn - Gain_normal_opmnp;

Topmn=sqrt(sum(Gain_normal_opmn.^2, 1));
Popmn=sqrt(sum( Gain_normal_opmnp.^2, 1));
Vopmn=sqrt(sum(opmnv.^2, 1));
TPopmn=Topmn./Popmn;
meanTPopmn=mean(TPopmn);
PVopmn=Popmn./Vopmn;
meanPVopmn=mean(PVopmn);

%%%%%%%%%%%%%%%%%%%%
opmt1v=Gain_normal_opmt1 - Gain_normal_opmt1p;

Topmt1=sqrt(sum(Gain_normal_opmt1.^2, 1));
Popmt1=sqrt(sum(Gain_normal_opmt1p.^2, 1));
Vopmt1=sqrt(sum(opmt1v.^2, 1));
TPopmt1=Topmt1./Popmt1;
meanTPopmt1x=mean(TPopmt1);
PVopmt1=Popmt1./Vopmt1;
meanPVopmt1=mean(PVopmt1);


%%%%%%%%%%%%%%%%%%%
opmt2v=Gain_normal_opmt2 - Gain_normal_opmt2p;

Topmt2=sqrt(sum(Gain_normal_opmt2.^2, 1));
Popmt2=sqrt(sum(Gain_normal_opmt2p.^2, 1));
Vopmt2=sqrt(sum(opmt2v.^2, 1));
TPopmt2=Topmt2./Popmt2;
meanTPopmt2=mean(TPopmt2);
PVopmt2=Popmt2./Vopmt2;
meanPVopmt2=mean(PVopmt2);


%%%%%%%%%%%%%%%%%%%
opmtav=gaina - gainap;

Topma=sqrt(sum(gaina.^2, 1));
Popma=sqrt(sum(gainap.^2, 1));
Vopma=sqrt(sum(opmtav.^2, 1));
TPopma=Topma./Popma;
meanTPopma=mean(TPopma);
PVopma=Popma./Vopma;
meanPVopma=mean(PVopma);










