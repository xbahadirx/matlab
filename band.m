function band(name1,lab,ylim)

kfile=[name1 '.kvecs']
ffile=[name1 '.fermi']
bfile=[name1 '.bands.xmgr']
kvecs=load(kfile)
fermi=load(ffile)
bands=load(bfile);
plot(bands(:,1),bands(:,2)-fermi)
set(gca,'XLim',[0 max(kvecs)])
set(gca,'YLim',ylim)
set(gca,'YLabel',text('String','Energy (eV)','FontSize',11,'FontWeight','bold'))
set(gca,'XLabel',text('String','k-vectors','FontSize',11,'FontWeight','bold'))
set(gca,'XTickMode','manual');
kvecs=rot90(kvecs,1)
set(gca,'XTick',kvecs(1,:));
set(gca,'FontSize',11)
format_ticks(gca,lab,[],kvecs);

line([0 max(kvecs)],[0 0],'color','r')
for i=1:length(kvecs)
line ([kvecs(1,i) kvecs(1,i)],ylim,'color','k')
end

