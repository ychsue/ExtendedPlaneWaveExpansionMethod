function incident( omega,ky0,dk,N )
%INCIDENT Summary of this function goes here
%  Detailed explanation goes here
kx0=sqrt(omega^2-ky0^2);
kperp=[-ky0,kx0];
k=ones((2*N+1),1)*[kx0 ky0];
k=k+(dk*(-N:N)/N)'*kperp;   %The incident wave's k
weight=abs(abs(-N:N)-N+1)/(N-1);    %The weight of per incident wave


%%%%%%%//   plot the |E|^2 or |H|^2 \\%%%%%%%%%%
[x0,y0]=meshgrid(-100:1:100);
psi=exp(i*(k(1,1)*x0+k(1,2)*y0))*weight(1);
for i0=2:(2*N+1)
    psi=psi+exp(i*(k(i0,1)*x0+k(i0,2)*y0))*weight(i0);
end
pcolor(x0,y0,abs(psi).^2);
shading interp;
colormap(hsv);
%%%%%%%\\   plot the |E|^2 or |H|^2 //%%%%%%%%%%