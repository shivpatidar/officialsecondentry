function [scores, labels]  = get_sepsis_score(data1,model)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



data=data1(end,:);

xxx=find(data(:,4)<data(:,6));

for ii=1:length(xxx)
    uu=data(xxx(ii),4);
    vv=data(xxx(ii),6);
    data(xxx(ii),6)=uu;
    data(xxx(ii),4)=vv;
end

mu=[84.2061445399554,97.1042922183183,36.9129570072805,126.811629098678,86.6534116689875,66.4697154647796,18.7393593625768,32.8939855007608,-3.39182389937107,22.5073122529644,0.507699573430845,7.36929862174577,40.3848378212974,96.5268346111719,192.381690660760,22.9643115069812,98.0299963194700,7.00924655526239,106.563318777293,1.64130063709581,1.21254794520548,140.138223595405,2.99093158660844,2.05984158138231,3.45182126696832,4.09622917938432,1.87343004039662,8.24477941176466,31.0792886645250,10.1991020408163,44.7429051782112,10.7799949174078,274.113663133098,193.224399098648,60.5672793434089,0.540313155727908,0.489870397230150,0.510129602769850,-67.3244416850259,25.7519456028049];
stdd=[17.6789062490770,2.96272557664854,0.763160660066376,24.4745017437595,16.8000297088328,14.2592815533567,4.74293432401596,7.61265597243678,4.74361059298186,3.66837296463524,0.226649214507526,0.0928419980089872,10.3948069434161,4.11533404577114,716.671964243265,19.3989083187257,103.653549317874,3.02247341630676,4.79643851376234,2.03481613823240,3.24689967524853,52.4442500262057,2.80884036685201,0.382242020925569,1.35608706548277,0.654318781103494,3.88085577851467,25.1074901186160,6.62068988463042,2.24349107764270,38.1868758208808,9.85939220953114,135.701209053458,99.0084945095756,16.3034521512521,0.498373854416560,0.499899719553310,0.499899719553310,256.753614948731,27.5196306042446];

for clm=1:40
% %     
data(isnan(data(:,clm)),clm)=mu(clm);
end
rawdata=data;

mu1=[84.2061445399315,97.1042922182834,36.9129570071956,126.811629098624,86.6534116690149,66.4697154647898,18.7393593625708,32.8939855006602,-3.39182389936227,22.5073122530023,0.507699573431753,7.36929862175808,40.3848378211934,96.5268346109622,192.381690661318,22.9643115070333,98.0299963192435,7.00924655527039,106.563318777457,1.64130063709865,1.21254794520739,140.138223595588,2.99093158659959,2.05984158138602,3.45182126696532,4.09622917939945,1.87343004039924,8.24477941177691,31.0792886645844,10.1991020408301,44.7429051781260,10.7799949173955,274.113663132531,193.224399098163,60.5672793434089,0.540313155727908,0.489870397229798,0.510129602770212,-67.3244416850259,25.7519456028049];
stdd1=[16.5465358166913,2.74134150554236,0.442728592648656,22.6682497697117,15.4779227229279,13.2053933587890,4.20239136969256,2.07346348186367,0.217637327807792,0.150061221773323,0.0334543084699172,0.0136682928991361,1.53103711429012,0.554902317468757,96.1035585336278,4.55610914464799,13.9201458043292,0.787839006238319,0.373873042489349,0.478221783714260,0.159629916012209,24.6745559949839,0.379359628384359,0.0831838121574506,0.232297372743326,0.180546917669175,0.521754601221711,3.45701353831271,1.59269151056165,0.542911125669693,3.79330931272605,2.25374429075936,10.1830146088233,22.8012692303010,16.3034521512521,0.498373854416560,0.421107842679835,0.421107842679835,256.753614948731,27.5196306042446];

norrawdata=(data-mu1)./stdd1;

