repet_num = 1000;
targ_num = 10;
dist_num = 30;

for i = 1:repet_num
    targ_tmp = shuffle(1:targ_num);
    dist_tmp = shuffle(1:dist_num);
    Index1 = [targ_tmp(1:targ_num/2) targ_tmp(1:targ_num/2)+10 targ_tmp(1:targ_num/2)+20 dist_tmp(1:dist_num/2)+30];
    Index2=[targ_tmp(targ_num/2+1:targ_num) targ_tmp(targ_num/2+1:targ_num)+10 targ_tmp(targ_num/2+1:targ_num)+20 dist_tmp(dist_num/2+1:dist_num)+30];
   % accuracy face:1/2;
   %       RT face: 3/4
    Group1(:,i)=mean(response_face(:,Index1),2);
    Group2(:,i)=mean(response_face(:,Index2),2);
    Group3(:,i)=nanmean(filtered_RT_face(:,Index1),2);
    Group4(:,i)=nanmean(filtered_RT_face(:,Index2),2);
    [r,p]=corr(Group1(:,i),Group2(:,i),'type','Pearson','rows','complete');
    Results(i,1)=r;
    Results(i,2)=p;
    [r,p]=corr(Group3(:,i),Group4(:,i),'type','Pearson','rows','complete');
    Results(i,3)=r;
    Results(i,4)=p;
end
splitR_face_acc=2*mean(Results(:,1))/(1+mean(Results(:,1)));
Face_acc=mean(response_face,2);
std_face_acc=std(Face_acc);
splitR_face_RT=2*mean(Results(:,3))/(1+mean(Results(:,3)));
Face_RT=nanmean(filtered_RT_face,2);
std_face_RT=nanstd(Face_RT);

save('splitR_combine.mat','Results','splitR_face_acc','Face_acc','std_face_acc','splitR_face_RT','Face_RT','std_face_RT');