function [R,T]=abcd(k,V,omega,ky,ep)
% Date 02/08/14 to solve the continue's matrix
global K m ep1;
Ky=round(ky);
ky=ky-Ky;
msum=zeros((2*m+1),(2*m+1)^2);for i0=1:(2*m+1),msum(i0,((i0-1)*(2*m+1)+1):(i0*(2*m+1)))=1;end;
abcd1=[-eye(2*m+1) , msum*V(:,1:(2*m+1)) ; diag(sqrt(omega^2-((-m:m)+ky).^2)) ,...
        msum*(inv(ep)*(diag(K(:,1))*V(:,1:(2*m+1))+V(:,1:(2*m+1))*diag(k(1:(2*m+1)))))];
input=[zeros(4*m+2,1)];input(Ky+m+1)=1;input(Ky+3*m+2)=sqrt(omega^2-(ky+Ky)^2);
output=abcd1\input;
R=output(1:(2*m+1));
T=output((2*m+2):(4*m+2));