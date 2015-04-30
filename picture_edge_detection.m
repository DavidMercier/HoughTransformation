function picture_edge_detection
%% Function to do edge detection

% author: d.mercier@mpie.de

gui = guidata(gcf);

if gui.flag.picture_load
    
    %% Setting of variables and parameters
    refreshdata(gui.handles.AlgoChoice);
    refreshdata(gui.handles.ThresBefValue);
    
    currentimage = gui.picture.sem_image.CData;
    
    threshold = str2num(get(gui.handles.ThresBefValue, 'string'));
    num_algo = get(gui.handles.AlgoChoice, 'value');
    
    %% Image corrections
    % Contrast Stretchv
    I = imadjust(currentimage, stretchlim(currentimage));
    
    % Reduce noise
    msk = [10,10];
    if 1
        I = wiener2(I, msk);
    else
        I = medfilt2(I,msk);
    end
    
    %% Edge detection
    if num_algo == 1
        algo = 'sobel';
    elseif num_algo == 2
        algo = 'prewitt';
    elseif num_algo == 3
        algo = 'roberts';
    elseif num_algo == 4
        algo = 'canny';
    elseif num_algo == 5
        algo = 'log';
    end
    
    % Set thresholds for edge detection
    if threshold >= 1 || threshold <= 0
        helpdlg('Please, threshold must be between 0 and 1', 'Error');
        switch button
            case 'OK',
                quit cancel;
        end
        stop;
    end
    
    % Image visualization - New axes
    set(gui.figure.main_window, 'CurrentAxes', gui.axes_2);
    set(gui.axes_2, 'Visible', 'on');
    
    high = edge(I, algo, threshold);
    high = imclearborder(high);
    imshow(high);
    
    gui.edge_detection.algo = algo;
    gui.edge_detection.threshold = threshold;
    gui.edge_detection.high = high;
    
    % Set on visibility of buttons for Hough settings
    set(gui.handles.Button_Hough, 'Visible', 'on');
    set(gui.handles.HT_RHO_TITLE, 'Visible', 'on');
    set(gui.handles.HT_RHO_VALUE, 'Visible', 'on');
    set(gui.handles.HT_H_TITLE, 'Visible', 'on');
    set(gui.handles.HT_H_VALUE, 'Visible', 'on');
    set(gui.handles.HT_THRES_TITLE, 'Visible', 'on');
    set(gui.handles.HT_THRES_VALUE, 'Visible', 'on');
    set(gui.handles.HT_FILLGAP_TITLE, 'Visible', 'on');
    set(gui.handles.HT_FILLGAP_VALUE, 'Visible', 'on');
    set(gui.handles.HT_MINLENGTH_TITLE, 'Visible', 'on');
    set(gui.handles.HT_MINLENGTH_VALUE, 'Visible', 'on');
    
    % Set current axes
    set(gui.figure.main_window, 'CurrentAxes', gui.axes);
    
end

guidata(gui.figure.main_window, gui);

end