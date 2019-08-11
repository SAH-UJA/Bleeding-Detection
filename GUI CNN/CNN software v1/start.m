function varargout = start(varargin)
clc
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @start_OpeningFcn, ...
                   'gui_OutputFcn',  @start_OutputFcn, ...
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

function start_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = start_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function radiotrain_Callback(hObject, eventdata, handles)
set(handles.radiotest,'Value',0); % For mutual exclusion of buttons
set(handles.okbutton,'Enable','on');

function radiotest_Callback(hObject, eventdata, handles)
set(handles.radiotrain,'Value',0); % For mutual exclusion of buttons
set(handles.okbutton,'Enable','on');

function okbutton_Callback(hObject, eventdata, handles)
if get(handles.radiotrain,'Value')==1
 first_gui(); close(start);
else test_gui(); close(start);
end

    
    
