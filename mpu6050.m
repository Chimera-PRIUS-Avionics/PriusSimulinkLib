classdef mpu6050 < matlab.System ...
    & coder.ExternalDependency ...
    & matlabshared.sensors.simulink.internal.BlockSampleTime

% Measure accleration
%#codegen
%#ok<*EMCA>

properties (Access = private)


end

methods
    % Constructor
    function obj = mpu6050(varargin)
        setProperties(obj,nargin,varargin{:});
    end
end

methods (Access=protected)
    function setupImpl(obj)
        if ~coder.target('MATLAB')
            coder.cinclude('mpu6050sl.h');
            coder.ceval('setupFunctionMpu6050');
        end
    end

    function validateInputsImpl(obj,varargin)
        %  Check the input size
        if nargin ~=0



        end
    end

    function [ax,ay,az, gx, gy, gz] = stepImpl(obj)
        ax = single(0);
        ay = single(0);
        az = single(0);

        gx = single(0);
        gy = single(0);
        gz = single(0);
        if isempty(coder.target)
            x=3;
        else
            coder.ceval('stepFunctionMpu6050', ...
                coder.ref(ax), ...
                coder.ref(ay), ...
                coder.ref(az), ...
                coder.ref(gx), ...
                coder.ref(gy), ...
                coder.ref(gz));
    end
    end

    function releaseImpl(obj)
        if isempty(coder.target)
        else

        end
    end
end

methods (Access=protected)
    %% Define output properties
    function num = getNumInputsImpl(~)
        num = 0;
    end

    function num = getNumOutputsImpl(~)
        num = 6;
    end

    function varargout = getInputNamesImpl(obj)

    end

    function varargout = getOutputNamesImpl(obj)
        varargout{1} = 'ax';
        varargout{2} = 'ay';
        varargout{3} = 'az';
        varargout{4} = 'gx';
        varargout{5} = 'gy';
        varargout{6} = 'gz';
    end

    function flag = isOutputSizeLockedImpl(~,~)
        flag = true;
    end

    function varargout = isOutputFixedSizeImpl(~,~)
        varargout{1} = true;
        varargout{2} = true;
        varargout{3} = true;
        varargout{4} = true;
        varargout{5} = true;
        varargout{6} = true;
    end

    function varargout = isOutputComplexImpl(~)
        varargout{1} = false;
        varargout{2} = false;
        varargout{3} = false;
        varargout{4} = false;
        varargout{5} = false;
        varargout{6} = false;
    end

    function varargout = getOutputSizeImpl(~)
        varargout{1} = [1,1];
        varargout{2} = [1,1];
        varargout{3} = [1,1];
        varargout{4} = [1,1];
        varargout{5} = [1,1];
        varargout{6} = [1,1];
    end

    function varargout = getOutputDataTypeImpl(~)
        varargout{1} = 'single';
        varargout{2} = 'single';
        varargout{3} = 'single';
    end

    function maskDisplayCmds = getMaskDisplayImpl(obj)
        outport_label = [];
        num = getNumOutputsImpl(obj);
        if num > 0
            outputs = cell(1,num);
            [outputs{1:num}] = getOutputNamesImpl(obj);
            for i = 1:num
                outport_label = [outport_label 'port_label(''output'',' num2str(i) ',''' outputs{i} ''');' ]; %#ok<AGROW>
            end
        end
        inport_label = [];
        num = getNumInputsImpl(obj);
        if num > 0
            inputs = cell(1,num);
            [inputs{1:num}] = getInputNamesImpl(obj);
            for i = 1:num
                inport_label = [inport_label 'port_label(''input'',' num2str(i) ',''' inputs{i} ''');' ]; %#ok<AGROW>
            end
        end
        icon = 'adxl357';
        maskDisplayCmds = [ ...
            ['color(''white'');',...
            'plot([100,100,100,100]*1,[100,100,100,100]*1);',...
            'plot([100,100,100,100]*0,[100,100,100,100]*0);',...
            'color(''blue'');', ...
            ['text(38, 92, ','''',obj.Logo,'''',',''horizontalAlignment'', ''right'');',newline],...
            'color(''black'');'], ...
            ['text(52,50,' [''' ' icon ''',''horizontalAlignment'',''center'');' newline]]   ...
            inport_label ...
            outport_label
            ];
    end

    function sts = getSampleTimeImpl(obj)
        sts = getSampleTimeImpl@matlabshared.sensors.simulink.internal.BlockSampleTime(obj);
    end
end

methods (Static, Access=protected)
    function simMode = getSimulateUsingImpl(~)
        simMode = 'Interpreted execution';
    end

    function isVisible = showSimulateUsingImpl
        isVisible = false;
    end
end

methods (Static)
    function name = getDescriptiveName()
        name = 'mpu6050';
    end

    function b = isSupportedContext(context)
        b = context.isCodeGenTarget('rtw');
    end

    function updateBuildInfo(buildInfo, context)
        coder.extrinsic('matlabshared.sensors.simulink.internal.getTargetHardwareName');
        targetname = coder.const(matlabshared.sensors.simulink.internal.getTargetHardwareName);
        % Get the filelocation of the SPKG specific files
        coder.extrinsic('matlabshared.sensors.simulink.internal.getTargetSpecificFileLocationForSensors');
        fileLocation = coder.const(@matlabshared.sensors.simulink.internal.getTargetSpecificFileLocationForSensors,targetname);
        coder.extrinsic('which');
        coder.extrinsic('error');
        coder.extrinsic('message');
        funcName = [fileLocation,'.getTargetSensorUtilities'];
        functionPath = coder.const(@which,funcName);
        % Only if the the path exist
        if ~isempty(fileLocation)
            % internal error to see if the target author has provided
            % the expected function in the specified file location
            assert(~isempty(functionPath),message('matlab_sensors:general:FunctionNotAvailableSimulinkSensors','getTargetSensorUtilities'));
            funcHandle = str2func(funcName);
            hwUtilityObject = funcHandle('I2C');
            assert(isa(hwUtilityObject,'matlabshared.sensors.simulink.internal.SensorSimulinkBase'),message('matlab_sensors:general:invalidHwObjSensorSimulink'));
        else
            hwUtilityObject = '';
        end

        if ~isempty(hwUtilityObject)
            hwUtilityObject.updateBuildInfo(buildInfo, context);
        end

        % Update buildInfo
        srcDir = fullfile(fileparts(mfilename('fullpath')),'src');
        includeDir = fullfile(fileparts(mfilename('fullpath')),'include');
        libDir =  fullfile(fileparts(mfilename('fullpath')),'libraries', 'mpu6050', 'src');

        buildInfo.addIncludePaths(libDir);
        buildInfo.addIncludePaths(includeDir);
        
        addSourceFiles(buildInfo,'MPU6050.cpp',libDir);
        addSourceFiles(buildInfo,'mpu6050sl.cpp',srcDir);

    end
end
end
