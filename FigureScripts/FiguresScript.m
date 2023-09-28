%figures for age and speed paper

%% Fig 1 

base=1*ones(2,150);
rampUp=linspace(1,1.4,600);
rampDown=linspace(1,0.7,600);
catc=1*ones(2,10);
holdUp=1.4*ones(1,300);
holdDown=.7*ones(1,300);
ramp=[rampUp;rampDown];
split=[holdUp;holdDown];
speedProfile=[ramp nan(2,1) catc nan(2,1) split];

figure

plot(speedProfile(1,:),'Linewidth',2);hold on ; plot(speedProfile(2,:),'Linewidth',2)
ylabel({'Fast group';'Belts speed (m/s)'})
axis([0 1050 0.65 1.45])
xlabel('Strides')
yticks([0.7 1 1.4])
yticklabels({'0.7','1','1.4'})
yyaxis right
% plot(speedProfile(1,:));hold on ; plot(speedProfile(2,:))
yticks([0.05 0.45 0.95])
yticklabels({'0.6','0.9','1.2'})
ylabel({'Slow group';'Belts speed  (m/s)'})
set(gcf,'color','w');

%% Fig 2: Adaptation 
%%
%  load('C:\Users\dum5\Box\aResearch_Projects\AgeSpeedStudy\ProcessedData\1162019 processing\UnbiasGroupData.mat')

conditions={'TM base','adaptation','re'};
params={'netContributionNorm2','spatialContributionNorm2','stepTimeContributionNorm2','velocityContributionNorm2'};

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
alignIni=0; %  # strides align at the beginning of the trial (PLAY with it and see what happens)

f1=figure('Name','Adaptation');
set(gcf,'color','w');
ah(1)=subplot(4,2,1);
ah(2)=subplot(4,2,3);
ah(3)=subplot(4,2,5);
ah(4)=subplot(4,2,7);


for p=1:length(params)
%   ah(p)=subplot(4,3,p)
  plotHandles=ah(p);
adaptData=cellfun(@(x) x.adaptData,adaptDataGroups,'UniformOutput',false); %Notice that adaptDataGroups(1) decide that I only want to plot the CG group
adaptationData.plotAvgTimeCourse(adaptData,params{p},conditions,binwidth,trialMarkerFlag,indivFlag,indivSubs,colorOrder,biofeedback,removeBiasFlag,labels,filterFlag,plotHandles,alignEnd,alignIni);
end

ah(1)=subplot(4,4,3);
ah(2)=subplot(4,4,7);
ah(3)=subplot(4,4,11);
ah(4)=subplot(4,4,15);



