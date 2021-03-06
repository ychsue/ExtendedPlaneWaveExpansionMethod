function creatframe(funname,numx,numy,varargin)
%This function is to make a frame to help us
%easily to input some parameters.
%
%usage:creatframe(funname,numx,numy,varargin)
%	funname -> the function you want to input some data
%	numx*numy -> the number of parameters' matrix 
%	varargin -> the parameters' name and value
%example: 'creatframe('example',3,3,'a',4,'mgwd','Small circle','b',3,'\theta',[-6*pi:0.1:6*pi])'

%n is the number of parameter
shiftxy=0.9*get(0,'ScreenSize');
shiftxy(2)=shiftxy(4)*0.01;

n=length(varargin)/2;
a=figure( 'UserData',varargin,... 
   'Visible','on',...
   'Position',shiftxy);
axes1=axes('Visible','off',...
   'position',[0 0 1 1]);
%figpos is the position of this figure
figpos=get(a,'Position');

if nargin==0
   strforhelp={'This function is to make a frame to help us easily to input some parameters.',
      'USAGE:creatframe(funname,numx,numy,varargin)',
      '	funname -> the function you want to input some data',
      '	numx*numy -> the number of parameters'' matrix ',
      '	varargin -> the parameters'' name and value',
      '	start button: 	to let the function running with the parameters you input,',
      '                 and if the check button of some parameters have been selected,',
      '                 it can also to calculate a sequence.',
      '	Arrangement button: 	to arrangement all figures except this one.',
      '	Close All Fig. button: 	to close all figures except this one.',
      '	Help button: 	Show this figure. Or you can show this by input ''creatframe;''',
      '	Close button: 	Close this figure.',
      ' Space region:   Input the function name for run.',
      ' Usage button:   Show the help of the input function.',
      '',
      'EXAMPLE: creatframe(''example'',3,3,''a'',4,''b'',3,''\\theta'',[-2*pi:0.1:2*pi])',
      '	It will work like example(''a'',4,''b'',3,''\\theta'',[-2*pi:0.1:2*pi])',
      '	On creatframe''s figure, you can see three parameter \alpha b c wait for you to input parameter',
      '',
      '',
      'NOTICE: (1)This Function need another three M-files: playsequence.m playwithpararegion.m and arrallfig.m',
      '	If not, you can''t use the button of ''play'' ''arra.'' and ''close all fig.''.',
      '         (2)Be careful to input the function name, make sure that you remember to add '' ''.',
      '         (3)You can change the color of parameters to notice where is it come,like',
      '	            creatframe(''example'',3,3,''a'',4,''mgwd'',''Small circle'',''b'',3,''\\theta'',[-2*pi:0.1:2*pi])',
      '         (4)You can mark the check box to run a sequence. Ex: change a from 4 to [3 4 5] and mark the check box',
      '         (5)[vari] is not equal to vari, ex: [cylinder] means run cylinder first, then put into the edit box',
      '             but cylinder means a string ''cylinder''',
      '',
      'Hsue Young-Chung, e-mail: hsuy1234@hotmail.com or ychsu.ep87g@nctu.edu.tw',
      'ps: I major in Applied Phys., if you have any problem on this program, please send an email to me.'};
   text('Position',[.1 .5],...
      'Fontsize',12,...
      'String',strforhelp);
     uicontrol('Parent',a,...
      'Position',[figpos(3)-90 figpos(4)-50 80 30],...
      'Style','pushbutton',...
      'Callback',['creatframe(''example'',3,3,''a'',4,''mgwd'',''Small circle'',''b'',3,''\theta'',[-6*pi:0.1:6*pi])'],...
      'String','example')

