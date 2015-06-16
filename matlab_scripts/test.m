clear all;
fname_input='C:\Research\Stanford\Projects\ROCIN\ROCIN_prototype\testROCIN\arm26_allmuscles_bangbang_desired_kinematics3.mot';
fname_output='C:\Research\Stanford\Projects\ROCIN\ROCIN_prototype\testROCIN\arm26_allmuscles_bangbang_desired_kinematics3_noisy_std0.5.mot';
addNoiseToStorageFile(fname_input,fname_output,[0.5, 0.5]);

% fname_input = 'C:\Research\Stanford\Projects\ROCIN\ROCIN_prototype\testROCIN\arm26_allmuscle_match_noisy_bangbang_fwd_ResultsROCIN_10ms_10step_implicit_taylor\ROCIN_states.sto';
% fname_output='C:\Research\Stanford\Projects\ROCIN\ROCIN_prototype\testROCIN\arm26_allmuscle_match_noisy_bangbang_fwd_ResultsROCIN_10ms_10step_implicit_taylor\ROCIN_states_in_angles.sto';
% processStoFile(fname_input,fname_output,[0,1,2,3],180.0/pi,0);