function plan = buildfile
import matlab.buildtool.tasks.CodeIssuesTask
import matlab.buildtool.tasks.TestTask

% Create a plan from task functions
plan = buildplan(localfunctions);

plan.DefaultTasks = "package";

end

function packageTask(~)
% ToolBox Package
version_num = getenv("PRIUS_SIMULINK_LIB_VERSION_NUM");

if(isempty(version_num))
    version_num = '0';
end

opts = matlab.addons.toolbox.ToolboxOptions('./',"PRIUSSimulinkLib");

opts.ToolboxName = "PRIUS Simulink Lib";

opts.SupportedPlatforms.Win64 = true;
opts.SupportedPlatforms.Maci64 = true;
opts.SupportedPlatforms.Glnxa64 = true;
opts.SupportedPlatforms.MatlabOnline = true;

opts.ToolboxFiles = {'+PRIUSSimulinkLib',
                     './include',
                     './src',
                     'PS_adxl357.m',
                     'PS_mpu6050.m',
                     'PriusSimulinkModels.slx',
                     'sl_customization.m',
                     'slblocks.m'};

opts.OutputFile = "PRIUS Simulink Lib";

opts.RequiredAdditionalSoftware = [ ...
    struct("Name", "ADXL357", ...
           "Platform", {'win64', 'glnxa64', 'maci64'},...
           "DownloadURL", "https://github.com/Chimera-PRIUS-Avionics/ADXL357/archive/refs/heads/main.zip", ...
           "LicenseURL", "https://mit-license.org/"), ...
    struct("Name", "mpu6050", ...
           "Platform", {'win64', 'glnxa64', 'maci64'},...
           "DownloadURL", "https://github.com/ElectronicCats/mpu6050/archive/refs/heads/master.zip", ...
           "LicenseURL", "https://raw.githubusercontent.com/ElectronicCats/mpu6050/master/LICENSE")];

matlab.addons.toolbox.packageToolbox(opts)
end