function interface2omega1(varargin)
%Usage:     give the ky to solve the interface's solution
%The unit of \omega = 2\pic/a
%            \mu    = \mu_0
%            \epslon= \epslon_0
%            k      = 2\pi/a
%where 'a' is the unit length of unit cell.
global K m ep1;

%The given data
m=varargin{2};
fftpattern=varargin{6};
omegam=varargin{8};
ky=varargin{10};

time=now;
%Give the \theta's cell
i1=1;
lomega=length(omegam);
%Reciprocal lattice
[Kx,Ky]=meshgrid(-m:m,-m:m);
%Simplify the calculation in E^*xH
Kx=Kx';
Ky=Ky';
K=[Kx(:),Ky(:)];
Kp=K;
%The K-K'
[Kxp,Kx]=meshgrid(Kp(:,1),K(:,1));
[Kyp,Ky]=meshgrid(Kp(:,2),K(:,2));
%Get the \epslon(K)
ep1=inv(epslonm1(Kx-Kxp,Ky-Kyp,fftpattern));


%Give a k_y to solve k_x
checkEm=[];checkMm=[];
RTEm=[];TTEm=[];RTMm=[];TTMm=[];
for omega=omegam;
    
    %Solve the TE and TM Mode
    [kTEa,VTEa,kTMa,VTMa,dTEa,dTMa]=ymode(ky,omega);
    [rTE,tTE]=abcd(kTEa,VTEa,omega,ky,1);
    [rTM,tTM]=abcd(kTMa,VTMa,omega,ky,ep1);
    [ checkE,checkM,RTE,TTE,RTM,TTM ] = conservation( rTE,tTE,rTM,tTM,dTEa,dTMa,ky,omega );
     kTE{i1}=kTEa;   VTE{i1}=VTEa; kTM{i1}=kTMa;    VTM{i1}=VTMa;
    checkEm=[checkEm checkE];checkMm=[checkMm checkM];
    RTEm=[RTEm RTE];TTEm=[TTEm TTE];RTMm=[RTMm RTM];TTMm=[TTMm TTM];
    i1=i1+1;
end
figure;plot([omegam;omegam]', [TTEm;TTMm]');
figure;plot([omegam;omegam]', [checkEm;checkMm]');
time=now-time
inputdata=varargin;
eval(['save data/interface2omega',printdata(varargin{:}) ,' checkEm checkMm RTEm TTEm RTMm TTMm K ky kTE kTM VTE VTM ep1 inputdata']);