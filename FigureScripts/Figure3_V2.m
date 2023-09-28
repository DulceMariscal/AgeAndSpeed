%% Figure 3 - Generalization 
%%

% save fig=1;
% params={'netContributionNorm2','spatialContributionNorm2','stepTimeContributionNorm2'}; %Parameters of interest: Sa, Sp, St
params={'netContributionNorm2','alphaAsym','Xasym'};
figure('units','normalized','outerposition',[0 0 1 1])
tc=[1 3 5];
gp=[4 10 16];
pGp=[5 11 17];


binwidth=5; %Window of the running average
trialMarkerFlag=0; %1 if you want to separate the time course by trial, 0 to separate by condition
indivFlag=0; %0 to plot group mean 1 to plot indiv subjects
indivSubs=[]; %Use when you want to plot a specific subject in a group
colorOrder=[]; %Let the function take care of this at least you wanted in a specific set of color then by my guess and add the list here
biofeedback= 0; % Unless you are providing with biofeedback to the subject
removeBiasFlag=1 ; %if you want to remove bias
labels={'YS','YF','OS','OF'}; %Groups names %labels=[];
filterFlag=[];
plotHandles=[];
alignEnd=50; % # strides align at the end of the trial (PLAY with it and see what happens)
alignIni=30; %  # strides align at the beginning of the trial (PLAY with it and see what happens)

conditions={'OG base','OG post'};
epochs={'OGafter','Transfer','TMafter'};

%% Plots 
for i=1:length(params)
    
    p(i)=subplot(3,2,tc(i));
    plotHandles=p(i);
    adaptData=cellfun(@(x) x.adaptData,adaptDataGroups,'UniformOutput',false); %Notice that adaptDataGroups(1) decide that I only want to plot the CG group
    [avg,ind]=adaptationData.plotAvgTimeCourse(adaptData,params{i},conditions,binwidth,trialMarkerFlag,indivFlag,indivSubs,colorOrder,biofeedback,removeBiasFlag,labels,filterFlag,plotHandles,alignEnd,alignIni);
    xlabel(p(i),'strides','FontSize',16,'FontWeight','bold','FontName','Arial')
    b(i)=subplot(3,6,gp(i));
    barGroups(studyData2,results,groups,params{i},epochs(1),1,[],[],b(i))
   b2(i)=subplot(3,6,pGp(i));
    barGroups(studyData2,results,groups,params{i},epochs(2),1,[],[],b2(i))
end


%% Adjusting axis

% Figure 3
set(p(1),'YLim',[-0.03 0.12],'YTick',[ -0.03 0 0.05 0.10],'FontName','Arial','FontSize',12) %SLA
set(p(2),'YLim',[-0.02 0.04],'YTick',[-0.02 0 0.02 0.04],'FontName','Arial','FontSize',12) %Spatial
set(p(3),'YLim',[-0.015 0.08],'YTick',[-0.02 0 0.02 0.04 0.06 0.08],'FontName','Arial','FontSize',12) %Temporal

set(p(1:3),'XLim',[65 192],'XTick',[65 85],'XTickLabel',[0 20],'FontName','Arial','FontSize',12) %SLA



set(b(1),'YLim',[0 0.2],'YTick',[0 0.05 0.1 0.15 0.2],'FontName','Arial','FontSize',12) %SLA
set(b(2),'YLim',[-0.05 0.11],'YTick',[-0.05 0 0.05 0.10],'FontName','Arial','FontSize',12) %Spatial
set(b(3),'YLim',[-0 0.11],'YTick', [-0.02 0 0.05 0.1],'FontName','Arial','FontSize',12) %Temporal

% set(b2(1),'YLim',[0 100],'YTick',[0 20 40 60 80 100],'FontName','Arial','FontSize',12) %SLA
% set(b2(2),'YLim',[-25 80],'YTick',[-20 0 20 40 60 80],'FontName','Arial','FontSize',12) %Spatial
% set(b2(3),'YLim',[-5  60],'YTick',[-5 0 5 15 25 35 45 55],'FontName','Arial','FontSize',12) %Temporal

