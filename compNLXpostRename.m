%%

addpath(genpath('/media/rouxf/rds-share/Fred/code/mcode/toolboxes/releaseDec2015/'));

Fs = 32e4;

p2d1 = '/media/samba_share/RDS/Archive/MICRO/P02/fvsPEM/2016-07-10_18-41-47/';
p2d2 = '/media/samba_share/RDS/Fred/2016-07-10_18-41-47/';

fn1 = dir([p2d1,'*.ncs'])
fn2 = dir([p2d2,'*.ncs'])

FieldSelection(1) = 0;%timestamps
FieldSelection(2) = 0;
FieldSelection(3) = 0;%sample freq
FieldSelection(4) = 0;
FieldSelection(5) = 1;%samples
ExtractHeader = 1;

ExtractMode=1;
    
chck = zeros(length(fn1),1);
for it = 1:length(fn1)
    fprintf([num2str(it),'/',num2str(length(fn1))]);
    filename = [p2d1,fn1(it).name];
    
    [Samples1, HeaderVariable] = Nlx2MatCSC_v3(filename, FieldSelection, ExtractHeader, ExtractMode,[]);
    
    Samples1 =  double( Samples1(:) )';
    
    sfline = strmatch('-ADBitVolts',HeaderVariable);
    scale_factor = HeaderVariable{sfline};
    scale_factor(regexp(scale_factor,'[-a-zA-Z]')) = [];
    scale_factor = str2double( scale_factor );
    
    Samples1 = Samples1.*scale_factor.*1e6;
    
    filename = [p2d1,fn1(it).name];
    
    [Samples2, HeaderVariable] = Nlx2MatCSC_v3(filename, FieldSelection, ExtractHeader, ExtractMode,[]);
    
    Samples2 = double( Samples2(:) )';
    
    sfline = strmatch('-ADBitVolts',HeaderVariable);
    scale_factor = HeaderVariable{sfline};
    scale_factor(regexp(scale_factor,'[-a-zA-Z]')) = [];
    scale_factor = str2double( scale_factor );
    
    Samples2 = Samples2.*scale_factor.*1e6;
    
    
    chck(it) = isequal(Samples1,Samples2);
    fprintf('\n');
    
end;