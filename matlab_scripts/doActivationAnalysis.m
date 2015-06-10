function result = doActivationAnalysis(folder_dir,activation_file,result_file)
import org.opensim.modeling.*
f_dat = strcat(folder_dir,activation_file);
f_output = strcat(folder_dir,result_file);
coordinateSto=Storage(f_dat);
Time=ArrayDouble();
coordinateSto.getTimeColumn(Time);

% % Labels = ArrayStr();
Labels = coordinateSto.getColumnLabels();

n_samples = Time.getSize();
time_array=zeros(n_samples,1);
n_labels = Labels.getSize()-1;
n_effective = n_labels;
data_array=zeros(n_samples,n_labels);
label_array=[];


for k=1:n_samples
    time_array(k)=Time.getitem(k-1);
end

for k=1:n_labels
    label_array{k}=Labels.getitem(k);
    if(strfind(char(label_array{k}),'activation'))        
        coordvalue = ArrayDouble();
        coordinateSto.getDataColumn(label_array{k},coordvalue);
        for m=1:n_samples
            data_array(m,k)=coordvalue.getitem(m-1);
        end
    else
        n_effective = n_effective-1;
    end
    
end   

integs = zeros(n_labels,1);
for k=1:n_labels
   if(strfind(char(label_array{k}),'activation'))                     
        integs(k) = dot(data_array(1:n_samples-1,k).^2,diff(time_array));
    end
end

fid = fopen(f_output,'w');


for k=1:n_labels
    if(strfind(char(label_array{k}),'activation'))        
        fprintf(fid,'integral of activation %s: %f\r\n',char(label_array{k}),integs(k));
    end
end

result = sum(integs(:));

fprintf(fid,'integral of all the muscle activations: %f\r\n',result);

fclose(fid);