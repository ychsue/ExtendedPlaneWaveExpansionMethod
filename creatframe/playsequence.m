function playsequence(num,a,fun,varargin)
%This function make a sequence parameters' input
%usage: playsequence(0,[1 2 4],'summ',1:3,2:3,4,2:5)
%	it will evaluate summ(x,y,4,z) for x=1:3
%	y=2:3 and z=2:5.
%
%note: the first number must be 0, if not,
%	it will cause something unstable.
b=num+1;
if b<=length(a) & a~=0;
   k=varargin{a(b)};
   for i=k;
      varargin{a(b)}=[i];
      playsequence(b,a,fun,varargin{:});
   end
else
   %varargin
   if strcmp(get(findobj(gcf,'tag','magic'),'userdata'),'yes') % added 2008/03/05
     eval([fun,'(varargin{:})']);
   else %added 2008/03/05
     eval([fun,'(varargin{2:2:length(varargin)})']);
   end
end
return