function lookup_macro_files(pID)
% This function does a lookup of macro-data based on a list of timestamps
% from micro-wire recordings.
% The output returns a lookup table as well as a list of missing and
% matching data sets
%
% coded by F.Roux aka Fro, UoB, March 2017

%% use generic input for debugging
if nargin == 0
    pID = 'P05';
end;

%%
x = '/media/';
cd(x);
x = dir; x(1:2) = [];

%% maintiain compatibility 

% path to where lists are located
if any(strcmp({x(:).name},'rouxf'))
    p2mac = ['/media/rouxf/rds-share/Archive/MACRO/',pID,'/EDF/'];%path to macro
    p2mic = ['/media/rouxf/rds-share/Archive/MICRO/',pID,'/'];%path to micro       
else
    p2mac = ['/media/samba_share/RDS/Archive/MACRO/',pID,'/EDF/'];%path to macro
    p2mic = ['/media/samba_share/RDS/Archive/MICRO/',pID,'/'];%path to micro       
end;

%% get the micro and macro data from the list of timestamps
% file names
fn_mac = [pID,'_rec_date_AND_time.txt'];% macro
fn_mic = ['Sorted_TimeStamps_info',pID,'.txt'];% micro

% search for existing files in specified directories
fn_mac = dir([p2mac,fn_mac]);
fn_mic = dir([p2mic,fn_mic]);

% now generate handle to read file-list
fid_mac = fopen([p2mac,fn_mac.name],'r');
fid_mic = fopen([p2mic,fn_mic.name],'r');

% start reading the list of micro-data
mic_dat = textscan(fid_mic,'%s');
mic_dat = mic_dat{:};
idx = 1:3;
n =length(mic_dat)/length(idx);

% put data in matrix format
dum = {};
for it = 1:n
    sel = mic_dat(idx)';
    dum = [dum;sel];
    idx = idx +length(idx);
end;
[mic_dat] = dum;% list of dates and times corresponding to MW recordings

% start reading the list of macro-data
mac_dat = textscan(fid_mac,'%s');
mac_dat = mac_dat{:};
idx = 1:4;
n =length(mac_dat)/length(idx);

% put data in matrix format
dum = {};
for it = 1:n
    sel = mac_dat(idx)';
    dum = [dum;sel];
    idx = idx +length(idx);
end;
[mac_dat] = dum;% list of dates and times corresponding to macro recordings

%% lookup macro-data based on micro file-list

look_up = zeros(size(mic_dat,1),2);
for it = 1:size(mic_dat,1)
                
    sel = mic_dat(it,:);
    d1   = sel(1);
    ix = regexp(d1{1},'[/]');
    [d1] = parse_string2val(ix,d1);    
    d1 = {[num2str(d1(2)),'.',num2str(d1(1)),'.',num2str(d1(3))]};
    
    t_op1 = sel(2);
    t_op1{1}(regexp(t_op1{1},'[.]'):end) = [];
    ix = regexp(t_op1{1},'[:]');    
    [t_val1] = parse_string2val(ix,t_op1);
    
    mac_ix = find(strcmp(d1,mac_dat(:,2)));
    
    for jt = 1:length(mac_ix)
        sel = mac_dat(mac_ix(jt),:);
        d2 = sel(2);
        t_op2 = sel(3);
        ix = regexp(t_op1{1},'[:]');
        
        [t_val2] = parse_string2val(ix,t_op2);
        
        chck = zeros(1,2);
        if strcmp(d1,d2)
            chck(1) = (t_val1(1)-t_val2(1));
            chck(2) = (t_val2(2)-t_val1(2));
            
            chck(1) = (chck(1) == 0);
            chck(2) = (sign(chck(2)) ~=1);
            
            if (sum(chck)==2)                
                look_up(it,:) = [1 mac_ix(jt)];                               
            end;
            
        end;
        
    end;
    
end;

[missing] = mic_dat(find(look_up(:,1)==0),:);
 
[matching] = [mic_dat(find(look_up(:,1)==1),1:2) mac_dat(look_up(find(look_up(:,1)==1),2),2:3) mac_dat(look_up(find(look_up(:,1)==1),2),1) ];
 
out_fn1 = [p2mac,pID,'_missing_macro_files.txt'];
out_fn2 = [p2mac,pID,'_macro_micro_lookup.txt'];

fid_fn1 = fopen(out_fn1,'w');
fid_fn2 = fopen(out_fn2,'w');

fprintf(fid_fn1,'%s\t','DATE');
fprintf(fid_fn1,'%s\t','TIME-OPEN');
fprintf(fid_fn1,'%s\t\n','TIME-CLOSE');
for it = 1:size(missing,1)
    fprintf(fid_fn1,'%s\t',missing{it,:});
    fprintf(fid_fn1,'\n',missing{it,:});
end;

fprintf(fid_fn2,'%s\t','DATE-MICRO');
fprintf(fid_fn2,'%s\t','TIME-OPEN-MICRO');
fprintf(fid_fn2,'%s\t','DATE-MACRO');
fprintf(fid_fn2,'%s\t','TIME-OPEN-MACRO');
fprintf(fid_fn2,'%s\t\n','LABEL-MACRO');

for it = 1:size(matching,1)
    fprintf(fid_fn2,'%s\t',matching{it,:});
    fprintf(fid_fn2,'\n',matching{it,:});
end;

fclose('all');

exit;
 
function [parsed_val] = parse_string2val(ix,str_val)

parsed_val = zeros(1,length(ix)+1);
for jt = 1:length(ix)+1
    if (jt >1) && (jt<= length(ix))
        parsed_val(jt) = str2double(str_val{1}(ix(jt-1)+1:ix(jt)-1));
    elseif jt > length(ix)
        parsed_val(jt) = str2double(str_val{1}(ix(jt-1)+1:end));
    else
        parsed_val(jt) = str2double(str_val{1}(1:ix(jt)-1));
    end;
end;