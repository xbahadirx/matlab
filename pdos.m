function pdos(name,name1,name2,name3,name4,name5,name6)
subplot(221)
ffile=[name '.fermi']
dfile=[name '.' name1 '.pdos']
fermi=load(ffile)
dos=importdata(dfile,' ',1);
plot(dos.data(:,1)-fermi,dos.data(:,2))
set(gca,'YLim',ylim)
set(gca,'YLabel',text('String','Projected Density of States(PDOS)','FontSize',12,'FontWeight','bold'))
set(gca,'XLabel',text('String','Energy(eV)','FontSize',12,'FontWeight','bold'))
set(gca,'XTickMode','manual');
hold on

ffile=[name '.fermi']
dfile=[name '.' name2 '.pdos']
fermi=load(ffile)
dos=importdata(dfile,' ',1);
plot(dos.data(:,1)-fermi,dos.data(:,2),'r')
hold on

ffile=[name '.fermi']
dfile=[name '.' name3 '.pdos']
fermi=load(ffile)
dos=importdata(dfile,' ',1);
plot(dos.data(:,1)-fermi,dos.data(:,2),'g')
hold on

ffile=[name '.fermi']
dfile=[name '.' name4 '.pdos']
fermi=load(ffile)
dos=importdata(dfile,' ',1);
plot(dos.data(:,1)-fermi,dos.data(:,2),'k')
line([0 0],[0 8],'color','r')
legend(name1,name2,name3,name4);

subplot(222)
ffile=[name '.fermi']
dfile=[name '.' name5 '.pdos']
fermi=load(ffile)
dos=importdata(dfile,' ',1);
plot(dos.data(:,1)-fermi,dos.data(:,2))
set(gca,'YLim',ylim)
set(gca,'YLabel',text('String','','FontSize',12,'FontWeight','bold'))
set(gca,'XLabel',text('String','Energy(eV)','FontSize',12,'FontWeight','bold'))
set(gca,'XTickMode','manual');
hold on

ffile=[name '.fermi']
dfile=[name '.' name6 '.pdos']
fermi=load(ffile)
dos=importdata(dfile,' ',1);
plot(dos.data(:,1)-fermi,dos.data(:,2),'r')
hold on
line([0 0],[0 8],'color','r')
legend(name5,name6);
end
