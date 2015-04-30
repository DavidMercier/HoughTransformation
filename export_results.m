function export_results
%% Function to save Hough results and Hough figures

% author: d.mercier@mpie.de

gui = guidata(gcf);

t = datetime('now','TimeZone','local','Format','d-MMM-y');

P = gui.Hough.P;
lines = gui.Hough.lines_xy;

if gui.flag.picture_load
    saveas(gcf, [char(t), '_Hough_lines'], 'png');
    save([char(t), '_Hough_vectors.txt'], 'P', '-ascii');
    save([char(t), '_Hough_lines.txt'], 'lines', '-ascii');
    commandwindow;
    display('Data saved !');
else
    commandwindow;
    disp('No data to save !');
end

end