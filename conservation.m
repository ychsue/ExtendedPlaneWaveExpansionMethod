function [ checkE,checkM,RTE,TTE,RTM,TTM ] = conservation( rTE,tTE,rTM,tTM,dTE,dTM,ky,omega )
%CONSERVATION Summary of this function goes here
%  Detailed explanation goes here
global K m ep1;
kxi=sqrt(omega^2-ky^2); if kxi==0, kxi=eps;end;
kxr=sqrt(omega^2-(ky-round(ky)+(-m:m)).^2);

i0=abs(imag(kxr(1:(2*m+1))))<=1e-15;
if length(rTE(i0))==0
    RTE=0;
else
	RTE=rTE(i0)'*diag(kxr(i0))*rTE(i0)/kxi;
end

i0=abs(imag(dTE(1:(2*m+1))))<=abs(real(dTE(1:(2*m+1))));
if length(tTE(i0))==0
    TTE=0;
else
    TTE=tTE(i0)'*diag(dTE(i0))*tTE(i0)/kxi*omega;
end

i0=abs(imag(kxr(1:(2*m+1))))<=1e-15;
if length(rTM(i0))==0
    RTM=0;
else
	RTM=rTM(i0)'*diag(kxr(i0))*rTM(i0)/kxi;
end

i0=abs(imag(dTM(1:(2*m+1))))<=abs(real(dTM(1:(2*m+1))));
if length(tTM(i0))==0
    TTM=0;
else
    TTM=tTM(i0)'*diag(dTM(i0))*tTM(i0)/kxi*omega;
end
RTE=abs(RTE);TTE=abs(TTE);RTM=abs(RTM);TTM=abs(TTM);
checkE=RTE+TTE;
checkM=RTM+TTM;