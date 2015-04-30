function picture_load
%% Function to load SEM image (.tif file)

% author: d.mercier@mpie.de

gui = guidata(gcf);
gui.flag.picture_load = 0;

%% Import image
refreshdata(gui.handles.ImpImage1File, 'String');

[filenameimage, pathnameimage] = ...
    uigetfile({'*.tif', 'All Image Files'}, 'File Selector');

if isequal(filenameimage, 0)
    disp('User selected Cancel');
    
else
    disp(['User selected', fullfile(pathnameimage, filenameimage)]);
    
    set(gui.handles.ImpImage1File, 'String', filenameimage);

    set(gui.figure.main_window, 'CurrentAxes', gui.axes);
    
    %% Plot
    zoom reset;
    
    if filenameimage ~= 0
        %cd(pathnameimage);
        [gui.picture.rawImages] = imread(fullfile(pathnameimage, filenameimage));
        % --- Scale down large images
        gui.picture.high      = im2uint16(gui.picture.rawImages);
        gui.picture.sem_image = imshow(gui.picture.high);
    end
    
    gui.config.filenameimage = filenameimage;
    gui.config.pathnameimage = pathnameimage;
    gui.flag.picture_load = 1;
    
end

gui.picture.filenameimage_rotated = [];
gui.picture.filenameimage_cropped = [];

guidata(gcf, gui);

end