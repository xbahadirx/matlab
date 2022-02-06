function [stra,labs,labels]=readAgr(fileNameAgr,fileDOS1,fileDOS2,fileDOS3,fermiEnergy,nBand,nFermi,saveFile,lab1,yLim,plotstyle,bandline)
dosline=2;
if bandline==''
    bandline=1;
end
fermiline=1.5;
hartree_to_ev=27.21138386;
fid=fopen(fileNameAgr);
tline='';
count=0;
fermi=fermiEnergy*hartree_to_ev;
%if plotstyle==''
%    plotstyle='b'
%end
%mv=2.123;
mv=0
fac1=2;
fac2=2;
fac3=2;
%fark=(fermiEnergy1*hartree_to_ev)-fermi
labs=[];
cL=0;clab=0;
xLimD=[0 2]; %x axis limits for Dos plot
xLimB=[0 1]; %x axis limits for Band plot
%yLim=[-23 10]; %y axis limits for Band and Dos plot
posX1=0.08;posY1=0.15;posX2=0.40;posY2=0.80; % initial positions for plot


labelPos=0; % 0-->bottom   1--->top

if fileDOS1
data1=load(fileDOS1);
end

if fileDOS2
data2=load(fileDOS2);
end

if fileDOS3
data3=load(fileDOS3);
end

if fileNameAgr
while 1
    tline = fgetl(fid);
    indm=strfind(tline,'major');
    indx=strfind(tline,'xaxis');
    indxLabel=strfind(tline,'ticklabel');
    indn=length(indm);
    indxn=length(indx);
    idl=length(indxLabel);
    
    if indn>0 && indxn > 0
        cL=cL+1;
        son=length(tline);
        indStart=indm+6;
        labs{cL}.indis=str2num(tline(indStart));
        labs{cL}.data=str2num(tline(indStart+2:son-1));
    end
    
    if idl>0 && indxn > 0
        clab=clab+1;
        son=length(tline);
        indStart=indxLabel+10;
        labels{clab}.indis=str2num(tline(indStart));
        labels{clab}.data=tline(son-1);
    end
        
    if(strcmp(tline,'@   TYPE xy'))
        strsx='new data start'
        count=count+1;
        con=0;
        str=[];
        while strcmp(tline,'    &')~=1,
            tline=fgetl(fid);
            con=con+1;
            [veri,OK]=str2num(tline);
            if OK
                                
                    str(con,1)=veri(1);
                    str(con,2)=veri(2);
                
            end
        end
        stra{count}.data=str;
    end
    
    if ~ischar(tline),   break,   end
    disp(tline);
end
fclose(fid);
xti=[];
lab=[];
for i=1:length(labels)
    xti(1,i)=labs{i+1}.data
    lab(i,1)=labels{i}.data
end
hand1=subplot('Position',[posX1 posY1 posX2 posY2]);

%hand1=subplot('PaperPosition',[0 posY1 posX2 posY2]);
get(hand1,'type')
subplot(hand1)
fermidata=stra{nFermi+1}.data;
plot(fermidata(:,1),fermidata(:,2),':b','LineWidth',fermiline);
hold on
for i=1:nFermi
    yy=stra{i}.data;
    plot(yy(:,1),yy(:,2)+mv,plotstyle,'LineWidth',bandline);

%bubble
    if fileDOS1&(i==7)
    a=[data1(:,1) data1(:,2) data1(:,3) data1(:,4) data1(:,5) data1(:,6)];
    b=a(:,1)*27.21138386;
    maxcont=max(max([a(:,2) a(:,3) a(:,4) a(:,5)]));
    maxcontscale=300/maxcont;
     conc=1;
    j=1;
        while j<length(yy)
        %for i=1:length(yy)
        [c index]=min(abs(b-yy(j,2)));
        index
        zz=a(index,2)
        zzy=yy(j,2)/27.21138386
        d(conc,1)=yy(j,1);
        d(conc,2)=b(index);
        d(conc,3)=yy(j,2);
        conc=conc+1;
        j=j+20;
        scont=a(index,3)*maxcontscale;
        scatter(d(:,1),d(:,2),scont,'b');
        pcont=a(index,4)*maxcontscale;
        scatter(d(:,1),d(:,2),pcont,'r');
        dcont=a(index,5)*maxcontscale;
        scatter(d(:,1),d(:,2),dcont,'k');
        end
    end
%%end bubble

end
for i=nFermi+2:nBand+1
    xx=stra{i}.data;
    plot(xx(:,1),xx(:,2),'b','LineWidth',bandline);
end