%% Changing ylabels and titles
text(-19,255,'Figure 3','FontSize',20,'FontWeight','bold','FontName','Arial')
text(-19, 250,'A. Time Courses','FontSize',18,'FontWeight','bold','FontName','Arial')
ylabel(p(1),'S_a','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(p(2),'\alpha_{asym}','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(p(3),'X_{asym}','FontSize',16,'FontWeight','bold','FontName','Arial')


%ylabel(b(1),epochs{1},'FontSize',16,'FontWeight','bold','FontName','Arial')
 title(b(1),'')
ylabel(b(1),'Sa','FontSize',16,'FontWeight','bold','FontName','Arial')
 title(b(2),'')
ylabel(b(2),'\alpha_{asym}','FontSize',16,'FontWeight','bold','FontName','Arial')
 title(b(3),'')
ylabel(b(3),'X_{asym}','FontSize',16,'FontWeight','bold','FontName','Arial')

text(-5, 250,'B. Transfer','FontSize',18,'FontWeight','bold','FontName','Arial')
text(0, 250,'C. %Transfer','FontSize',18,'FontWeight','bold','FontName','Arial')
% % ylabel(b2(1),epochs{2},'FontSize',16,'FontWeight','bold','FontName','Arial')
%  title(b2(1),'')
% ylabel(b2(1),'Sa','FontSize',16,'FontWeight','bold','FontName','Arial')
%  title(b2(2),'')
% ylabel(b2(2),'\alpha_{asym}','FontSize',16,'FontWeight','bold','FontName','Arial')
%  title(b2(3),'')
% ylabel(b2(3),'X_{asym}','FontSize',16,'FontWeight','bold','FontName','Arial')



%%
%Ste colors
blue=[0 0 200]./255;
poster_colors;
colorOrder=[p_red; p_orange; p_fade_green; p_fade_blue; p_plum; p_green; p_blue; p_fade_red; p_lime; p_yellow; p_gray; p_black;[1 1 1]];
colorYoung=[0, 0.4470, 0.7410];%blue;
colorOld=[0.8500, 0.3250, 0.0980];%p_red;

markersize=10;
LineWidth=0.5;
FaceAlpha=0.4;
FaceAlpha2=0.3;
for i=1:length(params)
    ah1=findobj(p(i),'Type','Line');
    set(ah1(5:8),'MarkerFaceColor',colorOld,'MarkerEdgeColor','k','LineWidth',LineWidth,'MarkerSize',markersize);
    set(ah1(1:4),'MarkerFaceColor','w','MarkerEdgeColor',p_red,'LineWidth',LineWidth,'MarkerSize',markersize);
    set(ah1(13:16),'MarkerFaceColor',  colorYoung,'MarkerEdgeColor','k','LineWidth',LineWidth,'MarkerSize',markersize);
    set(ah1(9:12),'MarkerFaceColor','w','MarkerEdgeColor',blue ,'LineWidth',LineWidth,'MarkerSize',markersize);
    
    ah11=findobj(p(i),'Type','Patch');
    set(ah11(5:8),'FaceColor',colorOld,'EdgeColor',colorOld,'FaceAlpha',FaceAlpha);
    set(ah11(1:4),'FaceColor','w','EdgeColor',p_red,'FaceAlpha',FaceAlpha2);
    set(ah11(13:16),'FaceColor', colorYoung,'EdgeColor', colorYoung,'FaceAlpha',FaceAlpha);
    set(ah11(9:12),'FaceColor','w','EdgeColor', blue,'FaceAlpha',FaceAlpha2);
    
end


LineWidth_Bars=2;


for i=1:length(params)
    ah1=findobj(b(i),'Type','Bar');
    set(ah1(3),'FaceColor','w','EdgeColor',  blue,'LineWidth',LineWidth_Bars);
    set(ah1(4),'FaceColor',  colorYoung,'EdgeColor','k');
    set(ah1(1),'FaceColor','w','EdgeColor',p_red,'LineWidth',LineWidth_Bars);
    set(ah1(2),'FaceColor',colorOld,'EdgeColor','k');
   
    
    ah1=findobj(b2(i),'Type','Bar');
    set(ah1(3),'FaceColor','w','EdgeColor', blue ,'LineWidth',LineWidth_Bars);
    set(ah1(4),'FaceColor', colorYoung,'EdgeColor','k');
    set(ah1(1),'FaceColor','w','EdgeColor',p_red,'LineWidth',LineWidth_Bars);
    set(ah1(2),'FaceColor',colorOld,'EdgeColor','k');
    

    ah1=findobj(b(i),'Type','Line');
     set(ah1(1:32),'MarkerFaceColor','w','MarkerEdgeColor','k','LineWidth',LineWidth_Bars);
    
     ah1=findobj(b2(i),'Type','Line');
     set(ah1(1:32),'MarkerFaceColor','w','MarkerEdgeColor','k','LineWidth',LineWidth_Bars);
  
end


set(gcf,'renderer','painters')
if savefig==1
saveas(gcf,'Figure_3_AfterEffects_Alpha','pdf')
end
