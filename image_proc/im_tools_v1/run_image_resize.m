%%
addpath('~rouxf/Desktop/im_tools_v1/');

sinf.rsz = [360 720];
sinf.fmt = 'bmp';
iminf.ext = '*';
finf.p2d = '/home/adf/rouxf/Desktop/images/P06/SE01/';
finf.fn = dir([finf.p2d,'*.',iminf.ext]);
if strcmp(iminf.ext,'*')
    finf.fn(1:2) = [];
end;

image_resize(finf,iminf,sinf)
