/*
Adafruit Arduino - Lesson 3. RGB LED
*/

int redPin = 11;
int greenPin = 10;
int bluePin = 9;
int answer = 0;
byte buf[100];

unsigned long previousMillis = 0;
const long interval = 1000;
int ledState = LOW;

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
  if(Serial.available()>0)   //if there is data to read
  {
    Serial.readBytes(buf,50);
    sscanf(buf,"%f",answer);
    Serial.print(answer);
    if(answer == "1.1"){       //enter 1 having red light
      setColor(255,0,0);
    }
    if(answer == '2'){      //enter 2 having blue light
      setColor(0,0,225);
    }
    if(answer == '3'){      //enter 3 having green light
      setColor(0,225,0);
    }
    if(answer == '0'){      //enter 0 turning off the light 
      off();
    }
    
//    //frequency 
//    else{
//      unsigned long currentMillis = millis();
//       if (currentMillis - previousMillis >= interval) {
//    // save the last time you blinked the LED
//    previousMillis = currentMillis;
//    // if the LED is off turn it on and vice-versa:
//    if (ledState == LOW) {
//      ledState = HIGH;
//    } else {
//      ledState = LOW;
//    }
//    // set the LED with the ledState of the variable:
//    setColor(255,0,0);
//    }
//    }
    
  }
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
