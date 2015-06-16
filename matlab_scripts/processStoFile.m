function processStoFile(fname_input, fname_output, state_indices, scale, offset)
import org.opensim.modeling.*
input_sto=Storage(fname_input);
Time=ArrayDouble();
input_sto.getTimeColumn(Time);

n_samples = Time.getSize();

for k=state_indices
    coordvalue = ArrayDouble();
    input_sto.getDataColumn(k,coordvalue);
    for m=1:n_samples
        coordvalue.setitem(m-1, scale*coordvalue.getitem(m-1)+offset);
    end
    input_sto.setDataColumn(k,coordvalue);
end   

input_sto.print(fname_output);