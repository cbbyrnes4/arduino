#include <SPI.h>
#include <Ethernet.h>

byte mac[] = { 0x90, 0xA2, 0xDA, 0x00, 0x56, 0x79 };
byte ip[] = { 192, 168, 1, 141 };   //cannot use same IP as other computer on network
//byte server[] = { 74, 125, 93, 109 };                   // smtp.gmail.com for port 587
byte server[] = { 74, 125, 115, 109 };
//byte server[] = { 66, 249, 93, 111 };                   // smtp.gmail.com for port 465
byte gateway[] = { 192, 168, 1, 1 };
byte subnet[]  = { 255, 255, 255, 0};

//make two final programs: one with SERIAL commands and the other without
//make commands to send out commands to ehternet if and only if there is the correct response
//try to use DHCP and DNS to ease authentification
//use UDP to accept incoming strings and act upon them
//fix library

Client client (server, 587);
//try port 587 also

void setup() 
{
  Ethernet.begin(mac, ip, gateway, subnet);
  Serial.begin(9600);
  delay(1000);
  Serial.println();
  Serial.println("connecting...");
  if (client.connect()) 
  {
    Serial.println("connected");
  }
  else 
  {
    Serial.println("connection failed");
  }
  
  if (client.connected())
  {
    loop();
    Serial.println("C: EHLO gmail.com"); 
    client.println("EHLO gmail.com");
    loop();
    Serial.println("C: STARTTLS");
    client.println("STARTTLS");
    loop();
    Serial.println("C: EHLO gmail.com"); 
    client.println("EHLO gmail.com");
    loop();
  }

  if (!client.connected()) 
  {
    Serial.println("disconnecting.");
    client.flush();
    client.stop();
    delay(3000);
    setup();
  }
}

void loop() 
{
  unsigned long startTime = millis();
  while ((!client.available()) && ((millis() - startTime ) < 5000));
  
  while (client.available()) 
  {
    char c = client.read();
    delay(25);
    Serial.print(c);
  }
  return;
}








