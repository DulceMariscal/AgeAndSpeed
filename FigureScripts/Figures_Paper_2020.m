%% Data organization

cd('/Users/dulcemariscal/Box/11_Research_Projects/AgeSpeedStudy/ProcessedData/1162019 processing')

YoungSlow=adaptationData.createGroupAdaptData({'OG31params','OG32params','OG33params','OG39params','OG42params','OG43params','OG45params','OG99params'});
YoungFast=adaptationData.createGroupAdaptData({'OG65params','OG66params','OG69params','OG86params','OG100params','OG101params','OG102params','OG105params'});
OldSlow=adaptationData.createGroupAdaptData({'OG17params','OG19params','OG24params','OG25params','OG26params','OG27params','OG28params','OG29params'});
OldFast=adaptationData.createGroupAdaptData({'OG70params','OG72params','OG74params','OG75params','OG84params','OG103params','OG104params','OG106params'});

adaptDataGroups{1}=YoungSlow;
adaptDataGroups{2}=YoungFast;
adaptDataGroups{3}=OldSlow;
adaptDataGroups{4}=OldFast;
% 
% adaptDataGroups{1}=adaptDataGroups{1}.removeBadStrides;
% adaptDataGroups{2}=adaptDataGroups{2}.removeBadStrides;
% adaptDataGroups{3}=adaptDataGroups{3}.removeBadStrides;
% adaptDataGroups{4}=adaptDataGroups{4}.removeBadStrides;
% 
% adaptDataGroups{1}=adaptDataGroups{1}.removeBias;
% adaptDataGroups{2}=adaptDataGroups{2}.removeBias;
% adaptDataGroups{3}=adaptDataGroups{3}.removeBias;
% adaptDataGroups{4}=adaptDataGroups{4}.removeBias;

studyData2.OF=OldFast;
studyData2.OS=OldSlow;
studyData2.YS=YoungSlow;
studyData2.YF=YoungFast;



%% Getting average data for bar plots
params={'netContributionNorm2','spatialContributionNorm2','stepTimeContributionNorm2','velocityContributionNorm2'};
groups={'YS','YF','OS','OF'}; %Groups names %labels=[];
plotFlag=0;
indivFlag=0;
maxPerturb=0;
results = getResultsSMART(studyData2,params,groups,maxPerturb,plotFlag,indivFlag);
%%
Figure1.m
Figure2.m
Figure3_4.m
%%
figure
tc=[1 3 5 7];
bp=[3 7 11 15];
bp2=[4 8 12 16];


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
epochs={'OGafter','Transfer3'};

% conditions={'TM base','TM post'};
% epochs={'TMafter','Washout2'};

conditions={'Adaptation','catch','re'};
% % epochs={'TMsteady','ExtentOfAdaptation'};
 epochs={'catch','TMsteady'};
% 
% if strcmp(conditions,{'Adaptation','re'})
% alignEnd=0;
% alignIni=0;
% end

% conditions={'catch'};
% epochs={'catch','catch'};

if strcmp(conditions{2},'catch')
YoungFast=adaptationData.createGroupAdaptData({'OG65params','OG66params','OG69params','OG86params',...
    'OG101params','OG102params','OG105params'}); %OG100 data from the catch trial is missing due to problems during data collection 
adaptDataGroups{2}=YoungFast;
adaptDataGroups{2}=adaptDataGroups{2}.removeBadStrides;
adaptDataGroups{2}=adaptDataGroups{2}.removeBias;
alignEnd=0;
alignIni=0;
end




for i=1:length(params)
    
    p(i)=subplot(length(params),2,tc(i));
    plotHandles=p(i);
    adaptData=cellfun(@(x) x.adaptData,adaptDataGroups,'UniformOutput',false); %Notice that adaptDataGroups(1) decide that I only want to plot the CG group
    [avg,ind]=adaptationData.plotAvgTimeCourse(adaptData,params{i},conditions,binwidth,trialMarkerFlag,0,indivSubs,colorOrder,biofeedback,removeBiasFlag,labels,filterFlag,plotHandles,alignEnd,alignIni);
    xlabel(p(i),'strides','FontSize',16,'FontWeight','bold','FontName','Arial')
    b(i)=subplot(length(params),4,bp(i));
    barGroups(studyData2,results,groups,params{i},epochs(1),1,[],[],b(i))
    b2(i)=subplot(length(params),4,bp2(i));
    barGroups(studyData2,results,groups,params{i},epochs(2),1,[],[],b2(i))
