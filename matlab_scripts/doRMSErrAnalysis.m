function integs = doRMSErrAnalysis(folder_dir,err_file,result_file, fid_print)
if(nargin<4)
    fid_print = 1;
end

import org.opensim.modeling.*
f_dat = strcat(folder_dir,err_file);
f_output = strcat(folder_dir,result_file);
coordinateSto=Storage(f_dat);
Time=ArrayDouble();
coordinateSto.getTimeColumn(Time);

% % Labels = ArrayStr();
Labels = coordinateSto.getColumnLabels();

n_samples = Time.getSize();
time_array=zeros(n_samples,1);
n_labels = Labels.getSize()-1;
data_array=zeros(n_samples,n_labels);
label_array=[];


for k=1:n_samples
    time_array(k)=Time.getitem(k-1);
end

for k=1:n_labels
    label_array{k}=Labels.getitem(k);
    coordvalue = ArrayDouble();
    coordinateSto.getDataColumn(label_array{k},coordvalue);
    for m=1:n_samples
        data_array(m,k)=coordvalue.getitem(m-1);
    end
    
end   

integs = zeros(n_labels,1);

for k=1:n_labels
    % we do not consider the tracking error for constrained joint
    if(isempty(strfind(label_array{k},'_constrained')))
        integs(k) = dot(data_array(1:n_samples-1,k).^2,diff(time_array));
    end
end

integs = integs/(time_array(end)-time_array(1));

fid = fopen(f_output,'w');

n_effective = 0;

for k=1:n_labels
    if(isempty(strfind(label_array{k},'_constrained'))&&integs(k)>1e-9)
        n_effective = n_effective + 1;
        fprintf(fid,'RMS Err %s: %f\r\n',char(label_array{k}),sqrt(integs(k)));
    end
end

% in case there are floating joint 
if(n_labels >= 6)
    rms_1_3 = sqrt(sum(integs(1:3))/3);
    rms_4_6 = sqrt(sum(integs(4:6))/3);
    rms_1_6 = sqrt(sum(integs(1:6))/6);
    rms_remaining = sqrt(sum(integs(7:end))/(n_effective-6));

    fprintf(fid,'Average RMS of %s %s %s: %f\r\n',char(label_array{1}),char(label_array{2}),char(label_array{3}),rms_1_3);
    fprintf(fid,'Average RMS of %s %s %s: %f\r\n',char(label_array{4}),char(label_array{5}),char(label_array{6}),rms_4_6);
    fprintf(fid,'Average RMS of above: %f\r\n',rms_1_6);
    fprintf(fid,'Average RMS of remaining joints: %f\r\n',rms_remaining);

    fprintf(fid_print,'Average RMS of %s %s %s: %f\r\n',char(label_array{1}),char(label_array{2}),char(label_array{3}),rms_1_3);
    fprintf(fid_print,'Average RMS of %s %s %s: %f\r\n',char(label_array{4}),char(label_array{5}),char(label_array{6}),rms_4_6);
    fprintf(fid_print,'Average RMS of above: %f\r\n',rms_1_6);
    fprintf(fid_print,'Average RMS of remaining joints: %f\r\n',rms_remaining);
end

rms_err = sqrt(sum(integs)/n_effective);
max_err = max(abs(data_array(:)));
fprintf(fid,'Average RMS Err: %f\r\n',rms_err);
fprintf(fid,'Max Tracking Err: %f\r\n',max_err);

fclose(fid);


fprintf(fid_print,'Average RMS Err: %f\r\n',rms_err);
fprintf(fid_print,'Max Tracking Err: %f\r\n',max_err);

