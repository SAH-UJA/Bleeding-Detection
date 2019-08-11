function [Accuracy, Sensitivity, Specificity, Precision, Recall, F1] = calculateMetrics(net, ACTUAL, PREDICTED)
idx = (ACTUAL()==1);
p = length(ACTUAL(idx)); 
n = length(ACTUAL(~idx));   
N = p+n; 
tp = sum(ACTUAL(idx)==PREDICTED(idx)); 
tn = sum(ACTUAL(~idx)==PREDICTED(~idx));
fp = n-tn;    
fn = p-tp; 
Accuracy =  (tp+tn)/(tp+fp+fn+tn);
Sensitivity = tp/(tp+fn);
Specificity = tn/(tn+fp);
Precision = tp/(tp+fp);
Recall = tp/(tp+fn);
F1 = (2*Recall*Precision)/(Recall+Precision);
%sum(PREDICTED == ACTUAL)/numel(ACTUAL); is also the Accuracy 
end
