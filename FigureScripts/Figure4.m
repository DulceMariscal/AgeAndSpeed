%%Figure 4 - Washout 
% savefig=1;
figure('units','normalized','outerposition',[0 0 1 1])
wp=[1 2 3];


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


epochs={'TMafter'};

%% Plots 
for i=1:length(params)
    
     b3(i)=subplot(3,6,wp(i));
    barGroups(studyData2,results,groups,params{i},epochs(1),1,[],[],b3(i))
    
end

%Figure 4 

set(b3(1),'YLim',[0 0.2],'YTick',[0 0.05 0.1 0.15 0.2],'FontName','Arial','FontSize',12) %SLA
% set(b3(2),'YLim',[-0.06 0.2],'YTick',[-0.05 0 0.05 0.1 0.15 0.2],'FontName','Arial','FontSize',12) %Spatial
% set(b3(3),'YLim',[-0.015 0.10],'YTick',[-0.015 0 0.05 0.10],'FontName','Arial','FontSize',12) %Temporal

text(-11,0.13,'Figure 4','FontSize',20,'FontWeight','bold','FontName','Arial')
text(-10, 0.12,'Washout','FontSize',18,'FontWeight','bold','FontName','Arial')
% ylabel(b3(1),epochs{3},'FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(b3(1),'Sa','FontSize',16,'FontWeight','bold','FontName','Arial')
title(b3(1),'')
title(b3(2),'')
ylabel(b3(2),'Sp','FontSize',16,'FontWeight','bold','FontName','Arial')
title(b3(3),'')
ylabel(b3(3),'St','FontSize',16,'FontWeight','bold','FontName','Arial')

%%
%Ste colors
blue=[0 0 200]./255;
poster_colors;
colorOrder=[p_red; p_orange; p_fade_green; p_fade_blue; p_plum; p_green; p_blue; p_fade_red; p_lime; p_yellow; p_gray; p_black;[1 1 1]];
colorYoung=blue;
colorOld=p_red;

LineWidth_Bars=2;


for i=1:length(params)
    
     ah1=findobj(b3(i),'Type','Bar');
    set(ah1(4),'FaceColor','w','EdgeColor', colorYoung,'LineWidth',LineWidth_Bars);
    set(ah1(3),'FaceColor', colorYoung,'EdgeColor','k');
    set(ah1(2),'FaceColor','w','EdgeColor',colorOld,'LineWidth',LineWidth_Bars);
    set(ah1(1),'FaceColor',colorOld,'EdgeColor','k');

     
      ah1=findobj(b3(i),'Type','Line');
     set(ah1(1:32),'MarkerFaceColor','w','MarkerEdgeColor','k','LineWidth',LineWidth_Bars);
     
end


set(gcf,'renderer','painters')
if savefig==1
saveas(gcf,'Figure_4_Washout','pdf')
end