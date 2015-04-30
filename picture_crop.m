function picture_crop
%% Function to crop a picture

% author: d.mercier@mpie.de

gui = guidata(gcf);

set(gui.figure.main_window, 'CurrentAxes', gui.axes);

if gui.flag.picture_load
    
%     if gui.flag.HoughTrans
%         set(gui.axes_2, 'Visible', 'off');
%         delete(gui.picture.Hough_image);
%         delete(gui.picture.Hough_peaks);
%         delete(gui.picture.Hough_lines);
%         delete(gui.picture.Hough_endpoints1);
%         delete(gui.picture.Hough_endpoints2);        
%         gui.picture.rawImages = imread(gui.config.filenameimage);
%         gui.picture.high      = im2uint16(gui.picture.rawImages);
%         gui.picture.sem_image = imshow(gui.picture.high);
%         gui.flag.HoughTrans = 0;
%     end
    
    if gui.picture.filenameimage_rotated == 1
        gui.picture.filenameimage_cropped = ...
            imcrop(gui.picture.filenameimage_rotated);
    else
        gui.picture.filenameimage_cropped = ...
            imcrop(gui.picture.rawImages);
    end
    
    gui.picture.sem_image = imshow(gui.picture.filenameimage_cropped);
    
    guidata(gcf, gui);
    
end

end