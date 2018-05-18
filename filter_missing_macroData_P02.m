%%
rp = '/media/rouxf/rds-share/Archive/MACRO/P02/EDF/';

fid = fopen([rp,'P02_missing_macro_files.txt'])

dat= textscan(fid,'%s');
dat = dat{1};

dat = reshape(dat,[3 length(dat)/3]);
dat = dat';
dat(1,:) = [];

d = zeros(size(dat,1),3);
for it = 1:size(dat,1)
    
    b = [sprintf('%s',dat{it,2}),':',sprintf('%s',dat{it,3})];
    c = reshape( sscanf(b,'%g:') ,3 ,[] );
    a =diff(c,[],2);
    
    if isempty(a)
        d(it,:) = NaN(1,3);
    else
        d(it,:) = a;
    end;
    
end;

c = 0;
sel = [];
for it = 1:size(d,1)
    
    if ( abs(d(it,1)) >0 ) || ( abs(d(it,2)) >10 )
        c = c+1;
        sel(c) = it;
    end;
    
end;

%%
rp = '/media/rouxf/rds-share/Archive/MACRO/P02/EDF/';

fid2 = fopen([rp,'P02_missing_macro_files_filtered.txt'],'w+')

for it = 1:length(sel)
    fprintf(fid2,'%s\t',dat{sel(it),:});
    fprintf(fid2,'\n');
end;