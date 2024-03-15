function closeGUI

global SPINAPI_DLL_NAME;

selection = questdlg('Do you want to exit the program?',...
                     'Close Request Function',...
                     'Yes','No','Yes');
switch selection,
   case 'Yes',
    %pb_close();
    unloadlibrary(SPINAPI_DLL_NAME)
    delete(gcf)
   case 'No'
     return
end
