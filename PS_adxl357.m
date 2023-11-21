classdef PS_adxl357 < matlab.System ...
        & coder.ExternalDependency ...
        & matlabshared.sensors.simulink.internal.BlockSampleTime

    % Measure accleration
    %#codegen
    %#ok<*EMCA>

    properties
        Range = uint8(0);
    end

    properties(Access = protected)
        Logo = 'IO Device Builder';
    end

    properties (Nontunable)
        IsHighAddress = boolean(0);
    end

    properties (Access = private)


    end

    methods
        % Constructor
        function obj = PS_adxl357(varargin)
            setProperties(obj,nargin,varargin{:});
        end
    end

    methods (Access=protected)
        function setupImpl(obj)
            if ~coder.target('MATLAB')
                coder.cinclude('adxl357.h');
                coder.ceval('setupFunctionadxl357', coder.ref(obj.Range),1, (obj.IsHighAddress),1);
            end
        end

        function validateInputsImpl(obj,varargin)
            %  Check the input size
            if nargin ~=0



            end
        end

        function [x,y,z] = stepImpl(obj)
            x = single(zeros(1,1));
            y = single(zeros(1,1));
            z = single(zeros(1,1));
            if isempty(coder.target)
                x=3;
            else
                coder.ceval('stepFunctionadxl357',coder.ref(x),1,coder.ref(y),1,coder.ref(z),1, coder.ref(obj.Range),1);
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
            num = 3;
        end

        function varargout = getInputNamesImpl(obj)

        end

        function varargout = getOutputNamesImpl(obj)
            varargout{1} = 'x';
            varargout{2} = 'y';
            varargout{3} = 'z';
        end

        function flag = isOutputSizeLockedImpl(~,~)
            flag = true;
        end

        function varargout = isOutputFixedSizeImpl(~,~)
            varargout{1} = true;
            varargout{2} = true;
            varargout{3} = true;
        end

        function varargout = isOutputComplexImpl(~)
            varargout{1} = false;
            varargout{2} = false;
            varargout{3} = false;
        end

        function varargout = getOutputSizeImpl(~)
            varargout{1} = [1,1];
            varargout{2} = [1,1];
            varargout{3} = [1,1];
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
            name = 'adxl357';
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
            libDir =  fullfile(fileparts(mfilename('fullpath')),'build', 'ADXL357');

            buildInfo.addIncludePaths(libDir);
            buildInfo.addIncludePaths(includeDir);
            
            addSourceFiles(buildInfo,'ADXL357.cpp',libDir);
            addSourceFiles(buildInfo,'adxl357.cpp',srcDir);

        end
    end
end