%for extened data--proposed features


 [labels1,scores1]=newfeatcomb1(norrawdata,rawdata,model{1});
 [labels2,scores2]=newfeatcomb2(norrawdata,rawdata,model{2});
 [labels3,scores3]=newfeatcomb3(norrawdata,rawdata,model{3});
 [labels4,scores4]=newfeatcomb4(norrawdata,rawdata,model{4});
 [labels5,scores5]=newfeatcomb5(norrawdata,rawdata,model{5});
 [labels6,scores6]=newfeatcomb6(norrawdata,rawdata,model{6});
 [labels7,scores7]=newfeatcomb7(norrawdata,rawdata,model{7});
 
 
 labels=mode([labels1,labels2,labels3,labels4,labels5,labels6,labels7]);
 scores=mode([scores1(:,2),scores2(:,2),scores3(:,2),scores4(:,2),scores5(:,2),scores6(:,2),scores7(:,2)])/sum([scores1(:,2),scores2(:,2),scores3(:,2),scores4(:,2),scores5(:,2),scores6(:,2),scores7(:,2)]);

 
end

function [labels1,scores1]=newfeatcomb1(norrawdata,data,model)
% keep1
% 1     7     7    11
% 26     9    10    12
% 
% keep2
% 9
% 25
% keep3
% 9
% 19
% Type1:LAV type
feat11=data(:,1)./(data(:,26));%correct
feat12=data(:,7)./(data(:,9));
feat13=data(:,7)./(data(:,10));
feat14=data(:,11)./(data(:,12));

% Type2:
feat21=data(:,9)./(data(:,25).^2);%correct

% Type3:
feat31=data(:,9)./(data(:,19).^3);%correct
%Type1:others
feat41=data(:,3)./(data(:,28).^2.*data(:,36).^3);
feat42=data(:,8)./(data(:,15).^2.*data(:,36).^3);
feat43=data(:,10)./(data(:,10).^2.*data(:,36).^3);

feat=[feat11 feat12 feat13 feat14  feat21  feat31 feat41 feat42 feat43 ];
%feat=[feat11 feat12];

traindata3=feat;
 
% for clm=1:9
% % %     
% traindata3(isnan(traindata3(:,clm)),clm)=0;
% end
% for clm=1:9
% % %     
% traindata3(isinf(traindata3(:,clm)),clm)=0;
% end

mu1=[20.6943662309956,-5.50202839447286,0.831380544659131,0.0689243900330537,-0.290140146398514,-2.80330968396363e-06,100,100,100];
stdd1=[4.20965824983989,2.53717060417119,0.185756932252486,0.00472611278201726,0.109055621852500,1.83913548671300e-07,1,1,1];
 

traindata4=(traindata3-mu1)./stdd1;
traindataf1=[norrawdata traindata4];
[labels1,scores1]=predict(model,traindataf1);
end

function  [labels2,scores2]=newfeatcomb2(norrawdata,data,model)
feat1=data(:,1)./(data(:,2).^3.*data(:,4).^3);
feat2=data(:,1)./(data(:,2).^3.*data(:,7).^3);
feat3=data(:,1)./(data(:,2).^3.*data(:,23).^3);
feat4=data(:,1)./(data(:,3).^3.*data(:,4).^3);
feat5=data(:,1)./(data(:,3).^3.*data(:,16).^3);
feat6=data(:,1)./(data(:,4).^3.*data(:,22).^3);
feat7=data(:,1)./(data(:,10).^3.*data(:,36).^3);

feat8=data(:,1)./(data(:,28).^3.*data(:,36).^3);
feat9=data(:,2)./(data(:,4).^3.*data(:,23).^3);
feat10=data(:,5)./(data(:,33).^3.*data(:,36).^3);
feat11=data(:,7)./(data(:,24).^3.*data(:,36).^3);
feat12=data(:,10)./(data(:,30).^3.*data(:,31).^3);

feat=[feat1 feat2 feat3 feat4  feat5  feat6 feat7 feat8 feat9 feat10 feat11 feat12 ];


traindata5=feat;
 
