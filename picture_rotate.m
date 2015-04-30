function picture_rotate
%% Function to rotate SEM image

% author: d.mercier@mpie.de

gui = guidata(gcf);

set(gui.figure.main_window, 'CurrentAxes', gui.axes);

if gui.flag.picture_load
    
    zoom reset;
    
    prompt = {'Enter ° of rotation:'};
    dlg_title = 'Input';
    num_lines = 1;
    def = {'45'};
    Rotation = inputdlg(prompt, dlg_title, num_lines, def);
    Rotationvalue = str2double(cell2mat(Rotation));
    
    if gui.picture.filenameimage_cropped == 1
        gui.picture.filenameimage_rotated = ...
            imrotate(gui.picture.filenameimage_cropped, Rotationvalue, ...
            'loose', 'bilinear');
    else
        gui.picture.filenameimage_rotated = ...
            imrotate(gui.picture.rawImages, Rotationvalue, ...
            'loose', 'bilinear');
    end
    
    gui.picture.sem_image = imshow(gui.picture.filenameimage_rotated);
    
    guidata(gcf, gui);
    
end

end