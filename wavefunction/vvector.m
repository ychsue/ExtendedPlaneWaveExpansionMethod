function vvector
global ep1
cd ..;
load test;
cd wavefunction;
i0=1; %the set of ky
i1=7; %the set of kx
% X=[0:0.05:1]*pi*2;
% Y=[-1:0.05:1]*pi*2;
X=[0.1:0.01:0.2]*2*pi;
Y=[-0.1:0.005:-0.0]*2*pi;

k(2)=kym(i0);
k(1)=kTE{i0}(i1);
phiK=VTE{i0}(:,i1);
i0=1;
for x=X
    i1=1;
    for y=Y
        phirr(i1,i0)=phir(K,k,phiK,x,y);
        buffer=vrr(K,k,phiK,x,y,'E');
        %vrrx(i1,i0)=real(buffer(1));
        %vrry(i1,i0)=real(buffer(2));

        buffer=-i*phirr(i1,i0)'*buffer;
        vrx(i1,i0)=real(buffer(1));
        vry(i1,i0)=real(buffer(2));
        i1=i1+1;
    end
    i0=i0+1;
end
[x,y]=meshgrid(X,Y);
figure;
subplot(2,2,1);
contour(x/2/pi,y/2/pi,abs(phirr).^2);title('Abs. Value');axis equal;
subplot(2,2,2);
contour(x/2/pi,y/2/pi,real(phirr));title('Real part');axis equal;
subplot(2,2,3);
contour(x/2/pi,y/2/pi,imag(phirr));title('Imaginary part');axis equal;

figure;
%subplot(2,1,1);
quiver(x/2/pi,y/2/pi,vrx,vry);axis equal;
%subplot(2,1,2);
%quiver(x/2/pi,y/2/pi,vrrx,vrry);