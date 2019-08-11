function varargout = test_gui(varargin)
clc
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @test_gui_OutputFcn, ...
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
function test_gui_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = test_gui_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function modelbutton_Callback(hObject, eventdata, handles)
[file,path] = uigetfile({'*.mat'},'File Selector ');
path = strcat(path,file);
set(handles.modelpath,'string',path);
guidata(hObject, handles);

function databutton_Callback(hObject, eventdata, handles)
path = uigetdir(); path = strcat(path,'\');
set(handles.testdatapath,'string',path);
guidata(hObject, handles);

function testbutton_Callback(hObject, eventdata, handles)
load net.mat;
datasetPath = get(handles.testdatapath,'string')
imds = imageDatastore(datasetPath);
PRED = double(classify(net,imds)); 

% Calculating and displaying the peformance metrics
ACTUAL = [1+ones(50,1);ones(50,1)];
[Accuracy, Sensitivity, Specificity, Precision, Recall, F1] = calculateMetrics(net, ACTUAL, PRED);
third_gui(Accuracy*100,Sensitivity*100,Specificity*100,Precision*100,Recall*100,F1*100,'Testing')
%waitfor(msgbox({'Press OK to close.'}));
%close all;

% Writing into Excel file with B for bleeding and N for normal
PRED(PRED==2) = 'B'; PRED(PRED==1) = 'N';
T = table(imds.Files, char(PRED));
header={'Image','Target_Bleeding_OR_Normal'};
T.Properties.VariableNames = header;
filename = 'TestResults.xlsx';
writetable(T,filename,'Sheet',1,'Range','A1')
