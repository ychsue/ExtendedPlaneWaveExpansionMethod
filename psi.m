function psir=psi(x,y,kin,kr,kt,V,r,t)
global K m ep1;
psir=[];
for x0=x
    buf=[];
    if x0<=0
        for y0=y
            buf=[buf; exp(i*(kin(1)*x0+kin(2)*y0))+exp(i*(kr(:,1)*x0+kr(:,2)*y0)).'*r]; 
        end
    else
        for y0=y
            buf=[buf; exp(i*(K(:,1)*x0+K(:,2)*y0)).'*V*diag(exp(i*(kt*x0+kin(2)*y0)))*t];
        end
    end
    psir=[psir buf];
end