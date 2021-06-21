function ep=epslonm1(kx,ky,cases)
%the unit of k = 2\pi/a
%            r = a
switch deblank(cases(1,:))
case 'cylinder'
    %cylinder with radius =r;
    k=sqrt(kx.^2+ky.^2);
%     eb=1;
%     eab=1/11.43-1;
    %eab=0;
    eb=1/2.72;
    eab=1-1/2.72;
%     r=0.15;
    r=0.504/1.17;
%    ep=eab*r*besselj(1,2*pi*k*r)./k;
    ep=eab*r*besselj(1,2*pi*k*r)./k.*cos(pi*kx);
    ep(k==0)=(eb+eab*pi*r^2);
case 'cylinder1'
    %cylinder with radius =r;
    k=sqrt(kx.^2+ky.^2);
    eb=1;
    eab=1/11.43-1;
    %eab=0;
    r=0.15;
    ep=2*eab*r*besselj(1,2*pi*k*r)./k.*cos(pi/2*(kx+ky));
    ep(k==0)=(eb+2*eab*pi*r^2);    
case 'square'
    %square with width =a;
    k=sqrt(kx.^2+ky.^2);
    eb=1;
    eab=11/11.43-1;
    
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
    eab=1/11.43-1;
    
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