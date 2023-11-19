/* Copyright 2023 The MathWorks, Inc. */
#ifndef ADXL357SL_H
#define ADXL357SL_H

#include "ADXL357.h"

#if !( defined(MATLAB_MEX_FILE) || defined(RSIM_PARAMETER_LOADING) ||  defined(RSIM_WITH_SL_SOLVER))

#include "rtwtypes.h"

ADXL357* adxl357 = nullptr;

extern "C" void stepFunctionadxl357(float * x,int size_vector_1,float * y,int size_vector_2,float * z,int size_vector_3, uint8_T * Range,int size_vector__1);
extern "C" void setupFunctionadxl357(uint8_T * Range,int size_vector__1,boolean_T  IsHighAddress,int size_vector__2);



#else
#define loop(void) (0)
#define setup(void) (0)
#endif
#endif