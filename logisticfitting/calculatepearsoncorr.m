function [linearcorr] = calculatepearsoncorr(quality,humanscores,val)
if (nargin == 2)
    val = 0;
end
x = quality; 
y = humanscores; 
itr =1;
for fact = 0.01:0.1:10
    itr = itr+1;
beta0 = [max(y) min(y) fact*mean(x) 1 0];
%[msg, msgid] = lastwarn
%s = warning('off','stats:nlinfit:IllConditionedJacobian');
warning off all
b_blur = nlinfit(x,y,@logistic_fun,beta0);
x_hat{itr} = logistic_fun(b_blur,x);
Correlation(itr) = corr(x_hat{itr},y);

[sorted_quality{itr}, ind] = sort(quality);
x_hat_sorted = x_hat{itr}(ind);
% scatter(sorted_quality,x_hat_sorted)
% hold on
% scatter(quality,humanscores,'r')
% figure(1)

end
index=find(Correlation==max(Correlation));
% whos index
if length(index)>1
    index(2:length(index))=[];
end
x_max=x_hat{index};
linearcorr = [max(Correlation) corr(x_max,y,'type','spearman') sqrt(mean((x_max-y).^2))];
[sort_quality, ind] =sort(x_max);
% %
if (val)
FigHandle = figure('Position', [100, 100, 700, 700]);
plot(sorted_quality{index},x_hat_sorted,'r', 'LineWidth',2)
% plot(quality(ind),sort_quality,'r', 'LineWidth',2)
hold on
scatter(quality,humanscores,'*','b')
xlabel('Q Score','FontSize',13), ylabel('DMOS','FontSize',13), grid on
end

