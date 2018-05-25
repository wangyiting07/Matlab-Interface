void setup() {
  // put your setup code here, to run once:
  pinMode(9, OUTPUT);
  //pinMode(10, OUTPUT);
  TCCR1A = _BV(COM1A0); // To 
  TCCR1B = _BV(CS12) | _BV(CS10) | _BV(WGM12);
  OCR1A = 15625;
  //OCR1B = 0XBFFF;
}

void loop() {
  // put your main code here, to run repeatedly:
//  delay(1000);
  //TCCR1A = _BV(COM2A1) | _BV(COM2B0) | _BV(WGM21) | _BV(WGM20);
//  digitalWrite(9,HIGH);
//  delay(1000);
//  digitalWrite(9,LOW);
}
