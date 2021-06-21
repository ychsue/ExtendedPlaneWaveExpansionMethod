function [kTE,VTE,kTM,VTM]=ymode1(theta,omega)
global K m ep1
    %Solve the TE Mode
    
    [VT,kT]=eig([zeros((2*m+1)^2),eye((2*m+1)^2);...
        1*(omega^2*ep1-1*diag(K(:,1).^2+K(:,2).^2)),-1*(2*(cos(theta)*diag(K(:,1))+sin(theta)*diag(K(:,2))))]);
    kTE=diag(kT);
    VT=VT(1:(2*m+1)^2,:);
    VT=VT*diag(1./sqrt(sum(abs(VT).^2)));
    [maxVT,idVT]=max(abs(VT));
    VTE=VT*diag(maxVT'./diag(VT(idVT,1:2*(2*m+1)^2)));
    
    %Solve the TM Mode
    
    [VT,kT]=eig([zeros((2*m+1)^2),eye((2*m+1)^2);ep1*(omega^2*eye((2*m+1)^2)-inv(ep1).*(K*K.')),...
        -ep1*(inv(ep1).*(cos(theta)*(K(:,1)*ones(1,(2*m+1)^2)+ones((2*m+1)^2,1)*K(:,1)')+sin(theta)*(K(:,2)*ones(1,(2*m+1)^2)+ones((2*m+1)^2,1)*K(:,2)')))]);
    kTM=diag(kT);
    VT=VT(1:(2*m+1)^2,:);
    VT=VT*diag(1./sqrt(sum(abs(VT).^2)));
    [maxVT,idVT]=max(abs(VT));
    VTM=VT*diag(maxVT'./diag(VT(idVT,1:2*(2*m+1)^2)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% The denote of direction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VTEi=[];VTMi=[];
% for i0=-m:m
%     i1=K(:,2)==i0;
%     VTEi=[VTEi;ones(2*m+1,1)*sum(VTE(i1,:))];
%     VTMi=[VTMi;ones(2*m+1,1)*sum(VTM(i1,:))];
% end
% 
% dTE=1/omega*diag(VTEi'*( diag(K(:,1))*VTE+VTE*diag(kTE) ));
% dTM=1/omega*diag(VTMi'*inv(ep1)*( diag(K(:,1))*VTM+VTM*diag(kTM) ));
% i0=abs(real(kTE))<=0.5;
% kTE=kTE(i0);
% dTE=dTE(i0);
% VTE=VTE(:,i0);
% i0=abs(real(kTM))<=0.5;
% kTM=kTM(i0);
% dTM=dTM(i0);
% VTM=VTM(:,i0);