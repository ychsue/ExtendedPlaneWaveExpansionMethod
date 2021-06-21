function phirr=phir(K,k,phiK,x,y)
%phirr=exp(i*r*(K'+[k(1);k(2)]*ones(1,length(K))))*phiK;
phirr=exp(i*(x*((K(:,1))'+k(1))+y*((K(:,2))'+k(2))))*phiK;