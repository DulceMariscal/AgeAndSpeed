%Figure 2 - Adaptation Figure
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
trialMarkerFlag=[0 0 1]; %1 if you want to separate the time course by trial, 0 to separate by condition
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


conditions={'Adaptation','catch','re'};
epochs={'catch','TMsteady','ExtentOfAdaptation'};
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
    b2(i)=subplot(3,6,ssp(i));
    barGroups(studyData2,results,groups,params{i},epochs(2),1,[],[],b2(i))
end

%% Adjusting axis
text(-23,1.28,'Figure 2','FontSize',20,'FontWeight','bold','FontName','Arial')
text(-23, 1.25,'A. Time Courses','FontSize',18,'FontWeight','bold','FontName','Arial')
set(p(1),'YLim',[-0.25 0.2],'YTick',[-0.25 -0.15 -0.05 0 0.05 0.15],'FontName','Arial','FontSize',12) %SLA
set(p(2),'YLim',[-0.05 0.1],'YTick',[-0.1 -0.05 0 0.05 0.1 0.15],'FontName','Arial','FontSize',12) %Alpha
set(p(3),'YLim',[-0.25 0.15],'YTick',[-0.25 -0.2 -0.15 -0.1 -0.05 0 0.05 0.1 0.15 ],'FontName','Arial','FontSize',12) %Temporal

text(-9, 1.25,'B. Catch','FontSize',18,'FontWeight','bold','FontName','Arial')
text(-5, 1.25,'C. Steady State','FontSize',18,'FontWeight','bold','FontName','Arial')
%text(0, 0.4,'D. Extend of Adaptation','FontSize',18,'FontWeight','bold','FontName','Arial')

set(b(1),'YLim',[0 0.21],'YTick',[0 0.05 0.1 0.15 0.2],'FontName','Arial','FontSize',12) %SLA
set(b(2),'YLim',[-0.05 0.1],'YTick',[-0.05 0 0.05 0.10 ],'FontName','Arial','FontSize',12) %Alpha
set(b(3),'YLim',[0 0.15],'YTick',[0 0.05 0.15],'FontName','Arial','FontSize',12) %Temporal


set(b2(1),'YLim',[-0.2 0.065],'YTick',[-0.2 -0.1 0 0.05 ],'FontName','Arial','FontSize',12) %SLA
set(b2(2),'YLim',[0 0.12],'YTick',[0 0.06 0.12],'FontName','Arial','FontSize',12) %Alpha
set(b2(3),'YLim',[-.2 0],'YTick',[-0.2 -0.15 -0.1 -0.05 0],'FontName','Arial','FontSize',12) %Temporal

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
title(b2(1),'')
ylabel(b2(1),'S_a','FontSize',16,'FontWeight','bold','FontName','Arial')
title(b2(2),'')
ylabel(b2(2),'\alpha_{asym}','FontSize',16,'FontWeight','bold','FontName','Arial')
title(b2(3),'')
ylabel(b2(3),'X_{asym}','FontSize',16,'FontWeight','bold','FontName','Arial')

% title(b3,'')
% ylabel(b3,'AdaptExt','FontSize',16,'FontWeight','bold','FontName','Arial')

%%
%Ste colors
blue=[0 0 200]./255;
poster_colors;
colorOrder=[p_red; p_orange; p_fade_green; p_fade_blue; p_plum; p_green; p_blue; p_fade_red; p_lime; p_yellow; p_gray; p_black;[1 1 1]];
colorYoung=blue;
colorOld=p_red;
markersize= 10;
for i=1:length(params)
    ah1=findobj(p(i),'Type','Line');
    set(ah1(1:4),'MarkerFaceColor',colorOld,'MarkerEdgeColor','k','LineWidth',.05,'MarkerSize',markersize);
    set(ah1(5:8),'MarkerFaceColor','w','MarkerEdgeColor',colorOld,'LineWidth',.05,'MarkerSize',markersize);
    set(ah1(9:12),'MarkerFaceColor',  colorYoung,'MarkerEdgeColor','k','LineWidth',.5,'MarkerSize',markersize);
    set(ah1(13:16),'MarkerFaceColor','w','MarkerEdgeColor', colorYoung,'LineWidth',.05,'MarkerSize',markersize);
    
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
    
    ah1=findobj(b(i),'Type','Line');
     set(ah1(1:32),'MarkerFaceColor','w','MarkerEdgeColor','k','LineWidth',2);
    
      ah1=findobj(b2(i),'Type','Line');
     set(ah1(1:32),'MarkerFaceColor','w','MarkerEdgeColor','k','LineWidth',2);
     
end


set(gcf,'renderer','painters')
if savefig==1
saveas(gcf,'Figure_2_Adaptation_Alpha','pdf')
end
