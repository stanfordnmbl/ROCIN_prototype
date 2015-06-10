function addNoiseToStorageFile(fname_input, fname_output, sigma_noise)
import org.opensim.modeling.*
input_sto=Storage(fname_input);
Time=ArrayDouble();
input_sto.getTimeColumn(Time);
Labels = input_sto.getColumnLabels();

n_samples = Time.getSize();
n_labels = Labels.getSize()-1;
label_array=[];

% get the std deviation of the noise
std_noise = zeros(1,n_labels);
for k=1:length(sigma_noise)
    std_noise(k)=sigma_noise(k);
end


for k=1:n_labels
    label_array{k}=Labels.getitem(k);
    coordvalue = ArrayDouble();
    state_idx = input_sto.getStateIndex(label_array{k});
    input_sto.getDataColumn(state_idx,coordvalue);
    data_noise = randn(n_samples,1)*std_noise(k);
    for m=1:n_samples
        coordvalue.setitem(m-1, coordvalue.getitem(m-1)+data_noise(m));
    end
    input_sto.setDataColumn(state_idx,coordvalue);
end   

input_sto.print(fname_output);