#include <Wire.h>


void setup() {                
  Wire.begin(); // set up I2C
}

// the loop routine runs over and over again forever:
void loop() {
  Wire.beginTransmission(0x09);// join I2C, talk to BlinkM 0x09
  Wire.write('n'); //
  Wire.write(0x66); // value for red channel
  Wire.write(0xff); // value for green channel
  Wire.write(0x33); // value for blue channel
  Wire.endTransmission(); // leave I2C bus              // wait for a second
}

