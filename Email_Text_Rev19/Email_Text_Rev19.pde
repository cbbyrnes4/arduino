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

Client     client (server, 587);
TextFinder finder (client); 

void setup() 
{
  Ethernet.begin(mac, ip);
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
 String string = "";
 if (client.connected())
 {
   if (client.available())
   {
      int byteAvailable = client.available();
      for (int i = 0; i < byteAvailable; i++)
      {
        string[i] = client.read();
        Serial.print(string);
        delay(50);
        if (string.substring(i) == 'ESTMP')
        {
          Serial.print(string[i]);
          EHLO();
        }
//        else if (finder.find("ENHANCEDSTATUSCODES"))
//        {
//          Serial.print(string[i]);
//          STARTTLS();
//        }
//        else if (string[i] == 'S')
//        find 250 ENHANCEDSTATUSCODES using some method
//        {
//          Serial.print(string[i]);
//          STARTTLS();
//        }
      }
    }
  }
}
void EHLO()
{
 Serial.print("EHLO");client.println("EHLO cbbyrnes4@gmail.com");
}

void STARTTLS()
{
 Serial.print("STARTTLS");client.println("STARTTLS");
}
