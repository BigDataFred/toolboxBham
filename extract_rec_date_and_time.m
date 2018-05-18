function extract_rec_date_and_time(pID)
%This function reads the header of different EDF files and extracts their
% date (dd.mm.yy) and time (hh.mm.ss). 
% The result is stored in a .txt file labeled pID_rec_date_AND_time.txt
% This information can be used to match the macro-data for example with data recorded from
% other devices, such as microwires, etc.
% Input argument pID must correspond to a current path label. 

if nargin == 0
    pID = 'P05';
end;

%% this is the path were the txt file with the date and time information will be stored
x = '/media/';
cd(x);
x = dir; x(1:2) = [];

if any(strcmp({x(:).name},'rouxf'))
    p2d = ['/media/rouxf/rds-share/Archive/MACRO/',pID,'/EDF/'];
else
    p2d = ['/media/samba_share/RDS/Archive/MACRO/',pID,'/EDF/'];
end;

%% add fieldtrip to m-path
ft = dir('/home/rouxf/tbx/fieldtrip-********');
addpath(['/home/rouxf/tbx/',ft.name]);
ft_defaults;

%% extract header using fieldtrip
files = dir([p2d,'*.edf']);
n = length(files);

d_inf = zeros(n,3);
t_inf = zeros(n,3);
m = zeros(n,1);

for it = 1:length(files)
    
    [hdr] = ft_read_header([p2d,files(it).name]);
    
    sesh_inf = hdr.orig.T0;
    
    d_inf(it,:) = sesh_inf(1:3);% extracts the date
    t_inf(it,:) = sesh_inf(4:6);% extracts the time
    m(it) = hdr.orig.NRec*hdr.orig.Dur/60;
    
    hdr = [];
    sesh_inf = [];
end;

%%
d_inf2 = d_inf;
t_inf2 = t_inf;
m2 = m;

% %%
% [~,s_idx] = sort(datenum(d_inf));
% d_inf = d_inf(s_idx,:);
% t_inf = t_inf(s_idx,:);
% 
% ID = unique(datenum(d_inf));
% [~,s_idx] = sort(ID);
% ID = ID(s_idx);
% 
% d_inf2 = zeros(size(d_inf));
% t_inf2 = zeros(size(t_inf));
% m2 = zeros(size(m));
% for it = 1:length(ID)
%     
%     ix = find( datenum(d_inf) == ID(it) );
%     
%     [~,s_idx] = sort(datenum(t_inf(ix,:)));
%     
%     d_inf2(ix,:) = d_inf(ix(s_idx),:);
%     t_inf2(ix,:) = t_inf(ix(s_idx),:);
%     m2(ix) = m(ix(s_idx));
% end;

%%
d_inf = {}; 
t_inf = {}; 
m = {};
for it = 1:size(d_inf2,1)
    d_inf{it} = [num2str(d_inf2(it,3)),'.',num2str(d_inf2(it,2)),'.',num2str(d_inf2(it,1))];
    t_inf{it} = [num2str(t_inf2(it,1)),':',num2str(t_inf2(it,2)),':',num2str(t_inf2(it,3))];
    m{it} = num2str(m2(it));
end;

%% write the output
out_name = [p2d,pID,'_rec_date_AND_time.txt'];
fid = fopen(out_name,'w+');

fprintf(fid,'%s\t','FILENAME');
fprintf(fid,'%s\t','DATE');
fprintf(fid,'%s\t','TIME');
fprintf(fid,'%s\n','DUR.Min');

for it = 1:length(d_inf)
    [~,fn,ext] = fileparts(files(it).name);
    fprintf(fid,'%s\t',[fn,ext]);
    fprintf(fid,'%s\t',d_inf{it});
    fprintf(fid,'%s\t',t_inf{it});
    fprintf(fid,'%s\n',m{it});
end;

fclose(fid);

%% exit MATLAB
exit;