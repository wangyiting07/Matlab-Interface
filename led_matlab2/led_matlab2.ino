/*
Adafruit Arduino - Lesson 3. RGB LED
*/

int redPin = 11;
int greenPin = 10;
int bluePin = 9;
String answer;

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
    answer = Serial.readString();
    while(answer.charAt(0) == '1'){       //enter 1 having red light
      setColor(255,0,0);
      delay(1000);
      flag = Serial.read();
      if(flag != 1){
        answer = flag;
        break;
      }
    }
    while(answer == '2'){      //enter 2 having blue light
      setColor(0,0,225);
      delay(1000);
      flag = Serial.read();
      if(flag != 2){
        answer = flag;
        break;
      }
    }
    while(answer == '3'){      //enter 3 having green light
      setColor(0,225,0);
      delay(1000);
      flag = Serial.read();
      if(flag != 3){
        answer = flag;
        break;
      }
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
