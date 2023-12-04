
%load hypothetical_parameters

%parameters_class0=hypothetical_parameters_class0(1:744,:);
%parameters_class1=hypothetical_parameters_class1(1:260,:);
%parameters_class2=hypothetical_parameters_class2(1:175,:);


%for count=1:5
%    hit_rate(count)=multi_svm_cv_ttest(parameters_class0,parameters_class1,parameters_class2,100*count);
%    count
%end


hit_rate=multi_svm_cv_ttest(hypothetical_parameters_class0,hypothetical_parameters_class1,hypothetical_parameters_class2,feature_number);

%save classification_result

