%final results

% cd('/Users/dulcemariscal/Box/11_Research_Projects/AgeSpeedStudy/ProcessedData/1162019 processing')

% YoungSlow=adaptationData.createGroupAdaptData({'OG31params','OG32params','OG33params','OG39params','OG42params','OG43params','OG45params','OG99params'});
% YoungFast=adaptationData.createGroupAdaptData({'OG65params','OG66params','OG69params','OG86params','OG101params','OG102params','OG105params','OG100params'});
% OldSlow=adaptationData.createGroupAdaptData({'OG17params','OG19params','OG24params','OG25params','OG26params','OG27params','OG28params','OG29params'});
% OldFast=adaptationData.createGroupAdaptData({'OG70params','OG72params','OG74params','OG75params','OG84params','OG103params','OG104params','OG106params'});

YoungSlow=adaptationData.createGroupAdaptData({'OG31Kinparams','OG32Kinparams','OG33Kinparams','OG39Kinparams','OG42Kinparams','OG43Kinparams','OG45Kinparams','OG99Kinparams'});
YoungFast=adaptationData.createGroupAdaptData({'OG65Kinparams','OG66Kinparams','OG69Kinparams','OG86Kinparams','OG100Kinparams','OG101Kinparams','OG102Kinparams','OG105Kinparams'});
OldSlow=adaptationData.createGroupAdaptData({'OG17Kinparams','OG19Kinparams','OG24Kinparams','OG25Kinparams','OG26Kinparams','OG27Kinparams','OG28Kinparams','OG29Kinparams'});
OldFast=adaptationData.createGroupAdaptData({'OG70Kinparams','OG72Kinparams','OG74Kinparams','OG75Kinparams','OG84Kinparams','OG103Kinparams','OG104Kinparams','OG106Kinparams'});

adaptDataGroups{1}=YoungSlow;
adaptDataGroups{2}=YoungFast;
adaptDataGroups{3}=OldSlow;
adaptDataGroups{4}=OldFast;

adaptDataGroups{1}=adaptDataGroups{1}.removeBadStrides;
adaptDataGroups{2}=adaptDataGroups{2}.removeBadStrides;
adaptDataGroups{3}=adaptDataGroups{3}.removeBadStrides;
adaptDataGroups{4}=adaptDataGroups{4}.removeBadStrides;% %ALL EPOCHS

% epochNames={'OGbase_{late}','TMbase_{late}','Adapt_{Initial}','Adapt_{Last}','catch','readapt_{Initial}','readapt_{Last}','OG_{Initial}','OG_{Last}','TM_{Initial}','TM_{Last}'};
% condition= {'OG base','TM base','adaptation','adaptation','catch','re-adaptation','re-adaptation','OG post','OG post','TM post','TM post'};

epochNamesTm={'TMbase_{late}','Adapt_{Initial}','Adapt_{Last}','catch','readapt_{Initial}','readapt_{Last}','TM_{Initial}','TM_{Last}'};
conditionTm= {'TM base','adaptation','adaptation','catch','re-adaptation','re-adaptation','TM post','TM post'};

epochNamesOG={'OGbase_{late}','OG_{Initial}','OG_{Last}'};
conditionOG= {'OG base','OG post','OG post'};

strideNoTm=[-40 5 -40 5 5 -40 5 -40];
strideNoOG=[-40  5 -40];
% strideNo=[-40 -40 5 -40 5 5 -40 5 -40 5 -40];

exemptFirst=0; %Number of strides you want to ignore at the beginning of the condition
exemptLast=5; %Number of strides you want to ignore at the end of the condition
summaryMethod={'nanmean'}; %Method to analyze bar plots 
shortName=[];
% 
[epochsTm] = defineEpochs(epochNamesTm,conditionTm,strideNoTm,exemptFirst,exemptLast,summaryMethod,shortName);
[epochsOG] = defineEpochs(epochNamesOG,conditionOG,strideNoOG,exemptFirst,exemptLast,summaryMethod,shortName);

