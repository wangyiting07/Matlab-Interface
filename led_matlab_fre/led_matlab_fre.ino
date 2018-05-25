/*
Adafruit Arduino - Lesson 3. RGB LED
*/

int redPin = 11;
int greenPin = 10;
int bluePin = 9;
String answer;
unsigned long previousMillis = 0;
char flag = '1';
int ledstate = 0;

//uncomment this line if using a Common Anode LED
//#define COMMON_ANODE

void setup()
{
  pinMode(redPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  pinMode(bluePin, OUTPUT); 
  Serial.begin(9600); 
}

void loop()
{
   //light(flag);
//  if(Serial.available()>0)   //if there is data to read
//  {
//    answer = Serial.readString();
//    if(answer.charAt(0) == '1'){       //enter 1 having red light
//      flag = '1';
//      //light(flag);
//      ledstate = 1;
//    }
//    if(answer.charAt(0) == '2'){      //enter 2 having blue light
//      flag = '2';
//      //light(flag);
//      ledstate = 1;
//    }
//    if(answer.charAt(0) == '3'){      //enter 3 having green light
//      flag = '3';
//      //light(flag);
//      ledstate = 1;
//    }
//    
//    if(answer.charAt(0) == '0'){      //enter 0 turning off the light 
//      off();
//      ledstate = 0;
//    } 
//   
    unsigned long currentMillis = millis();
  
      if (currentMillis - previousMillis >= interval) {
    // save the last time you blinked the LED
    previousMillis = currentMillis;

    // if the LED is off turn it on and vice-versa:
    if (ledstate == 0) {
      ledstate = 1;
      setColor(255,0,0);
    } else {
      ledstate = 0;
      off();
      }
     }
    
    
//    if(answer.charAt(2) == 'b'){
//       if (currentMillis - previousMillis >= 1000/5) {
//    // save the last time you blinked the LED
//    previousMillis = currentMillis;
//
//    // if the LED is off turn it on and vice-versa:
//    if (ledstate == 0) {
//      ledstate = 1;
//      light(flag);
//    } else {
//      ledstate = 0;
//      off();
//      }
//     }  
//    }
//    
//    if(answer.charAt(2) == 'c'){
//       if (currentMillis - previousMillis >= 1000/10) {
//    // save the last time you blinked the LED
//    previousMillis = currentMillis;
//
//    // if the LED is off turn it on and vice-versa:
//    if (ledstate == 0) {
//      ledstate = 1;
//      light(flag);
//    } else {
//      ledstate = 0;
//      off();
//      }
//     }
//    }
//    
//    if(answer.charAt(2) == 'd'){
//       if (currentMillis - previousMillis >= 1000/15) {
//    // save the last time you blinked the LED
//    previousMillis = currentMillis;
//
//    // if the LED is off turn it on and vice-versa:
//    if (ledstate == 0) {
//      ledstate = 1;
//      light(flag);
//    } else {
//      ledstate = 0;
//      off();
//      }
//     }
//    }
//    
//    if(answer.charAt(2) == 'e'){
//       if (currentMillis - previousMillis >= 1000/20) {
//    // save the last time you blinked the LED
//    previousMillis = currentMillis;
//
//    // if the LED is off turn it on and vice-versa:
//    if (ledstate == 0) {
//      ledstate = 1;
//      light(flag);
//    } else {
//      ledstate = 0;
//      off();
//      }
//     }
//    }
    
  
    
}


void light(char c)
{
  if(c == '1') setColor(255,0,0);
  if(c == '2') setColor(0,0,255);
  if(c == '3') setColor(0,255,0);
  if(c == '0') setColor(0,0,0);
}

void setColor(int red, int green, int blue)
{
  #ifdef COMMON_ANODE
//    red = 255 - red;
//    green = 255 - green;
//    blue = 255 - blue;
  #endif
  analogWrite(redPin, red);
  analogWrite(greenPin, green);
  analogWrite(bluePin, blue);  
}

void off()
{
  #ifdef COMMON_ANODE
//    red = 255 - red;
//    green = 255 - green;
//    blue = 255 - blue;
  #endif
  analogWrite(redPin, 0);
  analogWrite(greenPin, 0);
  analogWrite(bluePin, 0);  
}
