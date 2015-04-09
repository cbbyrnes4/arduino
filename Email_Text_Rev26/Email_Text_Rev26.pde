#include <TextFinder.h>
#include <SPI.h>
#include <Ethernet.h>

byte mac[] = { 0x90, 0xA2, 0xDA, 0x00, 0x56, 0x79 };
byte ip[] = { 192, 168, 1, 141 };                       //cannot use same IP as other computer on network
byte server[] = { 74, 125, 93, 109 };                   // smtp.gmail.com

//make two final programs: one with SERIAL commands and the other without
//make commands to send out commands to ehternet if and only if there is the correct response
//try to use DHCP and DNS to ease authentification
//use UDP to accept incoming strings and act upon them

Client     client  (server, 587);
TextFinder finder  (client);

String readString  = String(100);
String stringOne   = 'ESMTP';
String stringTwo   = '250 ENHANCEDSTATUSCODES';
String stringThree = '220 2.0.0 Ready to start TLS';

void setup() 
{
  Ethernet.begin(mac, ip);
  Serial.begin(9600);
  delay(1000);
  Serial.println("connecting...");
  if (client.connect()) 
  {
    Serial.println("connected");
    client.flush();
    loop();
  } 
  else 
  {
    Serial.println("connection failed");
  }
  
  if (client.connected())
  {
     loop();
     Serial.println("EHLO"); client.println("EHLO gmail.com");
     loop();
     Serial.println("STARTTLS"); client.println("STARTTLS");
     loop();
//     if (readString == 'Ready to start TLS') 
//     {
//       Serial.println(""); client.println("");
//       loop();
//     } 
//     loop();
  }
    
  if (!client.connected()) 
  {
    Serial.println();
    Serial.println("disconnecting.");
    client.stop();
    delay(3000);
    setup();
  }
}

void loop() 
{
  printer();
}

void printer()
{
  if (client.available())
  { 
    char c = client.read();
    readString += c;
    Serial.print(c);
//    delay (50);
    return;
  }
}
//{
//  int totalBytes=0;
//  unsigned long startTime = millis();
//
//  while ((!client.available()) && ((millis() - startTime ) < 5000));
//
//  while (client.available()) 
//  {
//    char c = client.read();
////    delay(50);
//    totalBytes+=1;
//  }
//  return totalBytes;
//}          

  
  


