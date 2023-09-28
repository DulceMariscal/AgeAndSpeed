%% Figure 3 - Generalization 
%%
params={'netContributionNorm2','spatialContributionNorm2','stepTimeContributionNorm2'}; %Parameters of interest: Sa, Sp, St
figure
tc=[1 2 3];
gp=[13 14 15];
pGp=[16  17  18];
wp=[19 20 21];

binwidth=5; %Window of the running average
trialMarkerFlag=0; %1 if you want to separate the time course by trial, 0 to separate by condition
indivFlag=0; %0 to plot group mean 1 to plot indiv subjects
indivSubs=[]; %Use when you want to plot a specific subject in a group
colorOrder=[]; %Let the function take care of this at least you wanted in a specific set of color then by my guess and add the list here
biofeedback= 0; % Unless you are providing with biofeedback to the subject
removeBiasFlag=0 ; %if you want to remove bias
labels={'YS','YF','OS','OF'}; %Groups names %labels=[];
filterFlag=[];
plotHandles=[];
alignEnd=40; % # strides align at the end of the trial (PLAY with it and see what happens)
alignIni=30; %  # strides align at the beginning of the trial (PLAY with it and see what happens)

conditions={'OG base','OG post'};
epochs={'OGafter','Transfer3','TMafter'};

%% Plots 
for i=1:length(params)
    
    p(i)=subplot(2,3,tc(i));
    plotHandles=p(i);
    adaptData=cellfun(@(x) x.adaptData,adaptDataGroups,'UniformOutput',false); %Notice that adaptDataGroups(1) decide that I only want to plot the CG group
    [avg,ind]=adaptationData.plotAvgTimeCourse(adaptData,params{i},conditions,binwidth,trialMarkerFlag,0,indivSubs,colorOrder,biofeedback,removeBiasFlag,labels,filterFlag,plotHandles,alignEnd,alignIni);
    xlabel(p(i),'strides','FontSize',16,'FontWeight','bold','FontName','Arial')
    b(i)=subplot(4,6,gp(i));
    barGroups(studyData2,results,groups,params{i},epochs(1),1,[],[],b(i))
    b2(i)=subplot(4,6,pGp(i));
    barGroups(studyData2,results,groups,params{i},epochs(2),1,[],[],b2(i))
    b3(i)=subplot(4,6,wp(i));
    barGroups(studyData2,results,groups,params{i},epochs(3),1,[],[],b3(i))
end


%% Adjusting axis

% Figure 3
set(p(1),'YLim',[-0.03 0.12],'YTick',[ -0.03 0 0.05 0.10],'FontName','Arial','FontSize',12) %SLA
set(p(2),'YLim',[-0.03 0.08],'YTick',[-0.02 0 0.02 0.04 0.06 0.08],'FontName','Arial','FontSize',12) %Spatial
set(p(3),'YLim',[-0.03 0.08],'YTick',[-0.02 0 0.02 0.04 0.06 0.08],'FontName','Arial','FontSize',12) %Temporal


set(b(1),'YLim',[0 0.2],'YTick',[0 0.05 0.1 0.15 0.2],'FontName','Arial','FontSize',12) %SLA
set(b(2),'YLim',[-0.05 0.2],'YTick',[-0.05 0 0.05 0.10 0.15 0.2],'FontName','Arial','FontSize',12) %Spatial
set(b(3),'YLim',[-0.02 0.11],'YTick', [-0.02 0 0.05 0.1],'FontName','Arial','FontSize',12) %Temporal

set(b2(1),'YLim',[0 100],'YTick',[0 20 40 60 80 100],'FontName','Arial','FontSize',12) %SLA
set(b2(2),'YLim',[-25 80],'YTick',[-20 0 20 40 60 80],'FontName','Arial','FontSize',12) %Spatial
set(b2(3),'YLim',[-5  60],'YTick',[-5 0 5 15 25 35 45 55],'FontName','Arial','FontSize',12) %Temporal

%Figure 4 

