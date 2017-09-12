file_info = dir('*mat'); %利用dir创建一个结构体，提取文件名
num=length(file_info);
SubjName=cell(num,1);
response_face=zeros(num,60);
RT_face=zeros(num,60);
for i= 1:num
    load(file_info(i).name); 
    SubjName{i,1}=SubjectID;
    key = key([1:60],:); % first half
    RT = RT([1:60],:); % first half
    trialQueue = trialQueue([1:60],:);% first half
    key_tmp=key;
    RT_tmp=RT;
    trial_tmp=trialQueue(:,1);
    answer_tmp=trialQueue(:,2);
    response_tmp = (key_tmp==answer_tmp);
    a1 = find(answer_tmp == 1);
    a1(1:20) = [];
    a2 = find(answer_tmp == 1);
    a2([1:10 21:30]) = [];
    b = find(answer_tmp == 2);
    trial_tmp(a1) = trial_tmp(a1) + 20;
    trial_tmp(a2) = trial_tmp(a2) + 10;
    trial_tmp(b) = trial_tmp(b) + 30;
    [junk, index] = sort(trial_tmp);
    response_face(i,:) = response_tmp(index);
    RT_face(i,:)=RT_tmp(index);
end
filtered_RT_face = RTfilt(RT_face,response_face)';

save('data.mat','SubjName','response_face','RT_face','filtered_RT_face');