function [ sg ] = InitSG( port )
% This function initializes the SRS SG384 to the serial object SG (the
% output of the function). You specify PORT with a string such as 'com4'.
% It sets the baud rate and fopens the device. You may use this in place of
% an fopen command; it is only different in the case where the device has
% not been initialized, in which case the function initializes it. It also
% fcloses before fopening so that if the function is called more than once,
% there will not be a fatal error.

% Find a serial port object.
sg = instrfind('Type', 'serial', 'Port', port, 'Tag', '');

% Create the serial port object if it does not exist
% otherwise use the object that was found.
if isempty(sg)
    sg = serial(port);
else
    fclose(sg);
    sg = sg(1)
end
set(sg,'BaudRate',115200);
% Connect to instrument object, sg.
fopen(sg);

