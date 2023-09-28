%Figure 5 - Catch Figure
%%  Plots settings

% savefig=0;
% params={'netContributionNorm2','spatialContributionNorm2','stepTimeContributionNorm2'}; %Parameters of interest: Sa, Sp, St
params={'netContributionNorm2','alphaAsym','Xasym'};
figure('units','normalized','outerposition',[0 0 1 1])

tc=[1 3 5];
cp=[4 10 16];
ssp=[5 11 17];
extp=[18];

binwidth=5; %Window of the running average
trialMarkerFlag=[0 1]; %1 if you want to separate the time course by trial, 0 to separate by condition
indivFlag=0; %0 to plot group mean 1 to plot indiv subjects
indivSubs=[]; %Use when you want to plot a specific subject in a group
colorOrder=[]; %Let the function take care of this at least you wanted in a specific set of color then by my guess and add the list here
biofeedback= 0; % Unless you are providing with biofeedback to the subject
removeBiasFlag=1; %if you want to remove bias
labels={'YS','YF','OS','OF'}; %Groups names %labels=[];
filterFlag=[];
plotHandles=[];
alignEnd=0; % # strides align at the end of the trial (PLAY with it and see what happens)
alignIni=0; %  # strides align at the beginning of the trial (PLAY with it and see what happens)


conditions={'catch'};
epochs={'catch'};
%OG100 data from the catch trial is missing due to problems during data collection


%% Plots 
for i=1:length(params)
    
    p(i)=subplot(3,2,tc(i));
    plotHandles=p(i);
    adaptData=cellfun(@(x) x.adaptData,adaptDataGroups,'UniformOutput',false); %Notice that adaptDataGroups(1) decide that I only want to plot the CG group
    [avg,ind]=adaptationData.plotAvgTimeCourse(adaptData,params{i},conditions,binwidth,trialMarkerFlag,0,indivSubs,colorOrder,biofeedback,removeBiasFlag,labels,filterFlag,plotHandles,alignEnd,alignIni);
    xlabel(p(i),'strides','FontSize',16,'FontWeight','bold','FontName','Arial')
    b(i)=subplot(3,6,cp(i));
    barGroups(studyData2,results,groups,params{i},epochs(1),1,[],[],b(i))
%     b2(i)=subplot(3,6,ssp(i));
%     barGroups(studyData2,results,groups,params{i},epochs(2),1,[],[],b2(i))
end

%% Adjusting axis
text(-23,1.28,'Figure 5','FontSize',20,'FontWeight','bold','FontName','Arial')
text(-23, 1.25,'A. Time Courses','FontSize',18,'FontWeight','bold','FontName','Arial')
set(p(1),'YLim',[0 0.2],'YTick',[0 0.05 0.10 0.15 0.20],'FontName','Arial','FontSize',12) %SLA
set(p(2),'YLim',[-0.01 0.1],'YTick',[0-0.01 0 0.05 0.1 0.15],'FontName','Arial','FontSize',12) %Alpha
set(p(3),'YLim',[0 0.2],'YTick',[0 0.05 0.10 0.15 0.20],'FontName','Arial','FontSize',12) %Temporal

text(-9, 1.25,'B. Catch','FontSize',18,'FontWeight','bold','FontName','Arial')
text(-5, 1.25,'C. Steady State','FontSize',18,'FontWeight','bold','FontName','Arial')
%text(0, 0.4,'D. Extend of Adaptation','FontSize',18,'FontWeight','bold','FontName','Arial')

% set(b(1),'YLim',[0 0.21],'YTick',[0 0.05 0.1 0.15 0.2],'FontName','Arial','FontSize',12) %SLA
% set(b(2),'YLim',[-0.05 0.1],'YTick',[-0.05 0 0.05 0.10 ],'FontName','Arial','FontSize',12) %Alpha
% set(b(3),'YLim',[0 0.15],'YTick',[0 0.05 0.15],'FontName','Arial','FontSize',12) %Temporal


set(b(1),'YLim',[0 0.25],'YTick',[0 0.05 0.10 0.15 0.20 0.25],'FontName','Arial','FontSize',12) %SLA
set(b(2),'YLim',[-0.03 0.1],'YTick',[-0.03 0 0.05 0.1],'FontName','Arial','FontSize',12) %Alpha
set(b(3),'YLim',[0 0.2],'YTick',[0 0.05 0.10 0.15 0.20],'FontName','Arial','FontSize',12) %Temporal

