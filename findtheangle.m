function [angle,km1]=findtheangle(kT,theta,mlk)
%Usage  kT = the cell of kTE or kTM to find the angle
%       theta = 1xn matrix
%       mlk = the number of elements in kT{1}
%angle is the max point we need
%km1 is the # of k^-1
km1=0;
%for i0=1:length(theta)
for i0=1:13
    i1=abs(real(kT{i0}))<=0.51/cos(theta(i0));
    buf=sort(abs(imag(kT{i0}(i1))));
    if km1 < buf(1)
        angle = theta(i0);
        km1 = buf(1);
    end
end
km1=1/km1;