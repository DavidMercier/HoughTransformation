function picture_HoughTransformation
%% Function to plot Hough transformation and peaks detection

% author: d.mercier@mpie.de

gui = guidata(gcf);
currentimage = gui.picture.sem_image.CData;
high = gui.edge_detection.high;

%% Refreshing and getting values of variables
refreshdata(gui.handles.HT_RHO_VALUE,       'String');
%refreshdata(gui.handles.HT_THETA_VALUE,     'String');
refreshdata(gui.handles.HT_H_VALUE,         'String');
refreshdata(gui.handles.HT_THRES_VALUE,     'String');
refreshdata(gui.handles.HT_FILLGAP_VALUE,   'String');
refreshdata(gui.handles.HT_MINLENGTH_VALUE, 'String');

RHO_VALUE       = str2num(get(gui.handles.HT_RHO_VALUE,       'string'));
%THETA_VALUE     = str2num(get(gui.handles.HT_THETA_VALUE,     'string'));
H_VALUE         = str2num(get(gui.handles.HT_H_VALUE,         'string'));
THRES_VALUE     = str2num(get(gui.handles.HT_THRES_VALUE,     'string'));
FILLGAP_VALUE   = str2num(get(gui.handles.HT_FILLGAP_VALUE,   'string'));
MINLENGTH_VALUE = str2num(get(gui.handles.HT_MINLENGTH_VALUE, 'string'));

%% Hough transformation
[H, theta, rho] = ...
    hough(high, 'RhoResolution', RHO_VALUE, 'Theta', -90:0.5:89.5);

%gui.figure.HoughTransform = figure('Name', 'Hough transform', 'NumberTitle', 'off');

set(gui.figure.main_window, 'CurrentAxes', gui.axes_2);
set(gui.axes_2, 'Visible', 'on');

gui.picture.Hough_image = imshow(imadjust(mat2gray(H)), [], ...
    'XData', theta, ...
    'YData', rho, ...
    'InitialMagnification', 'fit');

xlabel('\theta (degrees)'), ylabel('\rho');
axis on;
axis normal;
hold on;
colormap(hot);

%% Hough peaks detection
P = houghpeaks(H, H_VALUE, 'threshold', ceil(THRES_VALUE*max(H(:))));
x = theta(P(:, 2));
y = rho(P(:, 1));
gui.picture.Hough_peaks = plot(x, y, 's', 'color', 'black');

% Set current axes
set(gui.figure.main_window, 'CurrentAxes', gui.axes);

%% Hough lines plotting
lines = ...
    houghlines(high, theta, ...
    rho, P, ...
    'FillGap', FILLGAP_VALUE, ...
    'MinLength', MINLENGTH_VALUE);

%gui.figure.HoughLines = figure('Name', 'Hough lines', 'NumberTitle', 'off');
set(0, 'CurrentFigure', gui.figure.main_window);
set(gui.figure.main_window, 'CurrentAxes', gui.axes);

gui.picture.sem_image = imshow(currentimage);
hold on;

max_len = 0;
ii = 1;
for kk = 1:length(lines)
    xy = [lines(kk).point1; lines(kk).point2];
    gui.picture.Hough_lines = plot(xy(:, 1), xy(:, 2), 'LineWidth', 2, 'Color', 'green');
    
    % Plot beginnings and ends of lines
    gui.picture.Hough_endpoints1 = plot(xy(1, 1), xy(1, 2), 'x', 'LineWidth', 2, 'Color', 'yellow');
    gui.picture.Hough_endpoints2 = plot(xy(2, 1), xy(2, 2), 'x', 'LineWidth', 2, 'Color', 'red');
    
    % Determine the endpoints of the longest line segment
    len = norm(lines(kk).point1 - lines(kk).point2);
    if (len > max_len)
        max_len = len;
        xy_long = xy;
    end
    xy_lines(ii:ii+1,:) = xy;
    ii = ii + 2;
end

%% Set variables
gui.Hough.H = H;
gui.Hough.theta = theta;
gui.Hough.rho = rho;
gui.Hough.P = P;
gui.Hough.lines = lines;
gui.Hough.lines_xy = xy_lines;

gui.flag.HoughTrans = 1;

guidata(gcf, gui);

end