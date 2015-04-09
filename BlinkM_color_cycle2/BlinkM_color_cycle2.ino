#include <Wire.h>

int red, green, blue = 0; 
float freq = 0.5;

void setup() { 
  Serial.begin(9600);  
  Wire.begin(); // set up I2C
  //Wire.beginTransmission(0x09);
}

// the loop routine runs over and over again forever:
void loop() {
  //Wire.beginTransmission(0x09);
  for (int i = 0; i < 32; ++i){
    red   = (int) constrain(sin(freq * i + 0) * 127 + 128, 0, 255);
    green = (int) constrain(sin(freq * i + 2) * 127 + 128, 0, 255);
    blue  = (int) constrain(sin(freq * i + 4) * 127 + 128, 0, 255);
    Wire.beginTransmission(0x09);// join I2C, talk to BlinkM 0x09
    Wire.write('n'); //
    Wire.write(red);
    delay(25);
    Wire.write(green);
    delay(25);
    Wire.write(blue);
    delay(25);
    Wire.write(blue);
    delay(25);
    Wire.write(green);
    delay(25);
    Wire.write(red);
    delay(25);
    Wire.endTransmission(); // leave I2C bus
    delay(25);
  }
  //Wire.endTransmission();
}

