function incident( m,fftpattern,omega,ky0,dky,N,x,y,mode )
%Usage: incident( m,fftpattern,omega,ky0,dky,N,x,y,mode )
%  Input: 
%    m:     Gx and Gy are -m to m
%    fftpattern: the pattern of epsilon
%    omega: the frequency
%    ky0:   the incident wave's ky
%    dky:   the region of ky= ky0-dky -> ky0+dky
%    N:     2N+1 is the number of segments of ky
%    x,y:   (nx1) a region for plotting
%    mode:  'TM' or 'TE'
%Example: incident(3,'cylinder',0.5,0.41,0.08,7,-50:50,-50:50,'TE')

global K ep1;

%The given data
%m=3;
%fftpattern='cylinder';

time=now;
%Give the \theta's cell
i1=1;
%lky=length(kym);
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
ep1=epslon1(Kx-Kxp,Ky-Kyp,fftpattern);


%INCIDENT Summary of this function goes here
%  Detailed explanation goes here
theta0=asin(ky0/omega);
if abs(ky0+dky)>=omega
    dky=sign(ky0+dky)*omega;
else
    dky=ky0+dky;
end
theta1=asin(dky/omega);
theta=[theta1+[0:(2*N)]/(N+eps)*(theta0-theta1)]';
k=omega*[cos(theta) sin(theta)];            %The incident wave's k
weight=abs(abs(-N:N)-N-1-eps)/(N+1+eps);    %The weight of per incident wave

checkEm=[];checkMm=[];
RTEm=[];TTEm=[];RTMm=[];TTMm=[];
psir=zeros(length(y),length(x));

for ky=k(:,2)'
     %Solve the TE and TM Mode
    [kTEa,VTEa,kTMa,VTMa,dTEa,dTMa]=ymode(ky,omega);
    [rTEa,tTEa]=abcd(kTEa,VTEa,omega,ky,1);
    [rTMa,tTMa]=abcd(kTMa,VTMa,omega,ky,ep1);
    [ checkE,checkM,RTE,TTE,RTM,TTM ] = conservation( rTEa,tTEa,rTMa,tTMa,dTEa,dTMa,ky,omega );
     kTE{i1}=kTEa;   VTE{i1}=VTEa; kTM{i1}=kTMa;    VTM{i1}=VTMa;
    rTE{i1}=rTEa;   tTE{i1}=tTEa;   rTM{i1}=rTMa;   tTM{i1}=tTMa;
    checkEm=[checkEm checkE];checkMm=[checkMm checkM];
    RTEm=[RTEm RTE];TTEm=[TTEm TTE];RTMm=[RTMm RTM];TTMm=[TTMm TTM];

    %%%%%// The wave function   \\%%%%%%
    kr=[-sqrt(omega^2-((-m:m)+ky).^2).', ((-m:m)+ky).'];
    switch mode
      case 'TM'
        psir=psir+psi(x,y,k(i1,:),kr,kTMa(1:(2*m+1)),VTMa(:,1:(2*m+1)),rTMa,tTMa)*weight(i1);
      case 'TE'
        psir=psir+psi(x,y,k(i1,:),kr,kTEa(1:(2*m+1)),VTEa(:,1:(2*m+1)),rTEa,tTEa)*weight(i1);
    end
    %%%%%\\ The wave function   //%%%%%%
    i1=i1+1;
end


%%%%%%%//   plot the |E|^2 or |H|^2 \\%%%%%%%%%%
 [x0,y0]=meshgrid(x,y);
% psir=exp(i*(k(1,1)*x0+k(1,2)*y0))*weight(1);
% for i0=2:(2*N+1)
%     psir=psir+exp(i*(k(i0,1)*x0+k(i0,2)*y0))*weight(i0);
% end
figure;
mesh(x0,y0,abs(psir).^2);
figure;
pcolor(x0,y0,abs(psir).^2);line([0 0],[y(1) y(length(y))]);
shading interp;
colormap(hsv);
figure;
plot(checkEm);title('check EM');
figure;
plot(checkMm);title('check TM');
%eval(['save data/incident',' checkEm checkMm rTE tTE rTM tTM RTEm TTEm RTMm TTMm K ky kTE kTM VTE VTM ep1 ']);
time=now-time
%%%%%%%\\   plot the |E|^2 or |H|^2 //%%%%%%%%%%