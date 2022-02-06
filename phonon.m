function phonon(p_file,g_file,dos_file,ia_file,kvecs,lab,bubbleSize,interval)
ry_to_cmm1=109737.3
p=load(p_file);
d=load(dos_file);
g=load(g_file);
ia=importdata(ia_file,' ',5)
if ~isempty(kvecs)
kvecs=load(kvecs)
end
pc=p(:,1)
pd=p(:,2)
gd=g(:,2)
pc=pc(1:interval:end)
pd=pd(1:interval:end)
gd=gd(1:interval:end)
p1=[pc(:,1) pd(:,1) gd(:,1)]
posX1=0.08;posY1=0.15;posX2=0.40;posY2=0.80; % initial positions for plot

pg=[p(:,1) p(:,2) g(:,2)];
pg=p1;
hand1=subplot(121)
hand1=subplot('Position',[posX1 posY1 posX2 posY2]);
get(hand1,'type')
ylim=[min(p(:,2)) max(p(:,2))+5]
scatter(pg(:,1),pg(:,2),bubbleSize*(pg(:,3)+abs(min(pg(:,3))))+0.0000001,[0.5 0 0],'filled');hold on
plot(p(:,1),p(:,2),'k','LineWidth',1);hold on
set(gca,'XLim',[0 max(pg(:,1))])
set(gca,'YLim',ylim)
set(gca,'YLabel',text('String','Frequency (cm^{-1})','FontSize',12,'FontWeight','bold'))
set(gca,'XLabel',text('String','k-vectors','FontSize',12,'FontWeight','bold'))
set(gca,'XTickMode','manual');
kvecs=rot90(kvecs,1)
set(gca,'XTick',kvecs(1,:));
set(gca,'FontSize',16)
format_ticks(gca,lab,[],kvecs);

for i=1:length(kvecs)
line ([kvecs(1,i) kvecs(1,i)],ylim,'color','k')
end
box on
hand2=subplot(122)
posX1=posX1+0.40;posX2=0.15;
hand2=subplot('Position',[posX1 posY1 posX2 posY2]);
plot(d(:,2),d(:,1),'Linewidth',2)
set(gca,'YLim',ylim)
set(gca,'XLim',[0 max(d(:,2))])
set(gca,'XLabel',text('String','phonon DOS','FontSize',12,'FontWeight','bold'))
set(gca,'YTick',[]);
set(gca,'XTick',[]);
hold on
nor=max(d(:,2))/max(ia.data(:,2))
m=max(d(:,1))-max(ia.data(:,1)*ry_to_cmm1)
plot(ia.data(:,2)*nor,ia.data(:,1)*ry_to_cmm1,'r','LineWidth',1)
legend('total DOS','total a2F');
%mTextBox = uicontrol('style','text')
%set(mTextBox,'String',title)
%set(mTextBox,'BackgroundColor','w')
