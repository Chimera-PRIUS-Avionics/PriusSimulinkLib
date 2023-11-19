#ifndef MPU6050SL_H_
#define MPU6050SL_H_

#if !( defined(MATLAB_MEX_FILE) || defined(RSIM_PARAMETER_LOADING) ||  defined(RSIM_WITH_SL_SOLVER))

#include "I2Cdev.h"
#include "MPU6050.h"

#include "rtwtypes.h"

MPU6050* mpu6050;

extern "C" void stepFunctionMpu6050(float* axf, float* ayf, float* azf, float* gxf, float* gyf, float* gzf);
extern "C" void setupFunctionMpu6050();

#else
#define stepFunctionMpu6050(float* , float*, float*) (0)
#define setupFunctionMpu6050() (0)
#endif
#endif