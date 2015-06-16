function resEffort = doReserveAnalysis(folder_dir,rese_force_file,result_file,fid_print)
if(nargin < 4)
    fid_print = 1;
end

import org.opensim.modeling.*
f_dat = strcat(folder_dir,rese_force_file);
f_output = strcat(folder_dir,result_file);

resEffort=[];

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

n_effective = 0;
for k=1:n_labels
    if(checkReserve(char(label_array{k})))
        n_effective = n_effective+1;
        integs(k) = dot(data_array(1:n_samples-1,k).^2,diff(time_array));
    end
end

fid = fopen(f_output,'w');

idx_reserve = 1;
label_reserve =[];
for k=1:n_labels
    if(checkReserve(char(label_array{k})))
        fprintf(fid,'integral of actuator %s: %f\r\n',char(label_array{k}),integs(k));
        resEffort = [resEffort;integs(k)];
        label_reserve{idx_reserve} = char(label_array{k});
        idx_reserve = idx_reserve+1;
    end
end

if(isempty(label_reserve))
    fprintf(fid_print,'No reserve forces!\r\n');
    fprintf(fid,'No reserve forces!\r\n');
    fclose(fid);
else
    fprintf(fid,'integral of all the reserve actuators: %f\r\n',sum(integs));
    fclose(fid);
    if(length(label_reserve)>=6)
        fprintf(fid_print,'Total Effort of %s %s %s: %f\r\n',label_reserve{1},label_reserve{2},label_reserve{3},sum(resEffort(1:3)));
        fprintf(fid_print,'Total Effort of %s %s %s: %f\r\n',label_reserve{4},label_reserve{5},label_reserve{6},sum(resEffort(4:6)));
    end
end