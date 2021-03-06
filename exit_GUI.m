function exit_GUI
%% Function to open an exit dialog box and
% to save all data as a .mat file before to close all figures

% author: d.mercier@mpie.de

pushbutton = questdlg('Ready to quit?', ...
    'Exit Dialog','Yes','No','No');

switch pushbutton
    case 'Yes',
        disp('Exiting MATLAB');
        close(gcf)
        clear all
    case 'No',
        quit cancel;
end

end