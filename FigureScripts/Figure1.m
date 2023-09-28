%% Figure 1
%%
% savefig=1;
figure('units','normalized','outerposition',[0 0 1 1])
%%
subplot(3,1,1) %Holding the space for the general paradigm
text(-.5,1.2,'Figure 1','FontSize',18,'FontWeight','bold','FontName','Arial')
text(0,1.1,'A. General Paradigm','FontSize',18,'FontWeight','bold','FontName','Arial')
text(-.1,1.15,'Figure 1','FontSize',18,'FontWeight','bold','FontName','Arial')
%%
subplot(3,1,2) %Holding the space for Outcome measures 
text(0,1.1,'B. Outcome Measures','FontSize',18,'FontWeight','bold','FontName','Arial')
%% Belts speeds plots 
p=subplot(3,2,5);
text(0,1550,'C. Belts Speed Profile','FontSize',18,'FontWeight','bold','FontName','Arial')
paramsV2={'singleStanceSpeedFastAbs','singleStanceSpeedSlowAbs'};
binwidth=5; %Window of the running average
trialMarkerFlag=0; %1 if you want to separate the time course by trial, 0 to separate by condition
indivFlag=1; %0 to plot group mean 1 to plot indiv subjects
indivSubs=[]; %Use when you want to plot a specific subject in a group
colorOrder=[]; %Let the function take care of this at least you wanted in a specific set of color then by my guess and add the list here
biofeedback= 0; % Unless you are providing with biofeedback to the subject
removeBiasFlag=0 ; %if you want to remove bias
labels={'Fast','Slow'}; %Groups names %labels=[];
filterFlag=[];
plotHandles=[];
alignEnd=0; % # strides align at the end of the trial (PLAY with it and see what happens)
alignIni=0; %  # strides align at the beginning of the trial (PLAY with it and see what happens)
conditions={'TM base','Adaptation','catch','re'};
exampleSubjects{1}=adaptDataGroups{1}.adaptData{2};
exampleSubjects{2}=adaptDataGroups{2}.adaptData{1};

for s=1:2
    for i=1:length(paramsV2)
    plotHandles=p;
    [avg,ind]=adaptationData.plotAvgTimeCourse(exampleSubjects{s},paramsV2{i},conditions,binwidth,trialMarkerFlag,indivFlag,indivSubs,colorOrder,biofeedback,removeBiasFlag,labels,filterFlag,plotHandles,alignEnd,alignIni);
    end
end
ylabel(p,'Betls speeds (mm/s)','FontSize',16,'FontWeight','bold','FontName','Arial')
set(p,'YLim',[500 1500],'YTick',[500 1000 1500],'FontName','Arial','FontSize',12) %Belts speed 
set(p,'XLim',[0 1100],'XTick',0:200:1100,'FontName','Arial','FontSize',12) %Belts speed 


blue=[0 0 153]./255;
poster_colors;
colorOrder=[p_red; p_orange; p_fade_green; p_fade_blue; p_plum; p_green; p_blue; p_fade_red; p_lime; p_yellow; p_gray; p_black;[1 1 1]];         
colorYoung=blue;
colorOld=p_red;

ah1=findobj(p,'Type','Line');
set(ah1(1:8),'LineStyle','-','LineWidth',2,'Color','k');
set(ah1(9:16),'LineStyle','-.','LineWidth',2,'Color','k');

% set(ah1(1:8),'MarkerFaceColor',colorYoung,'MarkerEdgeColor','k','LineWidth',.05);
% set(ah1(9:16),'MarkerFaceColor','w','MarkerEdgeColor',colorYoung,'LineWidth',.05);

% ah11=findobj(p,'Type','Patch');
% set(ah11(11),'FaceColor',colorYoung,'EdgeColor','k');
% set(ah11(12),'FaceColor','w','EdgeColor',colorYoung);
legend('Fast','Slow')

%% Speed differences analysis 
p=subplot(3,2,6);
text(0.5,1550,'D. Speed Differeces','FontSize',18,'FontWeight','bold','FontName','Arial')


paramsV2={'singleStanceSpeedFastAbs','singleStanceSpeedSlowAbs'};
SpeedValues = getResultsSMART(studyData2,paramsV2,groups,maxPerturb,plotFlag,indivFlag,0);
SpeedDiffer=[SpeedValues.TMbase.indiv.singleStanceSpeedFastAbs(:,1) (SpeedValues.TMbase.indiv.singleStanceSpeedFastAbs(:,2)+SpeedValues.TMbase.indiv.singleStanceSpeedSlowAbs(:,2))/2]; 



for i=1:4
    hold on 
    a=find(SpeedDiffer(:,1)==i);
    
    bar(i, mean(SpeedDiffer(a,2)))
    for x=1:length(a)
     plot(i+.2,SpeedDiffer(a(x),2),'.','Color','k','MarkerSize',15)
    end 
    errorbar(i, mean(SpeedDiffer(a,2)),std(SpeedDiffer(a,2)),'.','LineWidth',2,'Color','k')
end

ylabel(p,'Baseline speeds (mm/s)','FontSize',16,'FontWeight','bold','FontName','Arial')
set(p,'YLim',[500 1500],'YTick',[500 750 1000 1250 1500],'FontName','Arial','FontSize',12) %Belts speed 
set(p,'XLim',[0.5 4.5]) %Belts speed 
xticks([1 2 3 4]); xticklabels({'YS','YF','OS','OF'})

ah1=findobj(p,'Type','Bar');
  set(ah1(4),'FaceColor','w','EdgeColor', colorYoung,'LineWidth',2);
    set(ah1(3),'FaceColor', colorYoung,'EdgeColor','k');
    set(ah1(2),'FaceColor','w','EdgeColor',colorOld,'LineWidth',2);
    set(ah1(1),'FaceColor',colorOld,'EdgeColor','k');

YS=find(SpeedValues.TMsteady.indiv.singleStanceSpeedFastAbs(:,1)==1);
YF=find(SpeedValues.TMsteady.indiv.singleStanceSpeedFastAbs(:,1)==2);
OS=find(SpeedValues.TMsteady.indiv.singleStanceSpeedFastAbs(:,1)==3);
OF=find(SpeedValues.TMsteady.indiv.singleStanceSpeedFastAbs(:,1)==4);
AGE=[0.*ones(length([YS' YF']), 1); ones(length([OS' OF']), 1)];
SPEED=[0.*ones(size(YS,1) ,1); ones(size(YF,1),1); 0.*ones(size(OS,1) ,1); ones(size(OF,1),1); ];

Data=SpeedDiffer(:,2);
[p_value, tbl,stats,terms]= anovan(Data,{AGE SPEED},'model','interaction','varnames',{'AGE','SPEED'});

tableData=[Data,AGE SPEED];
StatsFormat=array2table( tableData, 'VariableNames', { 'SpeedDiffer','age', 'spd'});
 filename = ['Baseline_Speeds.csv'];
  writetable(StatsFormat,filename,'Delimiter',',','QuoteStrings',true)
  
text(1,1400, ['$p_{age}$=',num2str(p_value(1))],'Interpreter','latex')
text(1,1350, ['$p_{speed}$=',num2str(p_value(2))],'Interpreter','latex')
text(1,1300, ['$p_{age\#speed}$=',num2str(p_value(3))],'Interpreter','latex')

set(gcf,'renderer','painters')

if savefig==1
saveas(gcf,'Figure_1_ProtocolV2','pdf')
end

