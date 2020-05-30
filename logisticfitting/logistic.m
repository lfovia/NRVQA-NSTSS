function r=logistic(objective_scores, dmos)
% tic;
% addpath('D:\Database\databaserelease2');
% addpath('D:\Database\databaserelease2\wn');
% 
% load('SDM_distorted_all1.mat');
% load('dmos.mat');
d=objective_scores;
% d=DIS1;
% dmos=D1;
%dmos  =DMOS;
SDM_distorted_all = d;
% SDM_distorted_all=SDM_distorted_all(1:145);
% dmos=dmos(1:953);
% SDM_distorted_all=SDM_distorted_all(1:145);
% SDM_distorted_all=SDM_distorted_all;
% dmos=dmos(1:149);


% dmos_scores101=dmos;
beta=[max(dmos) min(dmos) mean(SDM_distorted_all) 1 0];
BETA=beta;
 beta=nlinfit(SDM_distorted_all,dmos,@mymodel,beta);
 
[BETA,R,J,COVB,SDM_distortedSE]=nlinfit(SDM_distorted_all,dmos,@mymodel,BETA);
%    for i=1:140
           
%        beta=nlinfit(SDM_distorted_all(i),dmos_scores101(i),@mymodel,beta);

       dmos_scores101= BETA(2)+ (BETA(1)-BETA(2))./(1+exp(-(SDM_distorted_all-BETA(3))./abs(BETA(4))));
%        dmos_scores101 = BETA(1)*(0.5-1./(1+exp(BETA(2)*(SDM_distorted_all-BETA(3))))) + BETA(4)*SDM_distorted_all+BETA(5);
%        BETA(i,:)=beta;
%        beta=[max(dmos_scores101) min(dmos_scores101) mean(SDM_distorted_all) 1];




%         dmos_scores101(i)=(beta(1)-beta(2))*dmos(i)^4+beta(1)*dmos(i)^3+(beta(2))*dmos(i)^2+beta(3)*dmos(i)+beta(4);%beta(2)*exp(-SDM_distorted_all(i)/(beta(2)-beta(1))); 
%           dmos_scores101(i)=beta(1)*SDM_distorted_all(i)^(beta(4))+(beta(2)*SDM_distorted_all(i))+beta(3)*SDM_distorted_all(i)^2;
%         beta=[max(dmos_scores101) min(dmos_scores101) mean(SDM_distorted_all) 1];
%    end

%  dmos_scores101=beta(1)*exp(-beta(4))+(beta(2)*SDM_distorted_all);


r= BETA(2)+ (BETA(1)-BETA(2))./(1+exp(-(SDM_distorted_all-BETA(3))/abs(BETA(4))));
% r = BETA(1)*(0.5-1./(1+exp(BETA(2)*(SDM_distorted_all-BETA(3))))) + BETA(4)*SDM_distorted_all+BETA(5);
% p = polyfit(dmos_scores101,dmos,1);

figure, scatter(SDM_distorted_all, r, '.');
% 
indx=find(dmos~=0);
% 
% 
hold on;plot(SDM_distorted_all(indx), dmos(indx), 'g*');xlabel('Q_ Score','FontSize',13);ylabel('DMOS','FontSize',13);
title('Fitting Curves','FontSize',13); set(gca,'FontSize',13);
% axis fit;
% a1=corr(d, dmos,'type','spearman')
% a2=corr(d, dmos)
% a3=corr(dmos_scores101, dmos,'type','spearman')
% a4=corr(dmos_scores101, dmos)
%figure, scatter(dmos_scores101, dmos)
% figure;plot(SDM_distorted_all,r,'.r')
% hold on;plot(SDM_distorted_all, dmos,'.')
corr(dmos, r)
% toc;