classdef buildLib
    %BUILDLIB 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        libs = {'ADXL357', 'mpu6050'}
    end
    
    methods
        function obj = buildLib()
            %BUILDLIB 构造此类的实例
            %   此处显示详细说明
        end
        
        function r = isExisted(obj)
            r = true;
            if ~exist('build', 'dir')
               r = false;
               return;
            else
                if ~exist(fullfile('build', 'ADXL357'), 'dir')
                    r = false;
                    return;
                end
                if ~exist(fullfile('build', 'mpu6050'), 'dir')
                    r = false;
                    return;
                end
            end
        end

        function copyBuildLib(obj)
            if ~exist(fullfile('build', 'ADXL357'), 'dir')
                copyfile(PRIUSSimulinkLib.getInstallationLocation("ADXL357"), fullfile('build', 'ADXL357'))
            end
            if ~exist(fullfile('build', 'mpu6050'), 'dir')
                copyfile(PRIUSSimulinkLib.getInstallationLocation("mpu6050"), fullfile('build', 'mpu6050'))
            end
        end
    end
end

