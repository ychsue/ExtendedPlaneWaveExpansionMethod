function vrr=vrr(K,k,phiK,x,y,cases)
global ep1
switch cases
case 'E'
    %\Sigma_{K'}(k_j+K'_j)E_k(K')e^{iK'.r}
    vrr(1)=i*exp(i*(x*((K(:,1))'+k(1))+y*((K(:,2))'+k(2))))*(diag(K(:,1))*phiK+phiK*k(1));
    vrr(2)=i*exp(i*(x*((K(:,1))'+k(1))+y*((K(:,2))'+k(2))))*(diag(K(:,2))*phiK+phiK*k(2));
case 'H'
    vrr(1)=i*exp(i*(x*((K(:,1))'+k(1))+y*((K(:,2))'+k(2))))*inv(ep1)*(diag(K(:,1))*phiK+phiK*k(1));
    vrr(2)=i*exp(i*(x*((K(:,1))'+k(1))+y*((K(:,2))'+k(2))))*inv(ep1)*(diag(K(:,2))*phiK+phiK*k(2));
    
end