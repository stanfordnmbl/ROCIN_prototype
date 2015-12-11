clear all;
folder_dir = 'C:\Research\Stanford\bin_3\sub01_scale_study_Q_1e2_1e2_5ms_4step_act1_scaled2_reserve\';
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