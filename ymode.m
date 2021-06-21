function [kTE,VTE,kTM,VTM,dTE,dTM]=ymode(ky,omega)
global K m ep1
%Solve the TE Mode
eps1=1e-10;  %error range
mu1=1; %test for left hand material

[VT,kT]=eig([zeros((2*m+1)^2),eye((2*m+1)^2);...
        1*(omega^2*ep1-1*diag(K(:,1).^2+(ky+K(:,2)).^2)),-1*(diag(2*K(:,1)))]);
kTE=diag(kT);
VT=VT(1:(2*m+1)^2,:);
VT=VT*diag(1./sqrt(sum(abs(VT).^2)));
[maxVT,idVT]=max(abs(VT));
VTE=VT*diag(maxVT'./diag(VT(idVT,1:2*(2*m+1)^2)));

%Solve the TM Mode

Kp=K+ones((2*m+1)^2,1)*[0 ky];
[VT,kT]=eig([zeros((2*m+1)^2),eye((2*m+1)^2);ep1*(omega^2*mu1*eye((2*m+1)^2)-inv(ep1).*(Kp*Kp.')),...
        -ep1*(inv(ep1).*(K(:,1)*ones(1,(2*m+1)^2)+ones((2*m+1)^2,1)*K(:,1)'))]);
kTM=diag(kT);
VT=VT(1:(2*m+1)^2,:);
VT=VT*diag(1./sqrt(sum(abs(VT).^2)));
[maxVT,idVT]=max(abs(VT));
VTM=VT*diag(maxVT'./diag(VT(idVT,1:2*(2*m+1)^2)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% The denote of direction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dTE=1/omega*diag(VTE'*( diag(K(:,1))*VTE+VTE*diag(kTE) ));
dTM=1/omega*diag(VTM'*inv(ep1)*( diag(K(:,1))*VTM+VTM*diag(kTM) ));

%%%%%%%%%%%%%% find the solution in 1st BZ of TE mode %%%%%%%%%%%
i3=[];
% i0= (real(dTE)+imag(dTE))<0;
i0= (abs(real(dTE))>abs(imag(dTE))).*((real(dTE)+imag(dTE))<0) + (abs(real(dTE))<abs(imag(dTE))).*(imag(kTE)<0);
%%%%%%// added for vg_x=0 2002/10/28 \\%%%%%%%%
i1= (real(dTE)+imag(dTE))==0;
[buf,i2]=sort(1-i1);
for i3=1:(2*m+1)
    if buf(i3)==0 & abs(real(kTE(i2(i3))))<=0.5, i0(i2(i3))=1; break; end;
end
i3=[];
%%%%%%\\ added for vg_x=0 2002/10/28 //%%%%%%%%
for i4=0:1
    i0=~i0;
    i1= 1:2*(2*m+1)^2;i1=i1(i0);
    [buf,i2]=sort(abs(real(kTE(i0))));
    %%%%%%%%%%%%%% just take the answer inside the 1BZ %%%%%%%%%%%%%%%
    i1=i1(i2);
    %    i2= abs( [imag(kTE(i1));inf] - [inf;imag(kTE(i1))] ) > eps1 | abs([imag(kTE(i1));inf])<=eps1;
    i2= abs( [imag(kTE(i1));inf] - [inf;imag(kTE(i1))] ) > eps1 | abs([imag(kTE(i1));inf])<=eps1 | abs(abs([real(kTE(i1));inf])-abs([inf;real(kTE(i1))])) > eps1 | abs(abs([real(kTE(i1));inf])+abs([inf;real(kTE(i1))])-1)>=0.1;
    i1=i1(i2(1:(length(i2)-1)));
    i3=[i3 i1(1:(2*m+1))];
end
kTE=kTE(i3);
dTE=dTE(i3);
VTE=VTE(:,i3);

%%%%%%%%%%%%%% find the solution in 1st BZ of TM mode %%%%%%%%%%%
i3=[];
% i0= (real(dTM)+imag(dTM))<0;
i0= (abs(real(dTM))>abs(imag(dTM))).*((real(dTM)+imag(dTM))<0) + (abs(real(dTM))<abs(imag(dTM))).*(imag(kTM)<0);
%%%%%%// added for vg_x=0 2002/10/28 \\%%%%%%%%
i1= (real(dTM)+imag(dTM))==0;
[buf,i2]=sort(1-i1);
for i3=1:(2*m+1)
    if buf(i3)==0 & abs(real(kTM(i2(i3))))<=0.5, i0(i2(i3))=1; break; end;
end
i3=[];
%%%%%%\\ added for vg_x=0 2002/10/28 //%%%%%%%%
for i4=0:1
    i0=~i0;
    i1= 1:2*(2*m+1)^2;i1=i1(i0);
    [buf,i2]=sort(abs(real(kTM(i0))));
    %%%%%%%%%%%%%% just take the answer inside the 1BZ %%%%%%%%%%%%%%%
    i1=i1(i2);
    %    i2= abs( [imag(kTM(i1));inf] - [inf;imag(kTM(i1))] ) > eps1 | abs([imag(kTM(i1));inf])<=eps1;
    i2= abs( [imag(kTM(i1));inf] - [inf;imag(kTM(i1))] ) > eps1 | ...
        abs([imag(kTM(i1));inf])<=eps1 | ...
        abs(abs([real(kTM(i1));inf])-abs([inf;real(kTM(i1))])) > eps1 | ...
        abs(abs([real(kTM(i1));inf])+abs([inf;real(kTM(i1))])-1)>=0.1;
    i1=i1(i2(1:(length(i2)-1)));
    i3=[i3 i1(1:(2*m+1))];
end
kTM=kTM(i3);
dTM=dTM(i3);
VTM=VTM(:,i3);