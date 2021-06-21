function o2k(varargin)
%Usage:     give the ky to solve the kx
%The unit of \omega = 2\pic/a
%            \mu    = \mu_0
%            \epslon= \epslon_0
%            k      = 2\pi/a
%where 'a' is the unit length of unit cell.
global K m ep1;

%The given data
m=varargin{2};
fftpattern=varargin{6};
omega=varargin{8};
kym=varargin{10};

time=now;
%Give the \ky's cell
i1=1;
lky=length(kym);
%Reciprocal lattice
[Kx,Ky]=meshgrid(-m:m,-m:m);
K=[Kx(:),Ky(:)];
Kp=K;
%The K-K'
[Kxp,Kx]=meshgrid(Kp(:,1),K(:,1));
[Kyp,Ky]=meshgrid(Kp(:,2),K(:,2));
%Get the \epslon(K)
ep1=epslon1(Kx-Kxp,Ky-Kyp,fftpattern);


%Give a ky to solve kx
for ky=kym;
    
    %Solve the TE and TM Mode
    [kTEa,VTEa,kTMa,VTMa]=ymode(ky,omega);
     kTE{i1}=kTEa;   HTE{i1}=VTEa; kTM{i1}=kTMa;    HTM{i1}=VTMa;

    i1=i1+1;
end
drawequalw2(kTE,kTM,kym,2*((2*m+1)^2),10^(-5));
time=now-time
inputdata=varargin;
eval(['save data\o2k',printdata(varargin{:}) ,' kTE kTM ep1 inputdata']);
