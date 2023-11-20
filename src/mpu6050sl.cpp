#include "mpu6050sl.h"

#include "I2Cdev.h"
#include "MPU6050.h"

MPU6050* mpu6050;

// Arduino Wire library is required if I2Cdev I2CDEV_ARDUINO_WIRE implementation
// is used in I2Cdev.h
#if I2CDEV_IMPLEMENTATION == I2CDEV_ARDUINO_WIRE
    #include "Wire.h"
#endif

// Range uint8 [1,1] Tunable
// IsHighAddress logical [1,1] Non tunable

void stepFunctionMpu6050(float* axf, float* ayf, float* azf, float* gxf, float* gyf, float* gzf){
    int16_t ax, ay, az;
    int16_t gx, gy, gz;
    mpu6050->getMotion6(&ax, &ay, &az, &gx, &gy, &gz);

    *axf = ((float)ax) / 16384 * 9.80665;
    *ayf = ((float)ay) / 16384 * 9.80665;
    *azf = ((float)az) / 16384 * 9.80665;

    // *axf = ax;
    // *ayf = ay;
    // *azf = az;


    *gxf = gx;
    *gyf = gy;
    *gzf = gz;


}

// x single [1,1]
// y single [1,1]
// z single [1,1]


void setupFunctionMpu6050(){

    // join I2C bus (I2Cdev library doesn't do this automatically)
    #if I2CDEV_IMPLEMENTATION == I2CDEV_ARDUINO_WIRE
        Wire.begin();
    #elif I2CDEV_IMPLEMENTATION == I2CDEV_BUILTIN_FASTWIRE
        Fastwire::setup(400, true);
    #endif

    mpu6050 = new MPU6050();
    mpu6050->initialize();
}