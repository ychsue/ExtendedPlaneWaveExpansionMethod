function averageofk(filename,ky)
%making date: 20020828
%Usage:     calculate the <k> vector
eval(['load ',filename]);
omega=inputdata{8};
m=inputdata{2};
ky=round(ky);
[buf,ith]=sort(abs(kym-ky));
VTE=VTE{ith(1)};
VTM=VTM{ith(1)};
kTE=kTE{ith(1)};
kTM=kTM{ith(1)};
dTEx=1/omega*diag(VTE'*( diag(K(:,1))*VTE+VTE*diag(kTE) ));
dTMx=1/omega*diag(VTM'*inv(ep1)*( diag(K(:,1))*VTM+VTM*diag(kTM) ));
dTEy=1/omega*diag(VTE'*( diag(K(:,2))*VTE+VTE*diag(kym(ith(1))) ));
dTMy=1/omega*diag(VTM'*inv(ep1)*( diag(K(:,2))*VTM+VTM*diag(kym(ith(1))) ));
%%%%%%%%%%%%%% find the solution in 1st BZ of TE mode %%%%%%%%%%%
[buf,i0]=sort(imag(kTE));
i0=i0(length(i0):-1:1);
kTE=kTE(i0);
[buf,i1]=sort(abs(real(kTE)));
kTE=kTE(i1);
i0=i0(i1);
dTE=dTE(i0);
VTE=VTE(:,i0);
kTE=kTE(1:(4*m+2));
dTE=dTE(1:(4*m+2));
VTE=VTE(:,1:(4*m+2));
%%%%%%%%%%%%%% find the solution in 1st BZ of TM mode %%%%%%%%%%%
[buf,i0]=sort(imag(kTM));
i0=i0(length(i0):-1:1);
kTM=kTM(i0);
[buf,i1]=sort(abs(real(kTM)));
kTM=kTM(i1);
i0=i0(i1);
dTM=dTM(i0);
VTM=VTM(:,i0);
kTM=kTM(1:(4*m+2));
dTM=dTM(1:(4*m+2));
VTM=VTM(:,1:(4*m+2));