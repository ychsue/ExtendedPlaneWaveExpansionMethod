function plotkmin(kTE,kTM,theta,mlk,eps1);
%Usage: kTE:    TE Mode's k
%       kTM:    TM Mode's k
%       theta:  the angle of \theta
%       eps1:   permutation of image part
%       mlk:    possible maxium length of k
% for example: plotkmin(kTE,kTM,thetam,inputdata{2},1e-5);
lk=length(kTE);
kTED=[];
kTMD=[];
kTEDi=[];
kTMDi=[];
buffer=ones(mlk,1);
buffer1=buffer;
for i0=1:lk
    i1=abs(imag(kTE{i0}))<eps1;
    buffer=kTE{i0};
    buffer1(~i1)=buffer(~i1);
    buffer1(i1)=NaN;
    buffer1(length(kTE{i0})+1:mlk)=NaN;
    kTEDi=[kTEDi;buffer1'];
    buffer(i1)=real(buffer(i1));
    buffer(~i1)=NaN;
    buffer(length(kTE{i0})+1:mlk)=NaN;
    if length(buffer(1,:))~=1
        kTED=[kTED;buffer];
    else
        kTED=[kTED;buffer'];
    end
    
    i1=abs(imag(kTM{i0}))<eps1;
    buffer=kTM{i0};
    buffer1(i1)=NaN;
    buffer1(~i1)=buffer(~i1);
    buffer1(length(kTM{i0})+1:mlk)=NaN;
    kTMDi=[kTMDi;buffer1'];
    buffer(i1)=real(buffer(i1));
    buffer(~i1)=NaN;
    buffer(length(kTM{i0})+1:mlk)=NaN;
    if length(buffer(1,:))~=1
        kTMD=[kTMD;buffer];
    else
        kTMD=[kTMD;buffer'];
    end
end
%%%%%%%%//  take the kimin for TE and TM mode   \\%%%%%%
kTEimin=[];
kTMimin=[];
for i0=1:length(theta)
    buf=kTEDi(i0,:)+i/eps1*(kTEDi(i0,:)==NaN);
    buf=buf( abs(real(buf)*cos(theta(i0)))<=(0.5+eps1) & ...
        abs(real(buf)*sin(theta(i0)))<=(0.5+eps1) );
    [buf1,i1]=sort(abs(imag(buf)));
    kTEimin=[kTEimin [buf(i1(1)) -buf(i1(1))]'];
    
    buf=kTMDi(i0,:)+i/eps1*(kTMDi(i0,:)==NaN);
    buf=buf( abs(real(buf)*cos(theta(i0)))<=(0.5+eps1) & ...
        abs(real(buf)*sin(theta(i0)))<=(0.5+eps1) );
    [buf1,i1]=sort(abs(imag(buf)));
    kTMimin=[kTMimin [buf(i1(1)) -buf(i1(1))]'];
end
figure;polar1(ones(2,1)*theta,imag(kTEimin),40); axis equal;
figure;polar1(ones(2,1)*theta,real(kTEimin),40); hold on;
xlim([-0.5 0.5]);ylim([-0.5 0.5]);axis equal;
polar(theta'*ones(1,2*(2*mlk+1)^2),real(kTEDi),'.');title('E-Polarization(complex)');hold off;
line([-0.5 0.5 0.5 -0.5 -0.5],[-0.5 -0.5 0.5 0.5 -0.5]);
figure;polar1(theta'*ones(1,2*(1+2*mlk)^2),kTED,20);title('E-Polarization(real)');
xlim([-0.5 0.5]);ylim([-0.5 0.5]);axis equal;
line([-0.5 0.5 0.5 -0.5 -0.5],[-0.5 -0.5 0.5 0.5 -0.5]);

figure;polar1(ones(2,1)*theta,imag(kTMimin),40); axis equal;
figure;polar1(ones(2,1)*theta,real(kTMimin),40); hold on;
xlim([-0.5 0.5]);ylim([-0.5 0.5]);axis equal;
polar(theta'*ones(1,2*(2*mlk+1)^2),real(kTMDi),'.');title('H-Polarization(complex)');hold off;
line([-0.5 0.5 0.5 -0.5 -0.5],[-0.5 -0.5 0.5 0.5 -0.5]);
figure;polar1(theta'*ones(1,2*(1+2*mlk)^2),kTMD,20);title('H-Polarization(real)');
xlim([-0.6 0.6]);ylim([-0.6 0.6]);axis equal;
line([-0.5 0.5 0.5 -0.5 -0.5],[-0.5 -0.5 0.5 0.5 -0.5]);

%%%%%%%%\\  take the kimin for TE and TM mode   //%%%%%%
%figure;
% subplot(2,2,1);
% polar(theta'*ones(1,mlk),kTED,'.');title('(a)');
% %figure;
% subplot(2,2,2);
% polar(theta'*ones(1,mlk),kTMD,'.');title('(c)');
% %figure;
% subplot(2,2,3);
% polar(theta'*ones(1,mlk),real(kTEDi),'.');title('(b)');
% %figure;
% subplot(2,2,4);
% polar(theta'*ones(1,mlk),real(kTMDi),'.');title('(d)');
% figure;polar(theta'*ones(1,mlk),kTED,'.');title('E-Polarization');
% figure;polar(theta'*ones(1,mlk),kTMD,'.');title('H-Polarization');
% figure;polar(theta'*ones(1,mlk),real(kTEDi),'.');title('E-Polarization(complex)');
% figure;polar(theta'*ones(1,mlk),real(kTMDi),'.');title('H-Polarization(complex)');

function polar1(rho,r,fs)
x=r(:).*cos(rho(:));
y=r(:).*sin(rho(:));
line(x,y,'linestyle','.','markersize',fs);
set(gca,'fontsize',16);