indivFlag=1;
labels={'YS','YF','OS','OF'}; %Groups names 
colorOrder=[]; %Let the function take care of this at least you wanted in a specific set of color then by my guess and add the list here
medianFlag=[];
significanceThreshold=[];
significancePlotMatrixGroups=[];
signifPlotMatrixConds=[];
posthocGroupFlag=0;
posthocEpochFlag=0;
posthocGroupByEpochFlag=0;
posthocEpochByGroupFlag=0;
removeBaseEpochFlag=1;
% params={{'netContributionNorm2'}},{'spatialContributionNorm2'},{'stepTimeContributionNorm2'},{'velocityContributionNorm2'}};
%%
params={{'Xasym'}};
% params={'netContributionNorm2','alphaAsym','Xasym'};
figure   
for i=1:length(params) 
p=subplot(2,1,1);  
pog=subplot(2,1,2); 
%  p=figure;  pog=figure; 
plotHandles=p; plotHandlesOG=pog;
[~,allDataTM]=groupAdaptationData.plotMultipleEpochBars(adaptDataGroups,params{i},epochsTm,indivFlag,labels,plotHandles,colorOrder,medianFlag,significanceThreshold,posthocGroupFlag,posthocEpochFlag,posthocGroupByEpochFlag,posthocEpochByGroupFlag,removeBaseEpochFlag);
[~,allDataOG]=groupAdaptationData.plotMultipleEpochBars(adaptDataGroups,params{i},epochsOG,indivFlag,labels,plotHandlesOG,colorOrder,medianFlag,significanceThreshold,posthocGroupFlag,posthocEpochFlag,posthocGroupByEpochFlag,posthocEpochByGroupFlag,removeBaseEpochFlag);

end

% epochNames={'OGbaseLate','TMbaseLate','AdaptIni','AdaptLast','CatchIni','readaptIni','readaptLast','OGIni','OGLast','TMIni','TMLast'};
epochNamesTm={'TMbaseLate','AdaptIni','AdaptLast','CatchIni','readaptIni','readaptLast','TMIni','TMLast'};
epochNamesOG={'OGbaseLate','OGIni','OGLast'};
 

% epochNamesParam={['OGbaseLate' params{1}{1}],['TMbaseLate' params{1}{1}],['AdaptIni' params{1}{1}],...
%                    ['AdaptLast' params{1}{1}],['CatchIni' params{1}{1}], ['readaptIni' params{1}{1}], ['readaptLast' params{1}{1}]...
%                    ['OGIni' params{1}{1}],['OGLast', params{1}{1}],['TMIni' params{1}{1}],['TMLast' params{1}{1}]};
YS=squeeze(allDataTM(1, :, :, :))';
YF=squeeze(allDataTM(2, :, :, :))';
OS=squeeze(allDataTM(3, :, :, :))';
OF=squeeze(allDataTM(4, :, :, :))';

YS_OG=squeeze(allDataOG(1, :, :, :))';
YF_OG=squeeze(allDataOG(2, :, :, :))';
OS_OG=squeeze(allDataOG(3, :, :, :))';
OF_OG=squeeze(allDataOG(4, :, :, :))';


AGE=[0.*ones(length([YS; YF]), 1); ones(length([OS; OF]), 1)];
SPEED=[0.*ones(size(YS,1) ,1); ones(size(YF,1),1); 0.*ones(size(OS,1) ,1); ones(size(OF,1),1); ];
DATA_TM=[YS; YF; OS; OF];
DATA_OG=[YS_OG; YF_OG; OS_OG; OF_OG];
GROUP=[ones(size(YS,1),1); 2*ones(size(YS,1),1);3*ones(size(YS,1),1);4*ones(size(YS,1),1)];

X = categorical({'YS','YF','OS','OF'});
X = reordercats(X,{'YS','YF','OS','OF'});
slope=[];
for p=1
    i=1;
for g=1:4
    for s=1:8
       
        adaptData=adaptDataGroups{g}.adaptData{s};
        data= adaptData.getParamInCond(params{1}{p},'adaptation');
        mdl = fitlm(1:length(data),data);
        slope(i,1)=mdl.Coefficients.Estimate(2);
        i=i+1;
    end
end
end
tableData=[GROUP,AGE, SPEED,slope ,DATA_TM,DATA_OG];
StatsFormat=array2table( tableData, 'VariableNames', { 'group','age', 'spd','slopeAdapt',epochNamesTm{:},epochNamesOG{:}});
filename = [(params{1}{1}), 'Kinematics.csv'];
% filename = ['all.xlsx'];
% writetable(StatsFormat,filename,'Sheet',1)
  writetable(StatsFormat,filename,'Delimiter',',','QuoteStrings',true)
