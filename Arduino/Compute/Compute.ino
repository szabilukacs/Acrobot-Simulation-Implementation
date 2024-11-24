

// Compute the control signal for the servo
// and send it to tha next Arduino
// Serial Communication Sender

#include <Wire.h>
#include <SoftwareSerial.h>
// #include <math.h>  // acrtanhoz

// Serial Communication
#define RX_PIN 2
#define TX_PIN 3

// using softserial for leaving free the
// hardware serial port for communication with laptop
SoftwareSerial swSerial(RX_PIN, TX_PIN);

// union type for storing 2 float from the sender
union floatToBytes {

  char buffer[8];
  float q1[2];

} converter;

// union type for storing 1 float for the reciever
union floatToBytesSend {

  char buffer[4];
  float uv;

} converter2;

// MLP LQR weights, parameters
const float Iw = 0.0666;
// Iw2 = 0;
const float b1 = -0.5576;
const float b2 = -10.0620;
const float Lw = -19.9388;
const float I_xmin = -24.7058;
const float I_gain = 0.0353;
const int I_ymin = - 1;
const int O_ymin = - 1;
const float O_gain = 77.6853;
const float O_xmin = -90.0623;


// MLP swing up weights, parameters
const float sw_Iw1 = 0.0253;
const float sw_Iw2 = 0.0108;
const float sw_b1 = -0.0087;
const float sw_b2 = -0.0015;
const float sw_Lw = 0.9572;
const float sw_I_xmin = -359.9704;
const float sw_I_gain = 0.0037;
const int sw_I_ymin = - 1;
const int sw_O_ymin = - 1;
const float sw_O_gain = 52.8646;
const float sw_O_xmin = -52.8691;


volatile float v = 0.0;
volatile float xq1 = 0.0;



volatile float u = 0.0; // temporary control signal
volatile float uv = 0.0; // control signal to send

//volatile int servo_cnt = 0;

volatile float q1 = 0;
volatile float dq1 = 0;


void setup() {
  Serial.begin (9600);

  // Start the I2C Bus as Slave on address 9
  Wire.begin(9);
  // Attach a function to trigger when something is received.
  Wire.onReceive(receiveEvent);
  swSerial.begin(9600);

}

// recieve event for reading 8 byte
void receiveEvent(int bytes) {

  uint8_t index = 0;

  while (Wire.available()) {
    converter.buffer[index] = Wire.read();
    index++;
    if (index == 8)
      index = 0;
  }

}

void loop() {

  q1 = converter.q1[0];  // q1 angle
  dq1 = converter.q1[1]; // dq1 angle velocity

  // Simplied switch logic
  // Blanacing
  if ((q1 > 170) && (q1 < 190))
  {
    uv = MLP_DLQR(q1 - 180);

    // kicsi rezgesek miatt
    /*
      if ((uv < 0) && (uv > -5))
      uv = 0;
      if ((uv > 0) && (uv < 5))
      uv = 0;
    */

  }

  else
    // Swing up
  {
    // arctannal proba
    // uv = ((2*90)/3.14)*57.29*atan(dq1*0.017453); // 2*90 
    // uv = uv*57.29;

    uv = MLP_swing_up(q1, dq1);
  }


  // limiting the servo, including the compensation
  if (uv > 90)
    uv = 90;
  if (uv < -85)
    uv = -85;

  // teszt
  // uv = 0;

  // Send data to the third Arduino over software serial
  swSerial.write((byte*)&uv, sizeof(float));

  byte* byteData = (byte*)&uv; //Convert the float number to a byte array

  delay(5);

  // Write to the serial port for measuring
  Serial.print(q1);
  Serial.print(',');
  Serial.print(dq1);
  Serial.print(',');
  Serial.println(uv);

}


// implementation of the pretrained neural network
// Swing up
float MLP_swing_up(float q1, float dq1)
{
  // preprocess q1
  xq1 = ((q1 - sw_I_xmin) * sw_I_gain) + sw_I_ymin;
  // Input layer
  v = (sw_Iw1 * xq1 + sw_Iw2 * dq1) + sw_b1;
  u = 2 / (1 + exp(-2 * v)) - 1;

  // Hidden layer
  v = (sw_Lw * u) + sw_b2;
  // purelin activation function

  // Process output
  uv = v + 1; // O_min
  uv = uv * sw_O_gain;
  uv = uv + sw_O_xmin;

  return uv;

}

float MLP_DLQR(float q1)
{
  // preprocess
  xq1 = ((q1 - I_xmin) * I_gain) + I_ymin;
  // Input layer
  v = (Iw * xq1) + b1; // inger Iw2 = 0
  u = 2 / (1 + exp(-2 * v)) - 1;

  // Hidden layer
  v = (Lw * u) + b2;
  // purelin activation function

  // Process output
  uv = v + 1; // O_min
  uv = uv * O_gain;
  uv = uv + O_xmin;

  return uv;

}
