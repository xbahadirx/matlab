function dos(name1,name2,name3,name4,xlim)
subplot(221)
kfile=[name1 '.kvecs']
ffile=[name1 '.fermi']
dfile=[name1 '.dos']
fermi=load(ffile)
dos=importdata(dfile,' ',1);

plot(dos.data(:,1)-fermi,dos.data(:,2))
set(gca,'XLim',xlim)
set(gca,'YLabel',text('String','Energy (eV)','FontSize',12,'FontWeight','bold'))
set(gca,'XLabel',text('String','k-vectors','FontSize',12,'FontWeight','bold'))
set(gca,'XTickMode','manual');
hold on
ffile=[name2 '.fermi']
dfile=[name2 '.dos']
fermi=load(ffile)
dos=importdata(dfile,' ',1);
plot(dos.data(:,1)-fermi,dos.data(:,2),'r')
hold on

ffile=[name3 '.fermi']
dfile=[name3 '.dos']
fermi=load(ffile)
dos=importdata(dfile,' ',1);
plot(dos.data(:,1)-fermi,dos.data(:,2),'g')
hold on

ffile=[name4 '.fermi']
dfile=[name4 '.dos']
fermi=load(ffile)
dos=importdata(dfile,' ',1);
plot(dos.data(:,1)-fermi,dos.data(:,2),'k')

line([0 0],[0 8],'color','r')

subplot(222)

kfile=[name1 '.kvecs']
ffile=[name1 '.fermi']
dfile=[name1 '.dos']
fermi=load(ffile)
dos=importdata(dfile,' ',1);
plot(dos.data(:,1)-fermi,dos.data(:,2))

hold on

ffile=[name2 '.fermi']
dfile=[name2 '.dos']
fermi=load(ffile)
dos=importdata(dfile,' ',1);
plot(dos.data(:,1)-fermi,dos.data(:,2),'r')
hold on

ffile=[name3 '.fermi']
dfile=[name3 '.dos']
fermi=load(ffile)
dos=importdata(dfile,' ',1);
plot(dos.data(:,1)-fermi,dos.data(:,2),'g')
hold on

ffile=[name4 '.fermi']
dfile=[name4 '.dos']
fermi=load(ffile)
dos=importdata(dfile,' ',1);
plot(dos.data(:,1)-fermi,dos.data(:,2),'k')

line([0 0],[0 8],'color','r')
set(gca,'YLim',[0 1])
set(gca,'XLim',[-5 5])
set(gca,'YLabel',text('String','Energy (eV)','FontSize',12,'FontWeight','bold'))
set(gca,'XLabel',text('String','k-vectors','FontSize',12,'FontWeight','bold'))
set(gca,'XTickMode','manual');


end
