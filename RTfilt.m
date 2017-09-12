function [filtered_RT,result]=RTfilt(RT,response,below_cut)

% Writen by WRS
% [filtered_RT,result]=RTfilt(RT,response,below_cut)
% below_cut为最小反应时标准
% filtered_RT为返回正确的，剔除极端值的RT
% result代表每个被试/trial被剔除的RT的数量

% Comment by LJG
% 函数功能
    % 1)根据Boxplot方法剔除过慢的反应—extreme outlier (> Meadian + 3IQR);
    % 2)剔除错误反应的RT; 
    % 3)剔除过快反应的RT 
% 若是基于被试剔除数据，RT, reponse正常输入
% 若是基于trial剔除数据，RT & reponse需要transpose一下

% 2010.7.2


if nargin < 3
    below_cut  = 0.2; 
end

if nargin < 2
    error('wrong input'); 
end

RT=RT';
response=response';

num_column_RT=size(RT);
num_column_Response=size(response);
num_subj=size(RT,2);

if num_column_RT ~= num_column_Response
    error('wrong input')
end

filtered_RT=medoutlierfilt(RT,3,0);
result=zeros(1,num_subj);
for i= 1:num_subj
    tmp=filtered_RT(:,i);
    tmp(tmp<below_cut)=NaN;
    tmp(response(:,i)==0)=NaN;
    filtered_RT(:,i)=tmp;
    result(1,i)=length(find(isnan(filtered_RT(:,i))));
end
    
    