for clm=1:12
% %     
traindata5(isnan(traindata5(:,clm)),clm)=0;
end

 mu2=[5.63188777075809e-11,8.95966688102891e-08,4.00609040883360e-06,1.01152249060850e-09,4.27826911725933e-07,2.22734503006832e-11,100,100,2.50146020695583e-06,100,100,2.47101734639033e-07];
 stdd2=[8.45439567949982e-11,2.40026711797638e-06,7.90218834027192e-06,1.37044453306515e-09,1.61138243022422e-05,6.32225240302066e-11,1,1,6.66703692676491e-06,1,1,1.36599975862242e-07];
 traindata5=(traindata5-mu2)./stdd2;
 traindataf2=[norrawdata traindata5];
 [labels2,scores2]=predict(model,traindataf2);
end
function  [labels3,scores3]=newfeatcomb3(norrawdata,data,model)
feat1=data(:,1)./(data(2).^2.*data(:,4).^2);
feat2=data(:,1)./(data(2).^2.*data(:,16).^2);
feat3=data(:,1)./(data(2).^2.*data(:,22).^2);
feat4=data(:,1)./(data(2).^2.*data(:,36).^2);
feat5=data(:,1)./(data(:,3).^2.*data(:,25).^2);
feat6=data(:,1)./(data(:,4).^2.*data(:,10).^2);
feat7=data(:,1)./(data(:,11).^2.*data(:,30).^2);

feat8=data(:,1)./(data(:,18).^2.*data(:,19).^2);
feat9=data(:,1)./(data(:,30).^2.*data(:,36).^2);
feat10=data(:,6)./(data(:,13).^2.*data(:,17).^2);
feat11=data(:,8)./(data(:,20).^2.*data(:,36).^2);
feat12=data(:,9)./(data(:,15).^2.*data(:,27).^2);

feat=[feat1 feat2 feat3 feat4  feat5  feat6 feat7 feat8 feat9 feat10 feat11 feat12 ];

 traindata6=feat;
 
for clm=1:12
% %     
traindata6(isnan(traindata6(:,clm)),clm)=0;
end

 mu3=[6.18781432744747e-07,2.11606518316243e-05,4.95341800103268e-07,100,0.00532402376803262,1.14516473910101e-05,3.22662352947727,0.000223184389862419,100,4.39952227730283e-06,100,-0.000463669904651202];
 stdd3=[3.31236650807891e-07,9.58983017586154e-05,2.90289159995397e-07,1,0.00252768696890605,5.70918188596405e-06,1.11543354500889,0.000667959353845141,1,2.97926762179407e-06,1,0.0132755136579553];
 traindata6=(traindata6-mu3)./stdd3;
 traindataf3=[norrawdata traindata6];
 [labels3,scores3]=predict(model,traindataf3);
 
end

function [labels4,scores4]=newfeatcomb4(norrawdata,data,model)
feat1=data(:,1)./(data(:,2).*data(:,5).^3);
feat2=data(:,1)./(data(:,2).*data(:,31).^3);
feat3=data(:,1)./(data(:,3).*data(:,30).^3);

feat4=data(:,1)./(data(:,5).*data(:,20).^3);
feat5=data(:,1)./(data(:,7).*data(:,13).^3);
feat6=data(:,1)./(data(:,9).*data(:,18).^3);
feat7=data(:,1)./(data(:,26).*data(:,36).^3);

feat8=data(:,10)./(data(:,19).*data(:,21).^3);
feat9=data(:,10)./(data(:,21).*data(:,24).^3);
feat10=data(:,13)./(data(:,15).*data(:,36).^3);


feat=[feat1 feat2 feat3 feat4  feat5  feat6 feat7 feat8 feat9 feat10  ];


traindata7=feat;
 
for clm=1:10
% %     
traindata7(isnan(traindata7(:,clm)),clm)=0;
end

 mu4=[1.60223250130288e-06,9.93858219765778e-06,0.00220362882116210,0.339597988655292,7.35736589583879e-05,-0.286644021189462,100,3.33495214624130,2.18087692441709,100];
 stdd4=[1.03963837999544e-06,3.65731291193944e-06,0.000745385091107003,1.76806200346970,4.69931891368480e-05,1.97373483956619,1,798.348013629976,1.53234062927112,1];
 traindata7=(traindata7-mu4)./stdd4;
 traindataf4=[norrawdata traindata7];
 [labels4,scores4]=predict(model,traindataf4);
