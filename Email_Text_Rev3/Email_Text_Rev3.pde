/*
  Web client
 
 This sketch connects to a website (http://www.google.com)
 using an Arduino Wiznet Ethernet shield. 
 
 Circuit:
 * Ethernet shield attached to pins 10, 11, 12, 13
 
 created 18 Dec 2009
 by David A. Mellis
 
 */

#include <SPI.h>
#include <Ethernet.h>

// Enter a MAC address and IP address for your controller below.
// The IP address will be dependent on your local network:
byte mac[] = {  0x90, 0xA2, 0xDA, 0x00, 0x56, 0x79 };
byte ip[] = { 192, 168, 1, 139 };
byte server[] = { 74, 125, 93, 109 }; // Google

// Initialize the Ethernet client library
// with the IP address and port of the server 
// that you want to connect to (port 80 is default for HTTP):
Client client(server, 587);

void setup() {
  // start the Ethernet connection:
  Ethernet.begin(mac, ip);
  // start the serial library:
  Serial.begin(9600);
  // give the Ethernet shield a second to initialize:
  delay(1000);
  Serial.println("connecting...");

  // if you get a connection, report back via serial:
  if (client.connect()) {
    Serial.println("connected");
  } 
  else {
    // kf you didn't get a connection to the server:
    Serial.println("connection failed");
  }
}

void loop()
{
  // if there are incoming bytes available 
  // from the server, read them and print them:
  if (client.connected()) {
    client.println("HELO <smtp.gmail.com>");
    char z = client.read();
    Serial.println(z);
    delay(1000);
    client.println("STARTTLS");
    char x = client.read();
    Serial.println(x);
    delay(1000);
    client.println("AUTH PLAIN ZEdWemRBQjBaWE4wQUhSbGMzUndZWE56DQo=");
    char a = client.read();
    Serial.println(a);
    delay(1000);
    client.println("EMAIL From: <cbbyrnes4@gmail.com>");
    char b = client.read();
    Serial.println(b);
    delay(1000);
    client.println("EMAIL To: <7329836241@txt.att.net>");
    char c = client.read();
    Serial.println(c);
    delay(1000);
    client.println("DATA");
    char d = client.read();
    Serial.println(d);
    delay(1000);
    client.println("To: 732986241@txt.att.net");
    char e = client.read();
    Serial.println(e);
    delay(1000);
    client.println("Subject: Intruder Alert!");
    char f = client.read();
    Serial.println(f);
    delay(1000);
    client.println("QUIT");
    char g = client.read();
    Serial.println(g);
    delay(1000);
    client.println(".");
    char h = client.read();
    Serial.println(h);
    delay(1000);
    client.println();
    client.println();
  }
  // if the server's disconnected, stop the client:
  if (!client.connected()) {
    Serial.println();
    Serial.println("disconnecting.");
    client.stop();

    // do nothing forevermore:
    for(;;)
      ;
  }
}

