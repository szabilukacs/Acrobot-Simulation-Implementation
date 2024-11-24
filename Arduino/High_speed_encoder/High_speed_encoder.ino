

// Processing signals from rotary encoder
#include <Wire.h>

//This variable will increase or decrease depending on the rotation of encoder
volatile int temp, counter = 0;

volatile int vel_cnt = 0;
volatile int vel_cnt_old = 0;
volatile float ENC_angle = 0.0;
volatile float ENC_vel = 0.0;


// Encoder ----- Ez jo -------
// Master - ez kuldje az u jelet is

// union type to store 2 float
union floatToBytes {

  char buffer[8];
  float q1[2];

} converter;

void setup() {

  Serial.begin (9600);

  pinMode(2, INPUT_PULLUP); // internal pullup input pin 2

  pinMode(3, INPUT_PULLUP); // internal pullup input pin 3

  //Setting up interrupt
  //A falling pulse from encodenren activated ai0(). AttachInterrupt 0 is DigitalPin nr 2 on moust Arduino.
  attachInterrupt(digitalPinToInterrupt(2), ai0, FALLING);

  //B falling pulse from encodenren activated ai1(). AttachInterrupt 1 is DigitalPin nr 3 on moust Arduino.
  attachInterrupt(digitalPinToInterrupt(3), ai1, FALLING);

  // Timer
  cli();//stop interrupts

  //set timer1 interrupt at 1Hz
  TCCR1A = 0;// set entire TCCR1A register to 0
  TCCR1B = 0;// same for TCCR1B
  TCNT1  = 0;//initialize counter value to 0
  // set compare match register for 1hz increments
  OCR1A = 311;// = (16*10^6) / (1*1024) - 1 (must be <65536) // 311 -> 50Hzes frekvencia // 624 -> 25Hz
  // turn on CTC mode
  TCCR1B |= (1 << WGM12);
  // Set CS10 and CS12 bits for 1024 prescaler
  TCCR1B |= (1 << CS12) | (1 << CS10);
  // enable timer compare interrupt
  TIMSK1 |= (1 << OCIE1A);

  sei();//allow interrupts

  // Start the I2C Bus as Master
  Wire.begin();


}

void loop() {

  Wire.beginTransmission(9); // transmit to device #9
  Wire.write(converter.buffer, 8);   // sends angle and velocity
  Wire.endTransmission();    // stop transmitting

}

void ai0() {
  // ai0 is activated if DigitalPin nr 2 is going from HIGH to LOW
  // Check pin 3 to determine the direction

  vel_cnt++;
  if (PIND & B00001000)
  {
    counter--;
  }
  else
  {
    counter++;
  }
}

void ai1() {
  // ai0 is activated if DigitalPin nr 3 is going from HIGH to LOW
  vel_cnt++;
  if (PIND & B00000100)
  {
    counter++;
  }
  else
  {
    counter--;
  }
}

// timer 0 - for velocity

ISR(TIMER1_COMPA_vect)
{
  vel_cnt = counter - vel_cnt_old;

  ENC_angle = 0.3 * counter; //  0.3 = 360/1200 - degree

  ENC_vel = (2 * 3.14 * vel_cnt) / (1200 * 0.02);  // | 0.02 -> 50Hz

  ENC_vel = ENC_vel * 57.29; // rad/sec to degree/sec

  vel_cnt_old = counter;

  // reset the angle
  if (ENC_angle > 360)
    counter = 0;
  if (ENC_angle < -360)
    counter = 0;

  // Send the value of counter
  converter.q1[0] = ENC_angle;
  converter.q1[1] = ENC_vel;

}
