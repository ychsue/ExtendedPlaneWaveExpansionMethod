function playwithpararegion(fun);
a=get(gcf,'UserData');
tagn=length(a)/2;
n=1;
b=[0];
for i=0:tagn-1;
   if get(findobj(gcf,'Tag',['check',mat2str(i)]),'Value');
      b(n)=2*i+2;
      n=n+1;
   end
end
   playsequence(0,b,fun,a{:});
return