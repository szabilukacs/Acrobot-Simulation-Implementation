
// Servo Motor Driver
// Serial Communication Reciever

#include <Servo.h>

// Servo Motor Object
Servo servo_1;

int servo_pin = 5; // PWM pin for servo control
int pos = 90;    // servo starting position

volatile float u = 0.0;

void setup() {
  Serial.begin (9600);

  // Servo
  servo_1.attach(servo_pin); // start servo control
  servo_1.write(pos);  // 0 - 180, start at 90 degree

}


void loop() {

  if (Serial.available() >= sizeof(float))
  {
    // Read the q2 postiton for the servo
    Serial.readBytes((byte*)&u, sizeof(float));
  }

  servo_1.write(u + 90 - 5); // Send pwm signal for the servo (-5 compensation)

}
