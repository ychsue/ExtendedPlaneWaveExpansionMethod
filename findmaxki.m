function [ kTi,omegaout ] = findmaxki( o1,o2,omega,kT )
%FINDMAXKI Summary of this function goes here
%Date:  2002/09/08
%  Detailed explanation goes here
%   Usage:  Used to find the max kTi output from fig.6
kTi=0;
[buf,i0]=sort(abs(omega-o1));
o1=i0(1);
[buf,i0]=sort(abs(omega-o2));
o2=i0(1);

for i0=o1:o2
    buf=sort(abs(imag(kT{i0})));
    if kTi < buf(1)
        kTi=buf(1);
        omegaout=i0;
    end
end
omegaout=omega(omegaout);