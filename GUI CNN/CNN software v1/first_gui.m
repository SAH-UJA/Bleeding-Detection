function varargout = first_gui(varargin)
clc
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @first_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @first_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})  gui_State.gui_Callback = str2func(varargin{1}); end
if nargout [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});  
else   gui_mainfcn(gui_State, varargin{:}); end

function first_gui_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = first_gui_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function browsetraindata_Callback(hObject, eventdata, handles)
path = uigetdir(); path = strcat(path,'\');
set(handles.datapath,'string',path);
guidata(hObject, handles);
set(handles.snapshot,'enable','on');


function browselabels_Callback(hObject, eventdata, handles)
[file,path] = uigetfile({'*.txt'},'File Selector ');
path = strcat(path,file);
set(handles.datalabelspath,'string',path);
guidata(hObject, handles);

function loadbutton_Callback(hObject, eventdata, handles)
%second_gui(get(handles.datapath,'string'),get(handles.datalabelspath,'string')); 
%close(first_gui);

function titletrain_Callback(hObject, eventdata, handles)
function titletrain_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function datapath_CreateFcn(hObject, eventdata, handles)
function ratiotrain_Callback(hObject, eventdata, handles)
function ratiotrain_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ratioval_Callback(hObject, eventdata, handles)
function ratioval_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ratiotest_Callback(hObject, eventdata, handles)
function ratiotest_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function trainbutton_Callback(hObject, eventdata, handles)
%testtrain(get(handles.datapath,'string'),...
 %   get(handles.datalabelspath,'string'),...
  %  str2double(get(handles.ratiotrain,'string')),...
   % str2double(get(handles.ratioval,'string')),...
    %str2double(get(handles.ratiotest,'string')));
trainCNN(get(handles.datapath,'string'),get(handles.datalabelspath,'string'),...
    str2double(get(handles.ratiotrain,'string')),...
    str2double(get(handles.ratioval,'string')),...
    str2double(get(handles.ratiotest,'string')));

function trainbutton_CreateFcn(hObject, eventdata, handles)


% --- Executes on button press in snapshot.
function snapshot_Callback(hObject, eventdata, handles)
figure;
datasetPath=get(handles.datapath,'string');
%n = length(dir(datasetPath))-2
perm = randperm(100,20);
imds = imageDatastore(datasetPath);
for i = 1:20
    subplot(4,5,i);
    imshow(imds.Files{perm(i)});
end
%waitfor(msgbox({'Press OK to close all windows'})); close;
