%% Data organization
% clear all
clc
close all force
% cd('/Users/dulcemariscal/Box/11_Research_Projects/AgeSpeedStudy/ProcessedData/1162019 processing')
% cd('/Users/dulcemariscal/Box/11_Research_Projects/AgeSpeedStudy/ProcessedData/06042020processing')
% YoungSlow=adaptationData.createGroupAdaptData({'OG31params','OG32params','OG33params','OG39params','OG42params','OG43params','OG45params','OG99params'});
% YoungFast=adaptationData.createGroupAdaptData({'OG65params','OG66params','OG69params','OG86params','OG100params','OG101params','OG102params','OG105params'});
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

studyData2.OF=OldFast;
studyData2.OS=OldSlow;
studyData2.YS=YoungSlow;
studyData2.YF=YoungFast;

%% Getting average data for bar plots
% params={'netContributionNorm2','spatialContributionNorm2','stepTimeContributionNorm2','velocityContributionNorm2'};
params={'netContributionNorm2','alphaAsym','Xasym'};
groups={'YS','YF','OS','OF'}; %Groups names %labels=[];
plotFlag=0;
indivFlag=0;
maxPerturb=0;
results = getResultsSMART(studyData2,params,groups,maxPerturb,plotFlag,indivFlag);
%%
savefig=0;

Figure1

Figure2_V2

Figure3_V2

Figure4_V2

%%