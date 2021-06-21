function o2kr(varargin)
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
thetam=varargin{10};
folder=varargin{12};

time=now;
%Give the \theta's cell
i1=1;
%Reciprocal lattice
[Kx,Ky]=meshgrid(-m:m,-m:m);
K=[Kx(:),Ky(:)];
Kp=K;
%The K-K'
[Kxp,Kx]=meshgrid(Kp(:,1),K(:,1));
[Kyp,Ky]=meshgrid(Kp(:,2),K(:,2));
%Get the \epslon(K)
ep1=epslon1(Kx-Kxp,Ky-Kyp,fftpattern);


%Give a theta to solve k
for theta=thetam;
    
    %Solve the TE and TM Mode
    [kTEa,VTEa,kTMa,VTMa]=ymode1(theta,omega);
     kTE{i1}=kTEa;   VTE{i1}=VTEa; kTM{i1}=kTMa;    VTM{i1}=VTMa;

    i1=i1+1;
end
drawequalw(kTE,kTM,thetam,2*((2*m+1)^2),10^(-5));
time=now-time
inputdata=varargin;
if ~isempty(folder)
  eval(['save ',folder,'/o2kr',printdata(varargin{:}) ,'K thetam VTE VTM kTE kTM ep1 inputdata']);
end
