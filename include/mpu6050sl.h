#ifndef MPU6050SL_H_
#define MPU6050SL_H_

#if !( defined(MATLAB_MEX_FILE) || defined(RSIM_PARAMETER_LOADING) ||  defined(RSIM_WITH_SL_SOLVER))

#include "rtwtypes.h"

#ifdef __cplusplus
extern "C" {
#endif


void stepFunctionMpu6050(float* axf, float* ayf, float* azf, float* gxf, float* gyf, float* gzf);
void setupFunctionMpu6050();

#ifdef __cplusplus
}
#endif

#else
#define stepFunctionMpu6050(float* , float*, float*) (0)
#define setupFunctionMpu6050() (0)
#endif
#endif