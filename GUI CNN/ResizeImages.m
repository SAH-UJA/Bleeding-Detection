% GUI based resize images to given sized pixels
% Created by Husanbir Singh Pannu, Thapar Institute of Engineering and
% Technology Patiala 24-June 2019

function varargout = ResizeImages(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ResizeImages_OpeningFcn, ...
                   'gui_OutputFcn',  @ResizeImages_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
clc

function ResizeImages_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = ResizeImages_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function rows_Callback(hObject, eventdata, handles)
rows = str2num(get(handles.rows,'string'));

function rows_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function source_Callback(hObject, eventdata, handles)

function source_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function destination_Callback(hObject, eventdata, handles)

function destination_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton1_Callback(hObject, eventdata, handles)

function cols_Callback(hObject, eventdata, handles)
cols = str2num(get(handles.cols,'string'));

function cols_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function sourcebutton_Callback(hObject, eventdata, handles)
 source = uigetdir();
 set(handles.source,'string',source);
 set(handles.ready,'string','Files will be saved in the Resized folder.');
 
% --- Executes on button press in button.
function button_Callback(hObject, eventdata, handles)
mkdir Resized; 
destination = strcat(pwd,'\Resized\')
sourceDir = get(handles.source,'string'); sourceDir = strcat(sourceDir,'\')
rows = str2num(get(handles.rows,'string'))
cols = str2num(get(handles.cols,'string'))
resizeImages(rows,cols,sourceDir,destination);
set(handles.done,'string','DONE!'); % print DONE message
set(handles.button,'Enable','off'); % Disables button after job is done

% -----------------------------------------------
% Function to resize images ---------------------
% -----------------------------------------------
function resizeImages(rows,cols, sourceDir, destination)
%SIZE = 256;
SIZE = [rows cols];
allPNGfiles = strcat(sourceDir,'*.png');
sourceImages = dir(allPNGfiles);  

for i = 1 : length(sourceImages)
filename = strcat(sourceDir,sourceImages(i).name);
im = imread(filename);
k=imresize(im,SIZE);
newfilename=strcat(destination,sourceImages(i).name);
imwrite(k,newfilename,'png');
end

allPNGfiles = strcat(sourceDir,'*.jpg');
sourceImages = dir(allPNGfiles);  
for i = 1 : length(sourceImages)
filename = strcat(sourceDir,sourceImages(i).name);
im = imread(filename);
k=imresize(im,SIZE);
newfilename=strcat(destination,sourceImages(i).name);
imwrite(k,newfilename,'jpg');
end

allPNGfiles = strcat(sourceDir,'*.bmp');
sourceImages = dir(allPNGfiles);  
for i = 1 : length(sourceImages)
filename = strcat(sourceDir,sourceImages(i).name);
im = imread(filename);
k=imresize(im,SIZE);
newfilename=strcat(destination,sourceImages(i).name);
imwrite(k,newfilename,'jpg');
end
