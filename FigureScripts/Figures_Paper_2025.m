%% Data organization
% clear all

main = '/Users/dum5/Library/CloudStorage/OneDrive-UniversityofPittsburgh/_BoxMigration/Research_Projects_Box/AgeSpeedStudy/'
addpath(genpath([main, 'labToolsMaster'])) % code for the muscle activity regression

addpath('/Users/dum5/Library/CloudStorage/OneDrive-UniversityofPittsburgh/_BoxMigration/Research_Projects_Box/AgeSpeedStudy/ProcessedData/FigureScripts')

clc
close all force

%loading participants 
YoungSlow=adaptationData.createGroupAdaptData({'OG31Kinparams','OG32Kinparams','OG33Kinparams','OG39Kinparams','OG42Kinparams','OG43Kinparams','OG45Kinparams','OG99Kinparams'});
YoungFast=adaptationData.createGroupAdaptData({'OG65Kinparams','OG66Kinparams','OG69Kinparams','OG86Kinparams','OG100Kinparams','OG101Kinparams','OG102Kinparams','OG105Kinparams'});
OldSlow=adaptationData.createGroupAdaptData({'OG17Kinparams','OG19Kinparams','OG24Kinparams','OG25Kinparams','OG26Kinparams','OG27Kinparams','OG28Kinparams','OG29Kinparams'});
OldFast=adaptationData.createGroupAdaptData({'OG70Kinparams','OG72Kinparams','OG74Kinparams','OG75Kinparams','OG84Kinparams','OG103Kinparams','OG104Kinparams','OG106Kinparams'});


%Data organization in for the fuctions below 

%data for time courses 
adaptDataGroups{1}=YoungSlow;
adaptDataGroups{2}=YoungFast;
adaptDataGroups{3}=OldSlow;
adaptDataGroups{4}=OldFast;

%Data for barplots (mean and SE) 
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

%% Individual figure script
savefig=0; %Do you want to save the figures? 

Figure1 % Metohds 

Figure2_V3 % Adaptation with time courses and bar plots 

Figure3_V2 %Overground time courses and bar plots 

Figure4_V3 %Catch and Washout bar plots 

Figure5 %catch with time course

Figure6 %Washout with time course

Posthoc_Fig %Figure for posthoc analysis