set(b3(1),'YLim',[0 0.2],'YTick',[0 0.05 0.1 0.15 0.2],'FontName','Arial','FontSize',12) %SLA
set(b3(2),'YLim',[-0.06 0.2],'YTick',[-0.05 0 0.05 0.1 0.15 0.2],'FontName','Arial','FontSize',12) %Spatial
set(b3(3),'YLim',[-0.015 0.10],'YTick',[-0.015 0 0.05 0.10],'FontName','Arial','FontSize',12) %Temporal
%% Changing ylabels and titles
text(-12,0.6,'Figure 3','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(p(1),'StepAsym','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(p(2),'Sp','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(p(3),'St','FontSize',16,'FontWeight','bold','FontName','Arial')

text(-9, 0.6,'A','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(b(1),epochs{1},'FontSize',16,'FontWeight','bold','FontName','Arial')
title(b(1),'StepAsym','FontSize',16,'FontWeight','bold','FontName','Arial')

ylabel(b(2),'')
title(b(2),'Sp','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(b(3),'')
title(b(3),'St','FontSize',16,'FontWeight','bold','FontName','Arial')

text(-9, 0.3,'B','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(b2(1),epochs{2},'FontSize',16,'FontWeight','bold','FontName','Arial')
title(b2(1),'StepAsym','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(b2(2),'')
title(b2(2),'Sp','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(b2(3),'')
title(b2(3),'St','FontSize',16,'FontWeight','bold','FontName','Arial')

text(-12,0.12,'Figure 4','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(b3(1),epochs{3},'FontSize',16,'FontWeight','bold','FontName','Arial')
title(b3(1),'StepAsym','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(b3(2),'')
title(b3(2),'Sp','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(b3(3),'')
title(b3(3),'St','FontSize',16,'FontWeight','bold','FontName','Arial')

%%
%Ste colors
blue=[0 0 200]./255;
poster_colors;
colorOrder=[p_red; p_orange; p_fade_green; p_fade_blue; p_plum; p_green; p_blue; p_fade_red; p_lime; p_yellow; p_gray; p_black;[1 1 1]];
colorYoung=blue;
colorOld=p_red;

for i=1:length(params)
    ah1=findobj(p(i),'Type','Line');
    set(ah1(1:4),'MarkerFaceColor',colorOld,'MarkerEdgeColor','k','LineWidth',.05);
    set(ah1(5:8),'MarkerFaceColor','w','MarkerEdgeColor',colorOld,'LineWidth',.05);
    set(ah1(9:12),'MarkerFaceColor',  colorYoung,'MarkerEdgeColor','k','LineWidth',.5);
    set(ah1(13:16),'MarkerFaceColor','w','MarkerEdgeColor', colorYoung,'LineWidth',.05);
    
    ah11=findobj(p(i),'Type','Patch');
    set(ah11(1:4),'FaceColor',colorOld,'EdgeColor',colorOld,'FaceAlpha',.4);
    set(ah11(5:8),'FaceColor','w','EdgeColor',colorOld,'FaceAlpha',.3);
    set(ah11(9:12),'FaceColor', colorYoung,'EdgeColor', colorYoung,'FaceAlpha',.4);
    set(ah11(13:16),'FaceColor','w','EdgeColor', colorYoung,'FaceAlpha',.3);
    
end

for i=1:length(params)
    ah1=findobj(b(i),'Type','Bar');
    set(ah1(4),'FaceColor','w','EdgeColor',  colorYoung,'LineWidth',2);
    set(ah1(3),'FaceColor',  colorYoung,'EdgeColor','k');
    set(ah1(2),'FaceColor','w','EdgeColor',colorOld,'LineWidth',2);
    set(ah1(1),'FaceColor',colorOld,'EdgeColor','k');
   
    
    ah1=findobj(b2(i),'Type','Bar');
    set(ah1(4),'FaceColor','w','EdgeColor', colorYoung,'LineWidth',2);
    set(ah1(3),'FaceColor', colorYoung,'EdgeColor','k');
    set(ah1(2),'FaceColor','w','EdgeColor',colorOld,'LineWidth',2);
    set(ah1(1),'FaceColor',colorOld,'EdgeColor','k');
    
     ah1=findobj(b3(i),'Type','Bar');
    set(ah1(4),'FaceColor','w','EdgeColor', colorYoung,'LineWidth',2);
    set(ah1(3),'FaceColor', colorYoung,'EdgeColor','k');
    set(ah1(2),'FaceColor','w','EdgeColor',colorOld,'LineWidth',2);
    set(ah1(1),'FaceColor',colorOld,'EdgeColor','k');
    
    ah1=findobj(b(i),'Type','Line');
     set(ah1(1:32),'MarkerFaceColor','w','MarkerEdgeColor','k','LineWidth',2);
    
     ah1=findobj(b2(i),'Type','Line');
     set(ah1(1:32),'MarkerFaceColor','w','MarkerEdgeColor','k','LineWidth',2);
     
      ah1=findobj(b3(i),'Type','Line');
     set(ah1(1:32),'MarkerFaceColor','w','MarkerEdgeColor','k','LineWidth',2);
     
end


