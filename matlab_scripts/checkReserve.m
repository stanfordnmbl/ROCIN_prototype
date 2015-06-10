function y = checkReserve(str)
if(isempty(strfind(str,'reserve')))
    if( strcmp(str,'FX') || strcmp(str,'FY') || strcmp(str, 'FZ') || strcmp(str,'MX') || strcmp(str,'MY') || strcmp(str, 'MZ'))
        y = 1;
    else
        y = 0;
    end
else
    y = 1;
end