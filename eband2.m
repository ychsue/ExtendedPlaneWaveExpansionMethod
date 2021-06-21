function eband2(varargin)
%The unit of \omega = 2\pic/a
%            \mu    = \mu_0
%            \epslon= \epslon_0
%            k      = 2\pi/a
%where 'a' is the unit length of unit cell.

%The given data
m=varargin{2};
fftpattern=varargin{6};

time=now;
omegaTM=[];
omegaTE=[];

%Reciprocal lattice
[kx,ky]=meshgrid(-m:0.5:m,-m:m);
K=[kx(:),ky(:)];
Kp=K;
%The K-K'
[Kxp,Kx]=meshgrid(Kp(:,1),K(:,1));
[Kyp,Ky]=meshgrid(Kp(:,2),K(:,2));
%Get the \epslon(K)
ep1=epslon1(Kx-Kxp,Ky-Kyp,fftpattern);

%Give a k
for l=0:0.05:0.5;
    %0:0.25:1.5;
    if l<=0.5
        k=[1,0]*l;
    elseif l<=1;
        k=[0.5,l-0.5];
    else
        k=[0.5,0.5]-[1,1]*(l-1);
    end
    
    %find \omega^2
    kk=ones(length(K(:,1)),1)*k;
    [HkTM,omegaTM2]=eig((kk+K)*((kk+Kp)').*inv(ep1));
    [HkTE,omegaTE2]=eig(diag(diag((kk+K)*((kk+Kp)'))),ep1);
    
    
    omegaTM=[omegaTM diag(sqrt(omegaTM2))];
    omegaTE=[omegaTE diag(sqrt(omegaTE2))];
end
figure;
plot(real(sort(omegaTM)'));
ylim([0,1.2]);
title('TM sort mode');
figure;
plot(real(sort(omegaTE)'));
printdata(varargin{:});
ylim([0,1.2]);
title('TE sort mode');
time=now-time
inputdata=varargin;
eval(['save data/eband',printdata(varargin{:}) ,' omegaTE omegaTM ep1 inputdata']);