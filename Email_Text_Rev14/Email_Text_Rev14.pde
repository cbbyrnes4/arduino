
#include <SPI.h>
#include <Ethernet.h>

byte mac[] = { 0x90, 0xA2, 0xDA, 0x00, 0x56, 0x79 };
byte ip[] = { 192, 168, 1, 140 }; //cannot use same IP as other computer on network
byte server[] = { 74, 125, 93, 109 }; // smtp.gmail.com

//make two final programs: one with SERIAL commands and the other without

Client client(server, 587);

void setup() 
{
  Ethernet.begin(mac, ip);
  Serial.begin(9600);
  delay(1000);
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
    client.println("EHLO gmail.com");
    loop();
    client.println("STARTTLS");
    loop();
    client.println("EHLO @gmail.com");
    loop();
  }
  if (!client.connected()) 
  {
    Serial.println();
    Serial.println("disconnecting.");
    client.stop();
//    for (;;)
//      ;
    delay(3000);
    setup();
  }
}

void loop()
{
  char a = client.read();
  Serial.print(a);
  delay(100);
  return; 
}


