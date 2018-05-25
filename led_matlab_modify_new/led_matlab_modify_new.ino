/*
  Two led reflecting two people
  Leds can be controlled and follow people's haeart rate.
*/

int redPin = 11;
int greenPin = 10;
int bluePin = 9;
int redPin2 = 6;
int greenPin2 = 5;
int bluePin2 = 3;
String answer;
unsigned long previousMillis = 0;
char flag = '0';
int ledstate = 0;
float interval = 0.1;
int follow1 = 0;
int follow2 = 0;


unsigned long previousMillis_2 = 0;
char flag_2 = '0';
int ledstate_2 = 0;
float interval_2 = 0.1;

void setup()
{
  pinMode(redPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  pinMode(bluePin, OUTPUT);
  pinMode(redPin2, OUTPUT);
  pinMode(greenPin2, OUTPUT);
  pinMode(bluePin2, OUTPUT);
  Serial.begin(9600);
  Serial.setTimeout(10);
}


void loop()
{
  if (Serial.available() > 0) //if there is data to read
  {
    answer = Serial.readString();
    
    if (answer.charAt(0) == '5') {
      follow1 = 1;
      if (answer.charAt(1) == '1') {
        digitalWrite(bluePin,HIGH);
        delay(50);
        digitalWrite(bluePin,LOW);
      } else {
        digitalWrite(bluePin,LOW);
      }
    } else {
      follow1 = 0;
      change_fre(answer);
      change_color(answer);
    }

     if (answer.charAt(4) == '5') {
      follow2 = 1;
       if (answer.charAt(5) == '1') {
        digitalWrite(bluePin2,HIGH);
        delay(50);
        digitalWrite(bluePin2,LOW);
       } else {
        digitalWrite(bluePin2,LOW);
      }
    } else {
      follow2 = 0;
      change_fre_2(answer);
      change_color_2(answer);
    }

    
  }
  unsigned long currentMillis = millis();
  if (follow1 == 0) {
    //unsigned long currentMillis = millis();
    if (currentMillis - previousMillis >= interval) {
      // save the last time you blinked the LED
      previousMillis = currentMillis;
      // if the LED is off turn it on and vice-versa:
      if (ledstate == 0) {
        ledstate = 1;
        light(flag);
      } else {
        ledstate = 0;
        off();
      }
    }
  }
  
  if (follow2 == 0) {
    //unsigned long currentMillis_2 = millis();
    if (currentMillis - previousMillis_2 >= interval_2) {
      // save the last time you blinked the LED
      previousMillis_2 = currentMillis;
      // if the LED is off turn it on and vice-versa:
      if (ledstate_2 == 0) {
        ledstate_2 = 1;
        light_2(flag_2);
      } else {
        ledstate_2 = 0;
        off_2();
      }
    }
  }
}

void change_color(String s) {
  if (s.charAt(0) == '1') {     //enter 1 having red light
    flag = '1';
    ledstate = 1;
  }
  if (s.charAt(0) == '2') {    //enter 2 having blue light
    flag = '2';
    ledstate = 1;
  }
  if (s.charAt(0) == '3') {    //enter 3 having green light
    flag = '3';
    ledstate = 1;
  }

  if (s.charAt(0) == '0') {    //enter 0 turning off the light
    off();
    ledstate = 0;
  }
}

void change_color_2(String s) {
  if (s.charAt(4) == '1') {     //enter 1 having red light
    flag_2 = '1';
    ledstate_2 = 1;
  }
  if (s.charAt(4) == '2') {    //enter 2 having blue light
    flag_2 = '2';
    ledstate_2 = 1;
  }
  if (s.charAt(4) == '3') {    //enter 3 having green light
    flag_2 = '3';
    ledstate_2 = 1;
  }

  if (s.charAt(4) == '0') {    //enter 0 turning off the light
    off();
    ledstate_2 = 0;
  }
}

void change_fre(String s) {
  if (s.charAt(2) == 'a') {
    interval = 0.1;
  }

  if (s.charAt(2) == 'b') {
    interval = 200;
  }

  if (s.charAt(2) == 'c') {
    interval = 100;
  }

  if (s.charAt(2) == 'd') {
    interval = 1000 / 15;
  }

  if (s.charAt(2) == 'e') {
    interval = 1000 / 20;
  }

}

void change_fre_2(String s) {
  if (s.charAt(6) == 'a') {
    interval_2 = 0.1;
  }

  if (s.charAt(6) == 'b') {
    interval_2 = 200;
  }

  if (s.charAt(6) == 'c') {
    interval_2 = 100;
  }

  if (s.charAt(6) == 'd') {
    interval_2 = 1000 / 15;
  }

  if (s.charAt(6) == 'e') {
    interval_2 = 1000 / 20;
  }
}
void light(char c)
{
  if (c == '1') setColor(1, 0, 0);
  if (c == '2') setColor(0, 0, 1);
  if (c == '3') setColor(0, 1, 0);
  if (c == '0') setColor(0, 0, 0);
}

void setColor(int red, int green, int blue)
{
  digitalWrite(redPin, red);
  digitalWrite(greenPin, green);
  digitalWrite(bluePin, blue);
}

void off()
{
  digitalWrite(redPin, 0);
  digitalWrite(greenPin, 0);
  digitalWrite(bluePin, 0);
}

void light_2(char c)
{
  if (c == '1') setColor_2(1, 0, 0);
  if (c == '2') setColor_2(0, 0, 1);
  if (c == '3') setColor_2(0, 1, 0);
  if (c == '0') setColor(0, 0, 0);
}

void setColor_2(int red, int green, int blue)
{
  digitalWrite(redPin2, red);
  digitalWrite(greenPin2, green);
  digitalWrite(bluePin2, blue);
}

void off_2()
{
  digitalWrite(redPin2, 0);
  digitalWrite(greenPin2, 0);
  digitalWrite(bluePin2, 0);
}
