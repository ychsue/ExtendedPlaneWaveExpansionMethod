function test
cd ..;
load test;
cd wavefunction;
i0=1; %the set of ky
i1=6; %the set of kx
X=[0:1:10];
Y=[-10:1:10];

k(2)=kym(i0);
k(1)=kTE{i0}(i1);
phiK=VTE{i0}(:,i1);
i0=1;
for x=X
    i1=1;
    for y=Y
        phirr(i1,i0)=phir(K,k,phiK,x,y);
        i1=i1+1;
    end
    i0=i0+1;
end
[x,y]=meshgrid(X,Y);
figure;surf(x/2/pi,y/2/pi,abs(phirr).^2);
figure;surf(x/2/pi,y/2/pi,real(phirr));