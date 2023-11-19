#include "adxl357.h"

// Range uint8 [1,1] Tunable
// IsHighAddress logical [1,1] Non tunable

void setupFunctionadxl357(uint8_T * Range,int size_vector__1,boolean_T  IsHighAddress,int size_vector__2){

    adxl357 = new ADXL357(static_cast<bool>(IsHighAddress));

    adxl357->setRange(static_cast<adxl357_range_t>(Range));

    adxl357->begin();

}

// x single [1,1]
// y single [1,1]
// z single [1,1]


void stepFunctionadxl357(float * x,int size_vector_1,float * y,int size_vector_2,float * z,int size_vector_3, uint8_T * Range,int size_vector__1){
    int32_t xd, yd, zd;

    adxl357->getXYZ(xd, yd, zd);

    float scale;
    switch (static_cast<adxl357_range_t>(*Range))
    {
    case Range_40_G:
        scale = ADXL357_SCL_40G;
        break;
    case Range_20_G:
        scale = ADXL357_SCL_20G;
        break;
    case Range_10_G:
        scale = ADXL357_SCL_10G;
        break;
    
    default:
        scale = 0;
        break;
    }

    *x = xd * scale;
    *y = yd * scale;
    *z = zd * scale;
}