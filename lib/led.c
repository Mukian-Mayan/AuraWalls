#include <LiquidCrystal.h>
LiquidCrystal lcd( 12, 11, 5, 4, 3, 2);

void setup ( ){
    lcd.begin (16,2)
    lcd.print("hello world");

}


void loop (){}






















/*int led = 13;

void setup(){
    pinMode(led, OUTPUT)
}

void loop (){
    digitalWrite(led, HIGH);
    delay(1000);
    digitalWrite(led, LOW);
    delay(1000);
}
*/

