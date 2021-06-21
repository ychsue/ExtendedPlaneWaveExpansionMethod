function ep=epslon1(kx,ky,cases)
%the unit of k = 2\pi/a
%            r = a
switch deblank(cases(1,:))
case 'cylinder'
    %cylinder with radius =r;
    k=sqrt(kx.^2+ky.^2);
     eb=1;
     eab=11;%10.43;
    r=0.2;
%    r=0.504/1.17;
    ep=eab*r*besselj(1,2*pi*k*r)./k;
%    ep=eab*r*besselj(1,2*pi*k*r)./k.*cos(pi*kx);
    ep(k==0)=(eb+eab*pi*r^2);
case 'sakoda'
    %the figure 4.3 and 4.4 of Sakoda
    %cylinder with radius =r;
    k=sqrt(kx.^2+ky.^2);
%     eb=2.1;
%     eab=-1.1;
%     r=0.5/sqrt(pi);
   eb=2.72;
   eab=1-2.72;
   r=0.18;
%    r=0.504/1.17;
%    ep=eab*r*besselj(1,2*pi*k*r)./k.*cos(pi*kx); %As paper show
    ep=eab*r*besselj(1,2*pi*k*r)./k;  %Cut through the center
    ep(k==0)=(eb+eab*pi*r^2);
case 'cylinder1'
    %2 cylinders with radius =r;
    k=sqrt(kx.^2+ky.^2);
    eb=1;
    eab=10.43;
    %eab=0;
    r=0.18;
    ep=2*eab*r*besselj(1,2*pi*k*r)./k.*cos(pi/2*(kx+ky));
    ep(k==0)=(eb+2*eab*pi*r^2);    
case 'cylinder2'
    %2 cylinders with radius =r;
    k=sqrt(kx.^2+ky.^2);
    eb=1;
    eab=10.43;
    %eab=0;
    r=0.18;
     ep=eab*r*besselj(1,2*pi*k*r)./k.*(1+cos(2*pi*kx))/2;
    ep(k==0)=(eb+eab*pi*r^2);    
case 'cylinder3'
    %2 cylinders with radius =r;
    k=sqrt(kx.^2+ky.^2);
    eb=1;
    eab=11;
    %eab=0;
    r=0.35/sqrt(2);
     ep=eab*r*besselj(1,2*pi*k*r)./k.*(1+exp(i*pi*(kx+ky)));
    ep(k==0)=(eb+2*eab*pi*r^2);    
case 'square'
    %square with width =a;
    k=sqrt(kx.^2+ky.^2);
    eb=1;
    eab=10.43;
    
    a=0.2659;
    ep=eab/(pi^2)*sin(pi*(kx+eps)*a).*sin(pi*(ky+eps)*a)./(kx+eps)./(ky+eps)+eb.*(kx==0 & ky==0);
case 'none'
%    ep=1.7373*eye(length(kx));
    ep=eye(length(kx));
case 'cmovey'
    f=str2num(cases(2,:));
    b=str2num(cases(3,:));
    [r,a]=fb2rl(f,b);
    move=str2num(cases(4,:));
    theta=str2num(cases(5,:));
    k=sqrt(kx.^2+ky.^2);
    eb=1;
    eab=10.4;
    
%    a=0.475;
    %%Cylinder
%    r=0.365*a;
    ep=eab*r*besselj(1,2*pi*k*r)./k;
    ep=ep.*exp(i*2*pi*(kx*cos(theta)+ky*sin(theta))*move);
    %%Cubic
    ep=ep+...
        real(exp(i*pi*(kx+ky))).*(eab/(pi^2)*sin(pi*(kx+eps)*a).*sin(pi*(ky+eps)*a)./(kx+eps)./(ky+eps));    
    ep(k==0)=(eb+eab*pi*r^2+eab*a^2);

otherwise
%     lcx=length(fftz(:,1));cy=(length(fftz(1,:))+1)/2;
%     ep=fftz(lcx*(kx+(lcx-1)/2)+ky+cy);
    eval(['global ',cases]);
    eval(['lcx=length(',cases,'(:,1));cy=(length(',cases,'(1,:))+1)/2;']);
    eval(['ep=',cases,'(lcx*(kx+(lcx-1)/2)+ky+cy);']);
end