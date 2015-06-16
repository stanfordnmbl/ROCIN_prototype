clear all;
folder_dir = 'C:\Research\Stanford\Projects\ROCIN\ROCIN_prototype\images\10ms_1step_implicity_taylor\arm26_allmuscle_match_noisy_std_1_bangbang_10ms_1step\';
% analyze the activaiton
% doActivationAnalysis(folder_dir,'\arm26_states.sto','\acts_integral_new.txt');
% % analyze the reserve forces
% doReserveAnalysis(folder_dir,'\arm26_Actuation_force.sto','\rese_integral_new.txt');
% analyze the tracking error
% doRMSErrAnalysis(folder_dir,'\err_coord_tracking.sto','\tracking_err.txt');
% analyze the activaiton
doActivationAnalysis(folder_dir,'\ROCIN_states.sto','\acts_integral_new.txt');
% analyze the reserve forces
doReserveAnalysis(folder_dir,'\ROCIN_controls.sto','\rese_integral_new.txt');
% analyze the tracking error
doRMSErrAnalysis(folder_dir,'\err_coord_tracking.sto','\tracking_err.txt');