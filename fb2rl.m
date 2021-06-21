function [r,l]=fb2rl(f,b)
%%  f = filling factor
%%  b = 2r/l
%%  l = cubic's width
%%  r = cylinder's radius
l=sqrt(f/(1+pi*b^2/4));
r=b*l/2;