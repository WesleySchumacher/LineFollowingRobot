#include <QTRSensors.h>
#include <A4990MotorShield.h>

#define LED_PIN 13

A4990MotorShield motors;

// This code is developed by Wesley Schumacher CU Boulder BS 21'
// E: wesc@colorado.edu C: 720-550-9819
// The code interfaces with Polulos QTR-8RC sensor Array as well as
// Polulos A4990 Motor Driver Shield. A PID controler is feed the 
// QTR Sensor array and the PID outputs motor comands to the Motor 
// Driver keeping the robot on the black electrical tape
//
//
// This example is designed for use with eight RC QTR sensors. These
// reflectance sensors should be connected to digital pins 36 to 50. The
// sensors' emitter control pin (CTRL or LEDON) can optionally be connected to
// digital pin 2, or you can leave it disconnected and remove the call to
// setEmitterPin().
//
// The setup phase of this example calibrates the sensors for ten seconds and
// turns on the Arduino's LED (usually on pin 13) while calibration is going
// on. During this phase, you should expose each reflectance sensor to the
// lightest and darkest readings they will encounter. For example, if you are
// making a line follower, you should slide the sensors across the line during
// the calibration phase so that each sensor can get a reading of how dark the
// line is and how light the ground is.  Improper calibration will result in
// poor readings.
//
// The main loop of the example reads the calibrated sensor values and uses
// them to estimate the position of a line. You can test this by taping a piece
// of 3/4" black electrical tape to a piece of white paper and sliding the
// sensor across it. It prints the sensor values to the serial monitor as
// numbers from 0 (maximum reflectance) to 1000 (minimum reflectance) followed
// by the estimated location of the line as a number from 0 to 5000. 1000 means
// the line is directly under sensor 1, 2000 means directly under sensor 2,
// etc. 0 means the line is directly under sensor 0 or was last seen by sensor
// 0 before being lost. 5000 means the line is directly under sensor 5 or was
// last seen by sensor 5 before being lost.
// The main loop also containes the PID controler variables and the 
// Motor Driver comands. As well as motor protection if statments. 

QTRSensors qtr;

const uint8_t SensorCount = 8;
uint16_t sensorValues[SensorCount];

int error = 0;
float Kp = 0; //set up the constants value
float Ki = 0;
float Kd = 0;
int P;
int I;
int D;
int lasterror = 0;

//Increasing the maxspeed can damage the motors - at a value of 255 the 6V motors will receive 7,4 V
const uint8_t maxspeeda = 210;
const uint8_t maxspeedb = maxspeeda;
const uint8_t basespeeda = 140;
const uint8_t basespeedb = basespeeda;
  void stopIfFault()
{
  if (motors.getFault())
  {
    motors.setSpeeds(0,0);
    Serial.println("Fault");
    while(1);
  }
}

void setup()
{

  Serial.begin(9600);
  // configure the sensors
  qtr.setTypeRC();
  qtr.setSensorPins((const uint8_t[]){36, 38, 40, 42, 44, 46, 48, 50}, SensorCount);
  //qtr.setEmitterPin(2);

  delay(500);
  pinMode(LED_BUILTIN, OUTPUT);
  digitalWrite(LED_BUILTIN, HIGH); // turn on Arduino's LED to indicate we are in calibration mode

  // 2.5 ms RC read timeout (default) * 10 reads per calibrate() call
  // = ~25 ms per calibrate() call.
  // Call calibrate() 400 times to make calibration take about 10 seconds.
  for (uint16_t i = 0; i < 400; i++)
  {
    qtr.calibrate();
  }
  digitalWrite(LED_BUILTIN, LOW); // turn off Arduino's LED to indicate we are through with calibration

  // print the calibration minimum values measured when emitters were on
  Serial.begin(9600);
  for (uint8_t i = 0; i < SensorCount; i++)
  {
    Serial.print(qtr.calibrationOn.minimum[i]);
    Serial.print(' ');
    Serial.print(' ');
  }
  Serial.println();

  // print the calibration maximum values measured when emitters were on
  for (uint8_t i = 0; i < SensorCount; i++)
  {
    Serial.print(qtr.calibrationOn.maximum[i]);
    Serial.print(' ');
  }
  Serial.println();
  Serial.println();
  

  // qtr.calibrationOn.minimum =