set(gca,'XLim',xLimB)
set(gca,'YLim',yLim)
set(gca,'YLabel',text('String','Energy (eV)','FontSize',12,'FontWeight','bold'))
set(gca,'Xtick',xti);
%set(gca,'FontName','Symbol')
%set(gca,'Xticklabel',char(lab));
%lab1={'K','{\Gamma}','M','K','H','A','L','H','L','M','{\Gamma}','A'};
%lab1={'A','{\Gamma}','C','D','{\Gamma}','E'};

format_ticks(gca,lab1,[],xti);
set(gca,'XLabel',text('String','k-vectors','FontSize',12,'FontWeight','bold'))



if labelPos==1
set(gca,'xaxislocation','top');
labelPos=0;
else 
 set(gca,'xaxislocation','bottom');
 labelPos=1;
end
end % end of if before while





if fileDOS1
data1=load(fileDOS1);
xm=max(max(data1(:,3:5)))
%fac=xm/2

x=(data1(:,1)*hartree_to_ev)-fermi;
[ds,p] = csaps(x,data1(:,2),0.95);
[dp,p] = csaps(x,data1(:,3),0.95);
[dd,p] = csaps(x,data1(:,4),0.95);
%[df,p] = csaps(x,data(:,6),0.95);
posX1=posX1+0.40;posX2=0.15;
hand2=subplot('Position',[posX1 posY1 posX2 posY2]);
get(hand2,'type')
subplot(hand2)
pt=fnplt(ds);plot(pt(2,:)/fac1,pt(1,:),'-r','LineWidth',dosline);hold on
pt=fnplt(dp);plot(pt(2,:)/fac1,pt(1,:),'-.b','LineWidth',dosline);
pt=fnplt(dd);plot(pt(2,:)/fac1,pt(1,:),'--k','LineWidth',dosline);
%pt=fnplt(df);plot(pt(2,:),pt(1,:),':g');
set(gca,'Xlim',xLimD)
set(gca,'Ylim',yLim)
if labelPos==1
set(hand2,'xaxislocation','top');
labelPos=0;
else 
 set(hand2,'xaxislocation','bottom');
 labelPos=1;
end
set(hand2,'yticklabel','');
end
if fileDOS2
data2=load(fileDOS2);
xm=max(max(data2(:,3:5)));

x=data2(:,1)*hartree_to_ev-fermi;
[ds,p] = csaps(x,data2(:,2),0.95);
[dp,p] = csaps(x,data2(:,3),0.95);
[dd,p] = csaps(x,data2(:,4),0.95);
%[df,p] = csaps(x,data2(:,6),0.95);
posX1=posX1+posX2;posX2=0.15;
hand3=subplot('Position',[posX1 posY1 posX2 posY2]);
get(hand3,'type')
subplot(hand3)
pt=fnplt(ds);plot(pt(2,:)/fac2,pt(1,:),'-r','LineWidth',dosline);hold on
pt=fnplt(dp);plot(pt(2,:)/fac2,pt(1,:),'-.b','LineWidth',dosline);
pt=fnplt(dd);plot(pt(2,:)/fac2,pt(1,:),'--k','LineWidth',dosline);
%pt=fnplt(df);plot(pt(2,:)/fac,pt(1,:),':g');
set(gca,'Xlim',xLimD)
set(gca,'Ylim',yLim)
set(gca,'XLabel',text('String','PDOS'))
if labelPos==1
set(hand3,'xaxislocation','top');
labelPos=0;
else 
 set(hand3,'xaxislocation','bottom');
 labelPos=1;
end

set(hand3,'yticklabel','');
end

if fileDOS3
data3=load(fileDOS3);
xm=max(max(data3(:,3:6)));

x=data3(:,1)*hartree_to_ev-fermi;
[ds,p] = csaps(x,data3(:,2),0.95);
[dp,p] = csaps(x,data3(:,3),0.95);
[dd,p] = csaps(x,data3(:,4),0.95);
%[df,p] = csaps(x,data3(:,6),0.95);
posX1=posX1+posX2;posX2=0.15;
hand4=subplot('Position',[posX1 posY1 posX2 posY2]);
get(hand4,'type')

subplot(hand4)
pt=fnplt(ds);plot(pt(2,:)/fac3,pt(1,:),'-r','LineWidth',dosline);hold on
pt=fnplt(dp);plot(pt(2,:)/fac3,pt(1,:),'-.b','LineWidth',dosline);
pt=fnplt(dd);plot(pt(2,:)/fac3,pt(1,:),'--k','LineWidth',dosline);
%pt=fnplt(df);plot(pt(2,:)/fac,pt(1,:),':g');
set(gca,'Xlim',xLimD)
set(gca,'Ylim',yLim)

if labelPos==1
set(hand4,'xaxislocation','top');
labelPos=0;
else 
 set(hand4,'xaxislocation','bottom');
 labelPos=1;
end
set(hand4,'yticklabel','');
end

data1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555
orient portrait
print('-f', '-depsc2', saveFile);



