#include <SPI.h>
#include <Ethernet.h>

byte mac[]     = { 0x90, 0xA2, 0xDA, 0x00, 0x56, 0x79 };
byte ip[]      = { 192, 168, 1, 141 };                  //cannot use same IP as other computer on network
byte server[]  = { 167, 206, 5, 250 };
byte gateway[] = { 192, 168, 1, 1 };
byte subnet[]  = { 255, 255, 255, 0};

//make two final programs: one with SERIAL commands and the other without
//try to use DHCP and DNS

Client client (server, 25);
boolean MessageSent = false;

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
    Serial.println("C: EHLO cbbyrnes4@gmail.com"); 
    client.println("EHLO cbbyrnes4@gmail.com");
    loop();
    Serial.println("C: MAIL FROM ");
    client.println("MAIL FROM: cbbyrnes4@gmail.com");
    loop();
    Serial.println("C: RCPT TO"); 
    client.println("RCPT TO: 7329836241@txt.att.net");
    loop();
    Serial.println("C: DATA");
    client.println("DATA");
    loop();
    Serial.println("C: From: <cbbyrnes4@gmail.com>");
    client.println("From: <cbbyrnes4@gmail.com>");
    Serial.println("C: To: <7329836241@txt.att.net>");
    client.println("To: <7329836241@txt.att.net>");
    Serial.println("C: Subject: Intruder Alert!");
    client.println("Subject: Intruder Alert!");
    Serial.println();
    client.println();
    Serial.println("C: Hello Chaz,");
    client.println("Hello Chaz,");
    Serial.println("C: INTRUDER ALERT!!");
    client.println("INTRUDER ALERT!!");
    Serial.println("C: .");
    client.println(".");
    Serial.println("QUIT");
    client.println("QUIT");
    loop();
    MessageSent = true;
    delay(2000);
  }
  
  if (!client.available() && (MessageSent = true))
  {
    Serial.println("disconnecting.");
    client.flush();
    client.stop();
  }

  if (!client.connected() && (MessageSent = false))
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
    delay(10);
    Serial.print(c);
  }
  return;
}



