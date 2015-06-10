clear all;
folder_dir = 'C:\Research\Stanford\Projects\ROCIN\ROCIN_prototype\testROCIN\arm26_allmuscle_match_bangbang_fwd_ResultsROCIN';
% analyze the activaiton
doActivationAnalysis(folder_dir,'\ROCIN_states.sto','\acts_integral_new.txt');
% analyze the reserve forces
doReserveAnalysis(folder_dir,'\ROCIN_controls.sto','\rese_integral_new.txt');
% analyze the tracking error
doRMSErrAnalysis(folder_dir,'\err_coord_tracking.sto','\tracking_err.txt');