end

function[labels5,scores5] = newfeatcomb5(norrawdata, data,model)

feat1=data(:,1)./(data(:,2).*data(:,4).^2);
feat2=data(:,1)./(data(:,2).*data(:,5).^2);
feat3=data(:,1)./(data(:,2).*data(:,14).^2);

feat4=data(:,1)./(data(:,2).*data(:,16).^2);
feat5=data(:,1)./(data(:,2).*data(:,21).^2);
feat6=data(:,1)./(data(:,5).*data(:,8).^2);
feat7=data(:,1)./(data(:,5).*data(:,35).^2);

feat8=data(:,1)./(data(:,23).*data(:,36).^2);
feat9=data(:,3)./(data(:,7).*data(:,28).^2);
feat10=data(:,23)./(data(:,24).*data(:,36).^2);


feat=[feat1 feat2 feat3 feat4  feat5  feat6 feat7 feat8 feat9 feat10  ];

traindata8=feat;
 
for clm=1:10
% %     
traindata8(isnan(traindata8(:,clm)),clm)=0;
end

 mu5=[5.98528573437574e-05,0.000126831179606165,9.37446310645790e-05,0.00205189429901477,0.780032645002057,0.000945568733558020,0.000404242625550032,100,55.7251897076498,100];
 stdd5=[3.02441996199173e-05,5.38462100566401e-05,1.98206997592920e-05,0.00929758110307334,27.7266696898640,0.000430013197065918,0.000497614252203875,1,1011.40618360816,1];
 
 traindata8=(traindata8-mu5)./stdd5;
 traindataf5=[norrawdata traindata8];
 [labels5,scores5]=predict(model,traindataf5);
end


function[labels5,scores5] = newfeatcomb6(norrawdata, data,model)

feat1=(data(:,1).*(data(:,2))./data(:,4));
feat2=(data(:,1).*(data(:,2))./data(:,7));
feat3=(data(:,1).*(data(:,2))./data(:,33));

feat4=(data(:,3).*(data(:,14))./data(:,36));
feat5=(data(:,16).*(data(:,18))./data(:,36));



feat=[feat1 feat2 feat3 feat4  feat5    ];

traindata8=feat;
 
for clm=1:5
% %     
traindata8(isnan(traindata8(:,clm)),clm)=0;
end

 mu5=[66.8508690957750,466.901463681286,30.0016460017490,100,100];
 stdd5=[18.7223418662769,283.431314372658,6.22374767413119,1,1];
 traindata8=(traindata8-mu5)./stdd5;
 traindataf5=[norrawdata traindata8];
 [labels5,scores5]=predict(model,traindataf5);
end


function[labels5,scores5] = newfeatcomb7(norrawdata, data,model)

feat1=(data(:,1).*data(:,2))./(data(:,6).^2);
feat2=(data(:,1).*data(:,5))./(data(:,7).^2);
feat3=(data(:,4).*data(:,15))./(data(:,36).^2);

feat4=(data(:,12).*data(:,13))./(data(:,33).^2);
feat5=(data(:,17).*data(:,27))./(data(:,33).^2);
feat6=(data(:,20).*data(:,29))./(data(:,36).^2);


feat=[feat1 feat2 feat3 feat4  feat5  feat6 ];

traindata8=feat;
 
for clm=1:6
% %     
traindata8(isnan(traindata8(:,clm)),clm)=0;
end

 mu5=[2.07364063653398,30.6180962067301,100,0.00398403424142231,0.00250010565801085,100];
 stdd5=[1.00778285867010,196.474363191500,1,0.00112307384352978,0.00410811800018034,1];
 traindata8=(traindata8-mu5)./stdd5;
 traindataf5=[norrawdata traindata8];
 [labels5,scores5]=predict(model,traindataf5);
end








%https://github.com/shivpatidar/workingfirstentry.git



%https://github.com/shivpatidar/officialsecondentry.git