% Convert image extensions from a folder containing files
% Created by Husanbir Singh Pannu, Thapar Institute of Engineering and
% Technology Patiala 23-June 2019

function varargout = ConvertImageExtension(varargin)
clc

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ConvertImageExtension_OpeningFcn, ...
                   'gui_OutputFcn',  @ConvertImageExtension_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before ConvertImageExtension is made visible.
function ConvertImageExtension_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);


function varargout = ConvertImageExtension_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on selection change in listbox.
function listbox_Callback(hObject, eventdata, handles)

function listbox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browsebutton.
function browsebutton_Callback(hObject, eventdata, handles)
source = uigetdir();
set(handles.source,'string',source);
%sourceDir = get(handles.source,'string'); sourceDir = strcat(sourceDir,'\')
%set(handles.direction,'string','Images will be saved in a new director - ExtensionConverted');
guidata(hObject,handles) % Save the handles structure.

% --- Executes on button press in convertbutton.
function convertbutton_Callback(hObject, eventdata, handles)
set(handles.convertbutton,'Enable','on'); % Disables button after job is done
%extchoice = get(handles.choice,'string');
mkdir ConvertedExtensions;
destination = strcat(pwd,'\ConvertedExtensions\');
sourceDir = get(handles.source,'string');
sourceDir = strcat(sourceDir,'\');
extension = strcat('.',string(handles.choice));
ExtConv(sourceDir, destination, extension);
set(handles.status,'string','Done!'); 



function popupmenu1_Callback(hObject, eventdata, handles)
str = get(hObject, 'String'); % Determine the selected data set.
val = get(hObject,'Value'); % Set current data to the selected data set.
set(handles.direction,'string','Files will be saved in ConvertedExtensions folder.');set(handles.convertbutton,'Enable','on'); % Disables button after job is done
set(handles.convertbutton,'Enable','on'); % Disables button after job is done
handles.choice = str(val);
guidata(hObject,handles) % Save the handles structure.


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% -----------------------------------------------------------
% Function to convertbutton JPG/BMP to PNG
function ExtConv(sourceDir, destination, extension)
% JPG to given extension
%extension = strcat('.',extension) % sticking . before required ext
allJPGfiles = strcat(sourceDir,'*.jpg');
sourceImages = dir(allJPGfiles);  
for i = 1 : length(sourceImages)
filename = strcat(sourceDir,sourceImages(i).name);
im = imread(filename);
newfilename=strcat(destination,sourceImages(i).name);
outputFullFileName = strrep(lower(newfilename),'.jpg',extension);
imwrite(im, outputFullFileName);
end

% bmp given extension
allBMPfiles = strcat(sourceDir,'*.bmp');
sourceImages = dir(allBMPfiles);  
for i = 1 : length(sourceImages)
filename = strcat(sourceDir,sourceImages(i).name);
im = imread(filename);
newfilename=strcat(destination,sourceImages(i).name);
outputFullFileName = strrep(lower(newfilename),'.bmp',extension);
imwrite(im, outputFullFileName);
end

% convert png to given extension
allPNGfiles = strcat(sourceDir,'*.png');
sourceImages = dir(allPNGfiles);  
for i = 1 : length(sourceImages)
filename = strcat(sourceDir,sourceImages(i).name);
im = imread(filename);
newfilename=strcat(destination,sourceImages(i).name);
outputFullFileName = strrep(lower(newfilename),'.png',extension);
imwrite(im, outputFullFileName);
end
