clear all;
fname_input='C:\Users\Justin\Desktop\for_Soha\IK_noisy\subject01_walk_IK.mot';
fname_output='C:\Users\Justin\Desktop\for_Soha\IK_noisy\subject01_walk_IK_noisy_std5.mot';
sig_noise = ones(1,10)*5.0;
sig_noise(1:3) = 0;
addNoiseToStorageFile(fname_input,fname_output,sig_noise);

% fname_input = 'C:\Research\Stanford\Projects\ROCIN\ROCIN_prototype\testROCIN\arm26_allmuscle_match_noisy_bangbang_fwd_ResultsROCIN_10ms_10step_implicit_taylor\ROCIN_states.sto';
% fname_output='C:\Research\Stanford\Projects\ROCIN\ROCIN_prototype\testROCIN\arm26_allmuscle_match_noisy_bangbang_fwd_ResultsROCIN_10ms_10step_implicit_taylor\ROCIN_states_in_angles.sto';
% processStoFile(fname_input,fname_output,[0,1,2,3],180.0/pi,0);