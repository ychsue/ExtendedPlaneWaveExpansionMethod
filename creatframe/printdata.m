%Usage: print the variables of creatframe in figure
%       a=printdata(varargin{:})
function varargout=printdata(varargin)
len=floor(length(varargin)/2);
indt=1:len;
for i0=indt;
    ind(i0)=(length(varargin{2*i0})==1 | ...
      (strcmp(class(varargin{2*i0}),'char') & ~(strcmp(varargin{2*i0-1},'mgwd')) & ~(strcmp(varargin{2*i0-1},'folder'))) );
end
data=[];
indt=indt(ind);
if nargout==0
    for i0=indt;
        data=[data varargin{2*i0-1},'=',num2str(varargin{2*i0}),'\newline'];
    end
    text(0,0.5,data);
else
    for i0=indt;
        data=[data varargin{2*i0-1},'=',num2str(varargin{2*i0})];
    end
    data=data(data~='\'&data~=' '&data~='^'&data~='*'&data~='|');
    data(data=='/')='d';
    data(data=='.')='_';
    varargout{1}=data;
end
return