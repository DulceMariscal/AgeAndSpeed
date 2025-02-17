%%  Posthoc analysis figures - Walking speeds 
%%
% For OG walking we use the "singleStanceSpeed(speed)AbsHIP" since the hip is a good representation
% of the overall walking speed of the participant. For TM walking we use
% the "singleStanceSpeed(speed)AbsANK", the speed of the ankle marker is a good referece for the
% actual treadmill speed. 

%% OG baseline and post-adaptation walking speed 

params={'singleStanceSpeedFastAbsANK','singleStanceSpeedSlowAbsANK','singleStanceSpeedFastAbsHIP','singleStanceSpeedSlowAbsHIP'};
figure('units','normalized','outerposition',[0 0 1 1])
binwidth=1; %Window of the running average. 1 so we can get a stride by stride data 
trialMarkerFlag=0; %0 to separate by condition
indivFlag=0; %0 to plot group mean
indivSubs=[]; %Use when you want to plot a specific subject in a group
colorOrder=[]; %Let the function take care of this at least you wanted in a specific set of color then by my guess and add the list here
biofeedback= 0; % Unless you are providing with biofeedback to the subject
removeBiasFlag=0 ; %if you want to remove bias
labels={'YS','YF','OS','OF'}; %Groups names %labels=[];
filterFlag=[];
plotHandles=[];
alignEnd=0; % # strides align at the end of the trial (PLAY with it and see what happens)
alignIni=0; %  # strides align at the beginning of the trial (PLAY with it and see what happens)
conditions={'OG base','OG post','TM base'};

adaptData=cellfun(@(x) x.adaptData,adaptDataGroups,'UniformOutput',false); %Notice that adaptDataGroups(1) decide that I only want to plot the CG group
[~,ind]=adaptationData.plotAvgTimeCourse(adaptData,params,conditions,binwidth,trialMarkerFlag,indivFlag,indivSubs,colorOrder,biofeedback,removeBiasFlag,labels,filterFlag,plotHandles,alignEnd,alignIni);
close all 

%Getting the mean speed between the 2 markers for each stride. I do
%this to make the outcome more robust.  
speed=[]; 

%Getting data 

%Overground data
cond={'OGbase','OGpost'};
OGparams= {'singleStanceSpeedFastAbsHIP','singleStanceSpeedSlowAbsHIP'};

for group=1:length(labels)
    for c=1:length(cond)
        
        OGspeed= [(ind(group).(OGparams{1}).(cond{c}).trial1+ind(group).(OGparams{2}).(cond{c}).trial1)/2]./1000;
             
        speed.(labels{group}).(cond{c}).mean= nanmean(OGspeed,2);
        speed.(labels{group}).(cond{c}).std= nanstd(OGspeed,0,2);   
        
    end
end%-- 2/14/25, 1:36?PM --%

%Treadmill data
cond={'TMbase'};
TMparams= {'singleStanceSpeedFastAbsANK','singleStanceSpeedSlowAbsANK'};

for group=1:length(labels)
    for c=1:length(cond)
        
        TMspeed= [(ind(group).(TMparams{1}).(cond{c}).trial1+ind(group).(TMparams{2}).(cond{c}).trial1)/2]./1000;
             
        speed.(labels{group}).(cond{c}).mean= nanmean(TMspeed,2);
        speed.(labels{group}).(cond{c}).std= nanstd(TMspeed,0,2);   
        
    end
    % |TMbase - OGbase| 
    speed.(labels{group}).SpeedDiff.mean= abs(speed.(labels{group}).TMbase.mean - speed.(labels{group}).OGpost.mean);
end

%% Figure 
ageGroup={'YA','OA'};
cond={'OGbase','OGpost','SpeedDiff'};
figure('units','normalized','outerposition',[0 0 1 1])
for c= 1:3
    p(c)=subplot(1,3,c)
  
    for g=1:4
        bar(g,mean(speed.(labels{g}).(cond{c}).mean),'b')
        hold on 
        errorbar(g,mean(speed.(labels{g}).(cond{c}).mean),std(speed.(labels{g}).(cond{c}).mean)/sqrt(8),'k')
        plot(g+0.1,speed.(labels{g}).(cond{c}).mean,'o','MarkerFaceColor','k','MarkerEdgeColor','k')
    end
    ylabel({cond{c};'(m/s)'})
    xticks(1:4)
    xticklabels({'Young_{slow}','Younger_{fast}','Older_{slow}','Older_{fast}'})
end

% Editing color 
set(p(1),'YLim',[0 1.4],'YTick',[0:0.2:1.4],'FontName','Arial','FontSize',12) %OG base
set(p(2),'YLim',[0 1.4],'YTick',[0:0.2:1.4],'FontName','Arial','FontSize',12) %OG post
set(p(3),'YLim',[0 0.6],'YTick',[0:0.2:0.6],'FontName','Arial','FontSize',12) %Speed Difference

%Set colors
blue=[0 0 200]./255;
poster_colors;
colorOrder=[p_red; p_orange; p_fade_green; p_fade_blue; p_plum; p_green; p_blue; p_fade_red; p_lime; p_yellow; p_gray; p_black;[1 1 1]];
colorYoung=[0, 0.4470, 0.7410];%blue;
colorOld=[0.8500, 0.3250, 0.0980];%p_red;

LineWidth_Bars=2;
for i=1:3
    ah1=findobj(p(i),'Type','Bar');
    set(ah1(3),'FaceColor','w','EdgeColor',  blue,'LineWidth',LineWidth_Bars);
    set(ah1(4),'FaceColor',  colorYoung,'EdgeColor','k');
    set(ah1(1),'FaceColor','w','EdgeColor',p_red,'LineWidth',LineWidth_Bars);
    set(ah1(2),'FaceColor',colorOld,'EdgeColor','k');
end
set(gcf,'Color','white')