
%%
p2d = '/media/rouxf/rds-share/Archive/MICRO/P02/log/Tuning/';
fns = dir([p2d,'*.txt']);
p2NLX = '/media/rouxf/rds-share/Archive/MICRO/P02/unlabeledNLX/';

%%
sel = cell(length(fns),1);
fid = fopen('/media/rouxf/rds-share/Archive/MICRO/P02/ListTuningsP02.txt','a');

for it = 1:length(fns)
    
    x = fns(it).name;
    ix1 = regexp(x,'ctune_')+6;
    ix2 = regexp(x,'2016')+3;
    d = x(ix1:ix2);
    
    d = datestr(d,'yyyy-mm-dd');
    
    ix3 = ix2+2;
    ix4 = regexp(x,'.txt')-1;
    
    t = x(ix3:ix4);
    t(regexp(t,'_')) = '-';
    
    tmp = [d,'_',t(1:3),'*'];
    
    dum = dir([p2NLX,tmp]);
    
    sel{it} = dum(end).name;
    fprintf(fid,'%s\n',sel{it});
end;