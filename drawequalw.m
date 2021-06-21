function drawequalw(kTE,kTM,theta,mlk,eps1);
%Usage: kTE:    TE Mode's k
%       kTM:    TM Mode's k
%       theta:  the angle of \theta
%       eps1:   permutation of image part
%       mlk:    possible maxium length of k
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
figure;
subplot(2,2,1);
polar(theta'*ones(1,mlk),kTED,'.');title('(a)');
%figure;
subplot(2,2,2);
polar(theta'*ones(1,mlk),kTMD,'.');title('(c)');
%figure;
subplot(2,2,3);
polar(theta'*ones(1,mlk),real(kTEDi),'.');title('(b)');
%figure;
subplot(2,2,4);
polar(theta'*ones(1,mlk),real(kTMDi),'.');title('(d)');
% figure;polar([theta'*ones(1,mlk);pi+theta'*ones(1,mlk)],kTED,'.');title('TE Mode');
% figure;polar([theta'*ones(1,mlk);pi+theta'*ones(1,mlk)],kTMD,'.');title('TM Mode');
% figure;polar([theta'*ones(1,mlk);pi+theta'*ones(1,mlk)],real(kTEDi),'.');title('TE Mode(complex)');
% figure;polar([theta'*ones(1,mlk);pi+theta'*ones(1,mlk)],real(kTMDi),'.');title('TM Mode(complex)');