function devID = findMOTU24()
devID = [];
a = playrec('getDevices');

for i=1:length(a)
    if strcmpi({a(i).name}, 'MOTU Pro Audio')
        devID = a(i).deviceID;
        break
    end   
end

if isempty(devID)
    error('MOTU Pro Audio device not found.')
    devID = -1;
end
