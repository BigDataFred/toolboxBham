function sort_NLX_TimeSamps_4Macros(p2f,pID)
%%
if strcmp(p2f(end),'/');p2f(end)=[];end;

fid = fopen( [p2f,filesep,'dum.txt'],'r');
dat = textscan(fid,'%s');
fclose(fid);

idx = [ 1:6 ];
rec = cell(1,length(dat{:})/6);
s = [];
for it = 1:length(dat{:})/6
    x = dat{:}(idx)';
    rec{it} = {x{[2 3 6]}};
    idx = idx + 6;
    
    s = [s;[rec{it}(1)]];
end;

[~,s_idx] = sort(datenum(s(:,1)));
s = s(s_idx,:);

rec = rec(s_idx);

ID = unique(s);
[~,s_ix] = sort(datenum(ID));
ID = ID(s_ix);

rec2 = {};
for it = 1:length(ID)
    
    ix = find(strcmp(s,ID{it}));
    x = {rec{ix}};
    h = {};
    for jt = 1:length(x)
        h(jt) = {x{jt}{2}};
    end;
    [~,s_idx2] = sort(h');
    rec2(ix) = {rec{ix(s_idx2)}};
    
end;

fid = fopen([p2f,filesep,'Sorted_TimeStamps_info',pID,'.txt'],'w');
for it = 1:length(rec2)
    for jt = 1:length(rec2{it})
        fprintf(fid,'%s',rec2{it}{jt});
        fprintf(fid,'\t',rec2{it}{jt});
    end;
    fprintf(fid,'\n');
end;
fclose(fid);
%%
exit;
