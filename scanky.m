function scanky( filename )
%SCANKY Summary of this function goes here
%This function created at 2002/08/27 for finding the det|A|=0
%  Detailed explanation goes here
eval(['load ',filename]);
omega=inputdata{8};
m=inputdata{2};
msum=zeros((2*m+1),(2*m+1)^2);for i0=1:(2*m+1),msum(i0,((i0-1)*(2*m+1)+1):(i0*(2*m+1)))=1;end;
%for ky=kym;
for i0=1:length(kym);
    ky=kym(i0);
    Ky=round(ky);
    ky=ky-Ky;
    for i1=1:2
        if i1==1
            k=kTE{i0};V=VTE{i0};ep=1;
        else
            k=kTM{i0};V=VTM{i0};ep=ep1;
        end
        abcd1=[-eye(2*m+1) , msum*V(:,1:(2*m+1)) ; diag(sqrt(omega^2-((-m:m)+ky).^2)) ,...
                msum*(inv(ep)*(diag(K(:,1))*V(:,1:(2*m+1))+V(:,1:(2*m+1))*diag(k(1:(2*m+1)))))];
        deta(i1,i0)=det(abcd1);
    end
end
figure;plot(kym,real(deta));title('real');
figure;plot(kym,imag(deta));title('imag');
figure;plot(kym,abs(deta));title('abs');
eval(['save data/det',printdata(inputdata{:}) ,' deta inputdata']);