else
   
   %main program
   lenx=(figpos(3)-100)/numx;
   leny=figpos(4)/numy;
   set(gcf,'Tag',funname);
   %create button to start,play,stop,close...this program
   uicontrol('Parent',a,...
      'Position',[figpos(3)-90 figpos(4)-50 80 30],...
      'Style','pushbutton',...
      'Callback',['funname=get(gcf,''Tag'');playwithpararegion(funname)'],...
      'String','Start')
   uicontrol('Parent',a,...
      'Position',[figpos(3)-90 figpos(4)-100 80 30],...
      'Style','pushbutton',...
      'Callback',['arrallfig(',mat2str(a),',''arrange'')'],...  
      'String','Arrangement')
   uicontrol('Parent',a,...
      'Position',[figpos(3)-90 figpos(4)-150 80 30],...
      'Style','pushbutton',...
      'Callback',['arrallfig(',mat2str(a),',''close'')'],...
      'String','Close All Fig.')
   uicontrol('Parent',a,...
      'Position',[figpos(3)-90 figpos(4)-200 80 30],...
      'Style','pushbutton',...
      'Callback','creatframe',...
      'String','Help')
   uicontrol('Parent',a,...
      'Position',[figpos(3)-90 figpos(4)-250 80 30],...
      'Style','pushbutton',...
      'Callback','close(gcf)',...
      'String','Close')
   uicontrol('Parent',a,...
      'Position',[figpos(3)-90 figpos(4)-300 80 30],...
      'Style','edit',...
      'Tag','funname',...
      'Callback','funname=get(findobj(gcf,''Tag'',''funname''),''String''),funname=set(gcf,''Tag'',funname);',...
      'BackgroundColor',[1 1 1],...   
      'String',funname)
    uicontrol('Parent',a,...
      'Position',[figpos(3)-90 figpos(4)-350 80 30],...
      'Style','pushbutton',...
      'Callback','fname=get(findobj(gcf,''Tag'',''funname''),''String'');buf=help(fname);figure;text(0,0.5,buf);axis off;',...
      'String','Usage')
  
    uicontrol('Parent',a,...
      'Position',[figpos(3)-90 figpos(4)-400 80 30],...
      'Style','pushbutton',...
      'Callback','fname=get(findobj(gcf,''Tag'',''funname''),''String'');edit(fname);',...
      'String','Edit fun.')
  
    %% // New added 2008/03/05 
    uicontrol('Parent',a,...
      'Position',[figpos(3)-100 figpos(4)-450 100 30],...
      'Style','pushbutton',...
      'tag','magic',...
      'userdata','yes',...
      'Callback','hobj=findobj(gcf,''Tag'',''magic'');if strcmp(get(hobj,''userdata''),''yes''),set(hobj,''userdata'',''no'',''String'',''input without name'');else,set(hobj,''userdata'',''yes'',''String'',''input with name'');end',...
      'String','input with name')
    %%  New added 2008/03/05 // 

    %%check box's callback undefind   
   %create parameters' name and value
   %if parameter's name equal to 'mgwd', change the color of parameter
   %you have six kind of colors to use
   color=2;
   mcolor=[0 1 0];
   for i=0:n-1
      if strcmp(varargin{2*i+1},'mgwd')
         color=color+1;
         [color,mcolor]=makecolor(color);
         text('Parent',axes1,...
            'Position',[(floor(i/numy)+.1)/numx*(1-90/figpos(3)) 1-((mod(i,numy)+1)-.5)/numy 0],...
            'String',varargin{2*i+2},...
            'Color',mcolor)
      else
         uicontrol('Parent',a,...
            'Position',[lenx*(floor(i/numy)+.1) figpos(4)-leny*((mod(i,numy)+1)-.1) .04*lenx .8*leny],...
            'Style','checkbox',...
            'Tag',['check',mat2str(i)])
         text('Parent',axes1,...
            'Position',[(floor(i/numy)+.14)/numx*(1-90/figpos(3)) 1-((mod(i,numy)+1)-.5)/numy 0],...
            'String',varargin{2*i+1})
         uicontrol('Parent',a,...
            'Position',[lenx*(floor(i/numy)+.6) figpos(4)-leny*((mod(i,numy)+1)-.1) .4*lenx .8*leny],...
            'Style','edit',...
            'Max',3,...
            'Tag',mat2str(i),...
            'Callback',['c=get(gcf,''UserData'');c{',mat2str(i*2+2),'}=get(findobj(gcf,''Tag'',''',mat2str(i),...
               '''),''String'');if (length(str2num([c{',mat2str(i*2+2),'}(1,:),''99''])) | length(findstr(c{',mat2str(i*2+2),'}(1,:),''[''))~=0), c{',mat2str(i*2+2),'}=',...
               'str2num(c{',mat2str(i*2+2),'}),end;set(gcf,''UserData'',c);'],...
            'BackgroundColor',mcolor,...   
            'String',varargin{2*i+2})            
        %This part to make the textbox can input the string unless to be mixed with function
      end
   end
end
return

%The function to make color
function [color,mcolor]=makecolor(color)
if mod(color,8)==0 
   color=2;
end
mcolor(3)=mod(color,2);
mcolor(2)=mod(floor(color/2),2);
mcolor(1)=mod(floor(color/4),2);
return