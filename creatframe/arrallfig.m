function arrallfig(a,action)
allfigure=get(0,'Children');
screenxy=get(0,'ScreenSize');
len=length(allfigure);
if strcmp(action,'arrange')
   xysec=floor(sqrt(len-2))+1; %Plot in xysec * xysec
   lenx=screenxy(3)/xysec; %The x screen length of one figure
   leny=0.9*screenxy(4)/xysec; %The y screen length of one figure
   yplot=0;
   for i=len:-1:1
      if allfigure(i)~=a
         y=1.1* mod(yplot,xysec)*leny;
         x= floor(yplot/xysec)*lenx;
         set(allfigure(i),'Position',[x screenxy(4)-1.1*leny-y lenx leny-screenxy(4)/20]);
         yplot=yplot+1;
      end
   end 
else
   for i=1:len
      if allfigure(i)~=a
         close(allfigure(i));   
      end
   end 
end
return