end



ylabel(p(1),'StepAsym','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(p(2),'Sp','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(p(3),'St','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(p(4),'Sv','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(b(1),'StepAsym','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(b(2),'Sp','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(b(3),'St','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(b(4),'Sv','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(b2(1),'StepAsym','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(b2(2),'Sp','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(b2(3),'St','FontSize',16,'FontWeight','bold','FontName','Arial')
ylabel(b2(4),'Sv','FontSize',16,'FontWeight','bold','FontName','Arial')

if strcmp(conditions,{'OG base','OG post'})
    set(p(:),'XLim',[56 160],'XTick',[56 66],'XTickLabel',[0 10] )
    %OG post
    set(p(1),'YLim',[-0.039 0.12],'YTick',[0 0.06 0.12],'FontName','Arial','FontSize',12) %SLA
    set(p(2),'YLim',[-0.036 0.08],'YTick',[-0.03 0 0.04 0.08],'FontName','Arial','FontSize',12) %Spatial
    set(p(3),'YLim',[-0.012 0.08],'YTick',[-0.01 0 0.04 0.08],'FontName','Arial','FontSize',12) %Temporal
    set(p(4),'YLim',[-0.015 0.08],'YTick',[-0.015 0 0.04 0.08],'FontName','Arial','FontSize',12) %Velocity
    
    
    set(b(1),'YLim',[0 0.22],'YTick',[0 0.05 0.1 0.15 0.2],'FontName','Arial','FontSize',12) %SLA
    set(b(2),'YLim',[-0.06 0.22],'YTick',[-0.05 0 0.05 0.1 0.15 0.2],'FontName','Arial','FontSize',12) %Spatial
    set(b(3),'YLim',[0 0.10],'YTick',[0 0.05 0.10],'FontName','Arial','FontSize',12) %Temporal
    set(b(4),'YLim',[-0.07 0.08],'YTick',[-0.07  -0.04 0 0.04 0.08],'FontName','Arial','FontSize',12) %Velocity
    
    set(b2(1),'YLim',[-0.5 90],'YTick',[0 20 40 60 80],'FontName','Arial','FontSize',12) %SLA
    set(b2(2),'YLim',[-28 100],'YTick',[-20 0 20 40 60 80 100],'FontName','Arial','FontSize',12) %Spatial
    set(b2(3),'YLim',[0 50],'YTick',[0 15 30 45],'FontName','Arial','FontSize',12) %Temporal
    set(b2(4),'YLim',[-20 45],'YTick',[-20 0 20 40],'FontName','Arial','FontSize',12) %Velocity
    
elseif strcmp(conditions,{'TM base','TM post'})
    
    set(p(:),'XLim',[56 160],'XTick',[56 66],'XTickLabel',[0 10] )
    
    set(p(1),'YLim',[-0.015 0.12],'YTick',[0 0.02 0.04 0.06 0.08 0.10 0.12],'FontName','Arial','FontSize',12) %SLA
    set(p(2),'YLim',[-0.02 0.10],'YTick',[-0.02 0 0.02 0.04 0.06 0.08 0.10],'FontName','Arial','FontSize',12) %Spatial
    set(p(3),'YLim',[-0.015 0.06],'YTick',[-0.015 0 0.02 0.04 0.06],'FontName','Arial','FontSize',12) %Temporal
    set(p(4),'YLim',[-0.015 0.06],'YTick',[-0.015 0 0.02 0.04 0.06],'FontName','Arial','FontSize',12) %Velocity
    
    set(b(1),'YLim',[0 0.2],'YTick',[0 0.05 0.1 0.15 0.2],'FontName','Arial','FontSize',12) %SLA
    set(b(2),'YLim',[-0.06 0.2],'YTick',[-0.05 0 0.05 0.1 0.15 0.2],'FontName','Arial','FontSize',12) %Spatial
    set(b(3),'YLim',[-0.015 0.10],'YTick',[-0.015 0 0.05 0.10],'FontName','Arial','FontSize',12) %Temporal
    set(b(4),'YLim',[-0.04 0.05],'YTick',[-0.04 0 0.05],'FontName','Arial','FontSize',12) %Velocity
    
    % set(b2(1),'YLim',[-0.5 90],'YTick',[0 20 40 60 80]) %SLA
    % set(b2(2),'YLim',[-28 100],'YTick',[-20 0 20 40 60 80 100]) %Spatial
    % set(b2(3),'YLim',[0 50],'YTick',[0 15 30 45]) %Temporal
    % set(b2(4),'YLim',[-20 45],'YTick',[-20 0 20 40]) %Velocity
    
elseif strcmp(conditions,{'Adaptation','re'})
    set(p(:),'XLim',[0 900],'XTick',[0 100],'XTickLabel',[0 100])
    
    set(p(1),'YLim',[-0.25 0],'YTick',[-0.25 -0.15 -0.05 0],'FontName','Arial','FontSize',12) %SLA
    set(p(2),'YLim',[-0.1 0.15],'YTick',[-0.1 -0.05 0 0.05 0.1 0.15],'FontName','Arial','FontSize',12) %Spatial
    set(p(3),'YLim',[-0.02 0.2],'YTick',[0 0.05 0.1 0.15 0.2],'FontName','Arial','FontSize',12) %Temporal
    set(p(4),'YLim',[-0.35 0.05],'YTick',[-0.3 -0.20 -0.1 0],'FontName','Arial','FontSize',12) %Velocity
    
    set(b(1),'YLim',[-0.2 0.065],'YTick',[-0.2 -0.1 0 0.05 ],'FontName','Arial','FontSize',12) %SLA
    set(b(2),'YLim',[-0.015 0.21],'YTick',[-0.05 0 0.05 0.1 0.15 0.2],'FontName','Arial','FontSize',12) %Spatial
    set(b(3),'YLim',[0 0.2],'YTick',[0 0.05 0.10 0.15 0.2],'FontName','Arial','FontSize',12) %Temporal
    set(b(4),'YLim',[-0.35 0],'YTick',[-0.3 -0.2 -0.1 0],'FontName','Arial','FontSize',12)%Velocity
    
    set(b2(1:4),'YLim',[0 0.4],'YTick',[00 0.1 0.2 0.3 0.4],'FontName','Arial','FontSize',12) %ExtAdapt

    
elseif strcmp(conditions,{'catch'})

    set(p(:),'XLim',[0.5 10],'XTick',[1 10],'XTickLabel',[1 10])
    
    set(p(1),'YLim',[0 0.18],'YTick',[0 0.05 0.1 0.15],'FontName','Arial','FontSize',12) %SLA
    set(p(2),'YLim',[0 0.15],'YTick',[0 0.05 0.1 0.15],'FontName','Arial','FontSize',12) %Spatial
    set(p(3),'YLim',[-0.02 0.1],'YTick',[-0.02 0 0.05 0.1 0.15 0.2],'FontName','Arial','FontSize',12) %Temporal
    set(p(4),'YLim',[-0.02 0.1],'YTick',[-0.02 0 0.05 0.1 0.15 0.2],'FontName','Arial','FontSize',12) %Velocity
    
    set(b(1),'YLim',[0 0.2],'YTick',[0 0.05 0.1 0.15 0.2],'FontName','Arial','FontSize',12) %SLA
    set(b(2),'YLim',[-0.025 0.2],'YTick',[0 0.05 0.10 0.15 0.2],'FontName','Arial','FontSize',12) %Spatial
    set(b(3),'YLim',[-0.1 0.12],'YTick',[-0.1 -0.05 0 0.05 0.1],'FontName','Arial','FontSize',12) %Temporal
    set(b(4),'YLim',[-0.05 0.1],'YTick',[-0.05 0 0.05 0.1],'FontName','Arial','FontSize',12) %Velocity
    
    set(b2(1),'YLim',[0 0.2],'YTick',[0 0.05 0.1 0.15 0.2],'FontName','Arial','FontSize',12) %SLA
    set(b2(2),'YLim',[-0.025 0.2],'YTick',[0 0.05 0.10 0.15 0.2],'FontName','Arial','FontSize',12) %Spatial
    set(b2(3),'YLim',[-0.1 0.12],'YTick',[-0.1 -0.05 0 0.05 0.1],'FontName','Arial','FontSize',12) %Temporal
    set(b2(4),'YLim',[-0.05 0.1],'YTick',[-0.05 0 0.05 0.1],'FontName','Arial','FontSize',12) %Velocity
    
    
end

%% Changing color to axes
blue=[0 0 153]./255;
    poster_colors;
    colorOrder=[p_red; p_orange; p_fade_green; p_fade_blue; p_plum; p_green; p_blue; p_fade_red; p_lime; p_yellow; p_gray; p_black;[1 1 1]];         


 colorYoung=blue;
 colorOld=p_orange;
 for i=1:4
        ah1=findobj(p(i),'Type','Line');
        if strcmp(conditions,{'Adaptation','re'})
            set(ah1(1:2),'MarkerFaceColor',colorOld,'MarkerEdgeColor','k');
            set(ah1(3:4),'MarkerFaceColor','w','MarkerEdgeColor',colorOld);
            set(ah1(5:6),'MarkerFaceColor',  colorYoung,'MarkerEdgeColor','k');
            set(ah1(7:8),'MarkerFaceColor','w','MarkerEdgeColor', colorYoung);
            
            ah11=findobj(p(i),'Type','Patch');
            
            set(ah11(1:2),'FaceColor',colorOld,'EdgeColor',colorOld,'FaceAlpha',.4);
            set(ah11(3:4),'FaceColor','w','EdgeColor',colorOld,'FaceAlpha',.3);
            set(ah11(5:6),'FaceColor', colorYoung,'EdgeColor', colorYoung,'FaceAlpha',.4);
            set(ah11(7:8),'FaceColor','w','EdgeColor', colorYoung,'FaceAlpha',.3);
        elseif strcmp(conditions,{'catch'})
            
            set(ah1(1),'MarkerFaceColor',colorOld,'MarkerEdgeColor','k');
            set(ah1(2),'MarkerFaceColor','w','MarkerEdgeColor',colorOld);
            set(ah1(3),'MarkerFaceColor',  colorYoung,'MarkerEdgeColor','k');
            set(ah1(4),'MarkerFaceColor','w','MarkerEdgeColor', colorYoung);
            
            ah11=findobj(p(i),'Type','Patch');
            
            set(ah11(1),'FaceColor',colorOld,'EdgeColor',colorOld,'FaceAlpha',.4);
            set(ah11(2),'FaceColor','w','EdgeColor',colorOld,'FaceAlpha',.3);
            set(ah11(3),'FaceColor', colorYoung,'EdgeColor', colorYoung,'FaceAlpha',.4);
            set(ah11(4),'FaceColor','w','EdgeColor', colorYoung,'FaceAlpha',.3);
        
        else 
            set(ah1(1:4),'MarkerFaceColor',colorOld,'MarkerEdgeColor','k');
            set(ah1(5:8),'MarkerFaceColor','w','MarkerEdgeColor',colorOld);
            set(ah1(9:12),'MarkerFaceColor', colorYoung,'MarkerEdgeColor','k');
            set(ah1(13:16),'MarkerFaceColor','w','MarkerEdgeColor', colorYoung);
            
            ah11=findobj(p(i),'Type','Patch');
            
            set(ah11(1:4),'FaceColor',colorOld,'EdgeColor',colorOld,'FaceAlpha',.4);
            set(ah11(5:8),'FaceColor','w','EdgeColor',colorOld,'FaceAlpha',.3);
            set(ah11(9:12),'FaceColor',  colorYoung,'EdgeColor', colorYoung,'FaceAlpha',.4);
            set(ah11(13:16),'FaceColor','w','EdgeColor', colorYoung,'FaceAlpha',.3);
        end
        
 end

    for i=1:4
        ah1=findobj(b(i),'Type','Bar');
        set(ah1(4),'FaceColor','w','EdgeColor',  colorYoung,'LineWidth',5);
        set(ah1(3),'FaceColor',  colorYoung,'EdgeColor','k');
        set(ah1(2),'FaceColor','w','EdgeColor',colorOld,'LineWidth',5);
        set(ah1(1),'FaceColor',colorOld,'EdgeColor','k');
        ah1=findobj(b2(i),'Type','Bar');
        set(ah1(4),'FaceColor','w','EdgeColor', colorYoung,'LineWidth',5);
        set(ah1(3),'FaceColor', colorYoung,'EdgeColor','k');
        set(ah1(2),'FaceColor','w','EdgeColor',colorOld,'LineWidth',5);
        set(ah1(1),'FaceColor',colorOld,'EdgeColor','k');
        
    end

    
    
%% Speed differences 

load('ResultsSpeedsSfn2019.mat')
SpeedDiffer=[results.TMsteady.indiv.singleStanceSpeedFastAbs(:,1) results.TMsteady.indiv.singleStanceSpeedFastAbs(:,2)-results.TMsteady.indiv.singleStanceSpeedSlowAbs(:,2)]; 


figure 
for i=1:4
    hold on 
    a=find(SpeedDiffer(:,1)==i);
    
    bar(i, mean(SpeedDiffer(a,2)))
    for x=1:length(a)
     plot(i+.2,SpeedDiffer(a(x),2),'.','Color','k','MarkerSize',15)
    end 
    errorbar(i, mean(SpeedDiffer(a,2)),std(SpeedDiffer(a,2)),'.','LineWidth',2,'Color','k')
end 
ylabel('Speed Differences')

YS=find(results.TMsteady.indiv.singleStanceSpeedFastAbs(:,1)==1);
YF=find(results.TMsteady.indiv.singleStanceSpeedFastAbs(:,1)==2);
OS=find(results.TMsteady.indiv.singleStanceSpeedFastAbs(:,1)==3);
OF=find(results.TMsteady.indiv.singleStanceSpeedFastAbs(:,1)==4);
AGE=[0.*ones(length([YS' YF']), 1); ones(length([OS' OF']), 1)];
SPEED=[0.*ones(size(YS,1) ,1); ones(size(YF,1),1); 0.*ones(size(OS,1) ,1); ones(size(OF,1),1); ];
%Data=[YS'; YF';OS'; OF'];
%tableData=[AGE, SPEED, Data];
Data=SpeedDiffer(:,2);
[p, tbl,stats,terms]= anovan(Data,{AGE SPEED},'model','interaction','varnames',{'AGE','SPEED'});
    
%% Post-hoc analysis 
load('ResultsSfn2019.mat')

ys=find(results.TMsteady.indiv.netContributionNorm2(:,1)==1);
yf=find(results.TMsteady.indiv.netContributionNorm2(:,1)==2);
os=find(results.TMsteady.indiv.netContributionNorm2(:,1)==3);
of=find(results.TMsteady.indiv.netContributionNorm2(:,1)==4);

%steady state 
[h,p,ci,stats] =ttest2(results.TMsteady.indiv.netContributionNorm2(os,2),results.TMsteady.indiv.netContributionNorm2(of,2))

%OG after 
[h,p,ci,stats] =ttest2(results.OGafter.indiv.netContributionNorm2(os,2),results.OGafter.indiv.netContributionNorm2(of,2))
[h,p,ci,stats] =ttest2(results.OGafter.indiv.netContributionNorm2(ys,2),results.OGafter.indiv.netContributionNorm2(yf,2))
[h,p,ci,stats] =ttest2(results.OGafter.indiv.spatialContributionNorm2(ys,2),results.OGafter.indiv.spatialContributionNorm2(yf,2))
[h,p,ci,stats] =ttest2(results.OGafter.indiv.spatialContributionNorm2(os,2),results.OGafter.indiv.spatialContributionNorm2(of,2))