%% Changing ylabels and titles
ylabel(p(1),'S_a','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(p(2),'\alpha_{asym}','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(p(3),'X_{asym}','FontSize',16,'FontWeight','bold','FontName','Arial')


%ylabel(b(1),epochs{1},'FontSize',16,'FontWeight','bold','FontName','Arial')
title(b(1),'')
ylabel(b(1),'S_a','FontSize',16,'FontWeight','bold','FontName','Arial')
title(b(2),'')
ylabel(b(2),'\alpha_{asym}','FontSize',16,'FontWeight','bold','FontName','Arial')
title(b(3),'')
ylabel(b(3),'X_{asym}','FontSize',16,'FontWeight','bold','FontName','Arial')

%ylabel(b2(1),epochs{2},'FontSize',16,'FontWeight','bold','FontName','Arial')
% title(b2(1),'')
% ylabel(b2(1),'S_a','FontSize',16,'FontWeight','bold','FontName','Arial')
% title(b2(2),'')
% ylabel(b2(2),'\alpha_{asym}','FontSize',16,'FontWeight','bold','FontName','Arial')
% title(b2(3),'')
% ylabel(b2(3),'X_{asym}','FontSize',16,'FontWeight','bold','FontName','Arial')

% title(b3,'')
% ylabel(b3,'AdaptExt','FontSize',16,'FontWeight','bold','FontName','Arial')

%%
%Ste colors
blue=[0 0 200]./255;
poster_colors;
colorOrder=[p_red; p_orange; p_fade_green; p_fade_blue; p_plum; p_green; p_blue; p_fade_red; p_lime; p_yellow; p_gray; p_black;[1 1 1]];
colorYoung=[0, 0.4470, 0.7410];%blue;
colorOld=[0.8500, 0.3250, 0.0980];%p_red;
markersize= 10;
for i=1:length(params)
    ah1=findobj(p(i),'Type','Line');
    set(ah1(2),'MarkerFaceColor',colorOld,'MarkerEdgeColor','k','LineWidth',.5,'MarkerSize',markersize);
    set(ah1(1),'MarkerFaceColor','w','MarkerEdgeColor',p_red,'LineWidth',.5,'MarkerSize',markersize);
    set(ah1(4),'MarkerFaceColor',  colorYoung,'MarkerEdgeColor','k','LineWidth',.5,'MarkerSize',markersize);
    set(ah1(3),'MarkerFaceColor','w','MarkerEdgeColor', blue,'LineWidth',.5,'MarkerSize',markersize);
    
    ah11=findobj(p(i),'Type','Patch');
    set(ah11(2),'FaceColor',colorOld,'EdgeColor',colorOld,'FaceAlpha',.4);
    set(ah11(1),'FaceColor','w','EdgeColor',p_red,'FaceAlpha',.3);
    set(ah11(4),'FaceColor', colorYoung,'EdgeColor', colorYoung,'FaceAlpha',.4);
    set(ah11(3),'FaceColor','w','EdgeColor', blue,'FaceAlpha',.3);
    
end

for i=1:length(params)
    ah1=findobj(b(i),'Type','Bar');
    set(ah1(3),'FaceColor','w','EdgeColor',  blue,'LineWidth',2);
    set(ah1(4),'FaceColor',  colorYoung,'EdgeColor','k');
    set(ah1(1),'FaceColor','w','EdgeColor',p_red,'LineWidth',2);
    set(ah1(2),'FaceColor',colorOld,'EdgeColor','k');
   
%     
%     ah1=findobj(b2(i),'Type','Bar');
%     set(ah1(4),'FaceColor','w','EdgeColor', colorYoung,'LineWidth',2);
%     set(ah1(3),'FaceColor', colorYoung,'EdgeColor','k');
%     set(ah1(2),'FaceColor','w','EdgeColor',colorOld,'LineWidth',2);
%     set(ah1(1),'FaceColor',colorOld,'EdgeColor','k');
    
    ah1=findobj(b(i),'Type','Line');
     set(ah1(1:32),'MarkerFaceColor','w','MarkerEdgeColor','k','LineWidth',2);
    
%       ah1=findobj(b2(i),'Type','Line');
%      set(ah1(1:32),'MarkerFaceColor','w','MarkerEdgeColor','k','LineWidth',2);
%      
end


set(gcf,'renderer','painters')
if savefig==1
saveas(gcf,'Figure_5_Catch','pdf')
end