%%
cond=7; %conditons of interest 5 cathcini 7 readaptlast  8 OGini 10 TMini
YS=squeeze(allDataTM(1, :, cond, :))';
YF=squeeze(allDataTM(2, :, cond, :))';
OS=squeeze(allDataTM(3, :, cond, :))';
OF=squeeze(allDataTM(4, :, cond, :))';

AGE=[0.*ones(length([YS'; YF']), 1); ones(length([OS'; OF']), 1)];
SPEED=[0.*ones(size(YS,2) ,1); ones(size(YF,2),1); 0.*ones(size(OS,2) ,1); ones(size(OF,2),1); ];
Data=[YS'; YF';OS'; OF'];

[p, tbl,stats,terms]= anovan(Data,{AGE SPEED},'model','interaction','varnames',{'AGE','SPEED'});
[c,m,h,gnames]= multcompare(stats,'ctype','hsd','Dimension',[1 2])

%%
studyData2.OldFast=OldFast;
studyData2.OldSlow=OldSlow;
studyData2.YoungSlow=YoungSlow;
studyData2.YoungFast=YoungFast;

paramsv2={'netContributionNorm2','spatialContributionNorm2','stepTimeContributionNorm2','velocityContributionNorm2'};
groups={'YoungSlow','YoungFast','OldSlow','OldFast'}; %Groups names 
plotFlag=0;
indivFlag=0;
maxPerturb=0;

results = getResultsSMART(studyData2,paramsv2,groups,maxPerturb,plotFlag,indivFlag);

YS=studyData2.YoungSlow.ID;
YF=studyData2.YoungFast.ID;
OS=studyData2.OldSlow.ID;
OF=studyData2.OldFast.ID;

%%
epochsTm={'TMsteadyBeforeCatch','catch','TMsteady',...
    'OGafter','TMafter'};

%Stats with strcuture format 
AGE=[0.*ones(length([YS'; YF']), 1); ones(length([OS'; OF']), 1)];
SPEED=[0.*ones(size(YS,2) ,1); ones(size(YF,2),1); 0.*ones(size(OS,2) ,1); ones(size(OF,2),1); ];

Data=results.(epochsTm{3}).indiv.netContributionNorm2(:,2);
% Data=results.(epochs{4}).indiv.spatialContributionNorm2(:,2);
%Data=results.(epochs{4}).indiv.stepTimeContributionNorm2(:,2);
% Data=results.(epochs{7}).indiv.velocityContributionNorm2(:,2);
[p, tbl,stats,terms]= anovan(Data,{AGE SPEED},'model','interaction','varnames',{'AGE','SPEED'});
[c,m,h,gnames]= multcompare(stats,'ctype','hsd','Dimension',[1 2])
tableData=[AGE, SPEED, Data];

%% Analysis of the slopes 

params={'netContributionNorm2','spatialContributionNorm2','stepTimeContributionNorm2','velocityContributionNorm2'};
figure 
X = categorical({'YS','YF','OS','OF'});
X = reordercats(X,{'YS','YF','OS','OF'});
slope=[];
for p=1:4
    i=1;
for g=1:4
    for s=1:8
       
        adaptData=adaptDataGroups{g}.adaptData{s};
        data= adaptData.getParamInCond(params{p},'adaptation');
        mdl = fitlm(1:length(data),data);
        slope(i,1)=mdl.Coefficients.Estimate(2);
        i=i+1;
    end
end
AGE=[0.*ones(length([YS'; YF']), 1); ones(length([OS'; OF']), 1)];
SPEED=[0.*ones(size(YS,2) ,1); ones(size(YF,2),1); 0.*ones(size(OS,2) ,1); ones(size(OF,2),1); ];
[p_slope, tbl_s,stats_s,terms_s]= anovan(slope,{AGE SPEED},'model','interaction','varnames',{'AGE','SPEED'});

Y=[mean(slope(1:8)) mean(slope(9:16)) mean(slope(17:24)) mean(slope(25:32))];
SE=[std(slope(1:8)) std(slope(9:16)) std(slope(17:24)) std(slope(25:32))]./sqrt(8);
subplot(4,1,p)
hold on 
bar(X,Y)
errorbar(X,Y,SE)
ylabel(params{p})

end