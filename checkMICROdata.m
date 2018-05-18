%%
addpath('/home/rouxf/toolboxes/fieldtrip-20170115/');
ft_defaults;

%%
p2d = '/media/rouxf/rds-share/iEEG_DATA/MICRO/P04/fvSpEM/2016-10-23_15-08-47/lfp_dat/';
fn = dir([p2d,'*.mat'])

%%
lfp = cell(1,length(fn));
parfor it = 1:length(fn)
    dat = load([p2d,fn(it).name]);
    lfp{it} = dat.save_data{1}{1}{1};
    
end;

%%
lfp = ft_appenddata([],lfp{:});

%%
tlck = ft_timelockanalysis([],lfp);

%%
cfg                     = [];
cfg.viewmode            = 'vertical';

ft_databrowser(cfg,tlck);

%%
addpath(genpath('/home/rouxf/toolboxes/releaseDec2015/'));
p2d = '/media/rouxf/rds-share/Fred/2016-10-17_14-04-16/';
fn = dir([p2d,'*.ncs'])

%%
FieldSelection(1) = 1;
FieldSelection(2) = 0;
FieldSelection(3) = 0;
FieldSelection(4) = 0;
FieldSelection(5) = 1;

ExtractHeader = 1;

ExtractMode = 1;

ModeArray = [];

%%
CSCdat.trial{1} = [];
CSCdat.label = cell(length( fn ),1);

for it = 1:length( fn )
    it
    [Timestamp,Samples, Header] = Nlx2MatCSC_v3( [p2d,fn(it).name] , FieldSelection, ExtractHeader, ExtractMode, ModeArray );
    
    x=[Header{:}];x=x(regexp(x,'-ADBitVolts')+12:regexp(x,'-AcqEntName')-1);
    scaleFactor = str2double(x);
    
    Samples = double( Samples(:) )';
    Samples = Samples.*scaleFactor.*1e6;
    
    CSCdat.trial{1} = [CSCdat.trial{1};Samples];
    x = fn(it).name(regexp(fn(it).name,'_')+1:regexp(fn(it).name,'.ncs')-1);
    CSCdat.label(it) = {x};
    
end;

%%
CSCdat.time{1} = [1:size(CSCdat.trial{1},2)]./32e3;

%%
cfg                     = [];
cfg.dataset             = [p2d,fn(it).name];

[CSCdat2] = ft_preprocessing(cfg);

%%
cfg                     = [];
cfg.resamplefs          = 1e3;

[CSCdat] = ft_resampledata( cfg , CSCdat );

%%
tlck = ft_timelockanalysis([],CSCdat);

%%
cfg                     = [];
cfg.viewmode            = 'vertical';

ft_databrowser(cfg,tlck);