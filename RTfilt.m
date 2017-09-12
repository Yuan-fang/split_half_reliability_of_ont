function [filtered_RT,result]=RTfilt(RT,response,below_cut)

% Writen by WRS
% [filtered_RT,result]=RTfilt(RT,response,below_cut)
% below_cutΪ��С��Ӧʱ��׼
% filtered_RTΪ������ȷ�ģ��޳�����ֵ��RT
% result����ÿ������/trial���޳���RT������

% Comment by LJG
% ��������
    % 1)����Boxplot�����޳������ķ�Ӧ��extreme outlier (> Meadian + 3IQR);
    % 2)�޳�����Ӧ��RT; 
    % 3)�޳����췴Ӧ��RT 
% ���ǻ��ڱ����޳����ݣ�RT, reponse��������
% ���ǻ���trial�޳����ݣ�RT & reponse��Ҫtransposeһ��

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
    
    

