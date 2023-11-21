function blkStruct = slblocks
% This function specifies that the library 'mylib'
% should appear in the Library Browser with the 

    Browser.Library = 'PriusSimulinkModels';

    Browser.Name = 'PRIUS Simulink Lib';

    blkStruct.Browser = Browser;
end