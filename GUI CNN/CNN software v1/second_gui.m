function varargout = second_gui(varargin)
disp('second gui...')
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @second_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @second_gui_OutputFcn, ...
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

% --- Executes just before second_gui is made visible.
function second_gui_OpeningFcn(hObject, eventdata, handles, varargin)
handles.datapath = varargin{1};
handles.datalabelspath = varargin{2};
set(handles.datapath,'string',varargin{1}); 
set(handles.datalabelspath,'string',varargin{2}); 
%handles.datapath = string(varargin{1})
%handles.datalabelspath = string(varargin{2})
% Choose default command line output for second_gui
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
handles

% --- Outputs from this function are returned to the command line.
function varargout = second_gui_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function ratiotrain_Callback(hObject, eventdata, handles)
m= str2double(get(hObject,'String')); % returns contents of edit2 as a double

% --- Executes during object creation, after setting all properties.
function ratiotrain_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ratioval_Callback(hObject, eventdata, handles)
n= str2double(get(hObject,'String')) % returns contents of edit3 as a double

function ratioval_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ratiotest_Callback(hObject, eventdata, handles)
%set(handles.trainbutton,'Enable','on');

function ratiotest_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in trainbutton.
function trainbutton_Callback(hObject, eventdata, handles) % function callback corresponding to TrainCNN button
get(handles.datapath,'string')
testtrain(get(handles.datapath,'string'),get(handles.datalabelspath,'string'),get(handles.ratiotrain,'string'),get(handles.ratioval,'string'),get(handles.ratiotest,'string'));

function text2_CreateFcn(hObject, eventdata, handles)


function edit5_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit6_Callback(hObject, eventdata, handles)

function edit6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit7_Callback(hObject, eventdata, handles)


function edit7_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function datapath_Callback(hObject, eventdata, handles)

function datapath_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function datalabelspath_Callback(hObject, eventdata, handles)

function datalabelspath_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
