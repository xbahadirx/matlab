function band(name1,name2,name3,lab,ylim)

kfile=[name1 '.kvecs']
ffile=[name1 '.fermi']
bfile=[name1 '.xmgr']
kvecs=load(kfile)
fermi=load(ffile)
bands=load(bfile);
plot(bands(:,1),bands(:,2)-fermi,'LineWidth',1);hold on;

if name2 
ffile=[name2 '.fermi']
bfile=[name2 '.xmgr']
fermi=load(ffile)
bands=load(bfile);
plot(bands(:,1),bands(:,2)-fermi,'LineWidth',1,'color','r'); hold on;
end;

if name3  
ffile=[name3 '.fermi']
bfile=[name3 '.xmgr']
fermi=load(ffile)
bands=load(bfile);
plot(bands(:,1),bands(:,2)-fermi,'LineWidth',1,'color','g'); hold on
end

set(gca,'XLim',[0 max(kvecs)])
set(gca,'YLim',ylim)
set(gca,'YLabel',text('String','Energy (eV)','FontSize',12,'FontWeight','bold'))
set(gca,'XTickMode','manual');
kvecs=rot90(kvecs,1)
set(gca,'XTick',kvecs(1,:));
set(gca,'FontSize',14)
set(gca,'XTickLabel',[]);
line([0 max(kvecs)],[0 0],'color','k','LineStyle','--','LineWidth',1)
for i=1:length(kvecs)
line ([kvecs(1,i) kvecs(1,i)],ylim,'color','k')
end
format_ticks(gca,lab,[],kvecs);

%%hand3=subplot(312)
%%kfile=[name2 '.kvecs']
%%ffile=[name2 '.fermi']
%%bfile=[name2 '.xmgr']
%%kvecs=load(kfile)
%%fermi=load(ffile)
%%bands=load(bfile);
%%plot(bands(:,1),bands(:,2)-fermi,'LineWidth',1)
%%set(gca,'XLim',[0 max(kvecs)])
%%set(gca,'YLim',ylim)
%%set(gca,'YLabel',text('String','Energy (eV)','FontSize',12,'FontWeight','bold'))
%%set(gca,'XTickMode','manual');
%%kvecs=rot90(kvecs,1)
%%set(gca,'XTick',kvecs(1,:));
%%set(gca,'FontSize',14)
%%set(gca,'XTickLabel',[]);
%%line([0 max(kvecs)],[0 0],'color','k','LineStyle','--','LineWidth',1)
%%for i=1:length(kvecs)
%%line ([kvecs(1,i) kvecs(1,i)],ylim,'color','k')
%%end
%%
%%box on
%%hand4=subplot(313)
%%kfile=[name3 '.kvecs']
%%ffile=[name3 '.fermi']
%%bfile=[name3 '.xmgr']
%%kvecs=load(kfile)
%%fermi=load(ffile)
%%bands=load(bfile);
%%plot(bands(:,1),bands(:,2)-fermi,'LineWidth',1)
%%set(gca,'XLim',[0 max(kvecs)])
%%set(gca,'YLim',ylim)
%%set(gca,'YLabel',text('String','Energy (eV)','FontSize',12,'FontWeight','bold'))
%%set(gca,'XLabel',text('String','k-vectors','FontSize',12,'FontWeight','bold'))
%%set(gca,'XTickMode','manual');
%%kvecs=rot90(kvecs,1)
%%set(gca,'XTick',kvecs(1,:));
%%set(gca,'FontSize',14)
%%format_ticks(gca,lab,[],kvecs);
%%line([0 max(kvecs)],[0 0],'color','k','LineStyle','--','LineWidth',1)
%%for i=1:length(kvecs)
%%line ([kvecs(1,i) kvecs(1,i)],ylim,'color','k')
%%end
