function drawequalw2(kTE,kTM,ky,mlk,eps1);
%Usage: kTE:    TE Mode's k
%       kTM:    TM Mode's k
%       theta:  the angle of \theta
%       eps1:   permutation of image part
%       mlk:    possible maxium length of k
global m;
%       m:      max(|K|)
lk=length(kTE);
lenm=4*m+2;
kTED=[];
kTMD=[];
kTEDi=[];
kTMDi=[];
buffer=ones(mlk,1);
buffer1=buffer;
for i0=1:lk
    buffer=kTE{i0};
    i1=abs(imag(buffer))<eps1;
    buffer1=real(buffer);
    buffer1(~i1)=NaN;
    if length(buffer1)<lenm,buffer1(length(buffer1)+1:lenm)=NaN;end;
    kTED=[kTED;buffer1'];
    buffer(i1)=NaN;
    if length(buffer)<lenm,buffer(length(buffer)+1:lenm)=NaN;end;
    kTEDi=[kTEDi;buffer'];
    
    buffer=kTM{i0};
    i1=abs(imag(buffer))<eps1;
    buffer1=real(buffer);
    buffer1(~i1)=NaN;
    if length(buffer)<lenm,buffer1(length(buffer)+1:lenm)=NaN;end;
    kTMD=[kTMD;buffer1'];
    buffer(i1)=NaN;
    if length(buffer)<lenm,buffer(length(buffer)+1:lenm)=NaN;end;
    kTMDi=[kTMDi;buffer'];

end
%figure;plot(ky'*ones(1,mlk),kTED,'.');title('TE Mode');axis equal;
figure;plot(kTED,ky'*ones(1,mlk),'.');title('TE Mode');axis equal;
line([-0.5 0.5;0.5 0.5;0.5 -0.5;-0.5 -0.5],[-0.5 -0.5;-0.5 0.5;0.5 0.5;0.5 -0.5]);
%figure;plot(ky'*ones(1,mlk),kTMD,'.');title('TM Mode');axis equal;
figure;plot(kTMD,ky'*ones(1,mlk),'.');title('TM Mode');axis equal;
line([-0.5 0.5;0.5 0.5;0.5 -0.5;-0.5 -0.5],[-0.5 -0.5;-0.5 0.5;0.5 0.5;0.5 -0.5]);
%figure;plot(ky'*ones(1,mlk),real(kTEDi),'.');title('TE Mode(complex)');axis equal;
figure;plot(kTEDi,ky'*ones(1,mlk),'.');title('TE Mode(complex)');axis equal;
line([-0.5 0.5;0.5 0.5;0.5 -0.5;-0.5 -0.5],[-0.5 -0.5;-0.5 0.5;0.5 0.5;0.5 -0.5]);
%figure;plot(ky'*ones(1,mlk),real(kTMDi),'.');title('TM Mode(complex)');axis equal;
figure;plot(kTMDi,ky'*ones(1,mlk),'.');title('TM Mode(complex)');axis equal;
line([-0.5 0.5;0.5 0.5;0.5 -0.5;-0.5 -0.5],[-0.5 -0.5;-0.5 0.5;0.5 0.5;0.5 -0.5]);