clear all;
fname_input='C:\Research\Stanford\Projects\ROCIN\ROCIN_prototype\testROCIN\arm26_allmuscles_bangbang_desired_kinematics.mot';
fname_output='C:\Research\Stanford\Projects\ROCIN\ROCIN_prototype\testROCIN\arm26_allmuscles_bangbang_desired_kinematics_noisy.mot';
addNoiseToStorageFile(fname_input,fname_output,[1.0, 5.0]);
