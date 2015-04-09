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
byte ip[] = { 192,168,1,139 };
byte server[] = { 67, 63, 55, 3 }; // Google

// Initialize the Ethernet client library
// with the IP address and port of the server 
// that you want to connect to (port 80 is default for HTTP):
Client client(server, 80);

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
    // Make a HTTP request:
    client.println("HELO 7329836241@txt.att.net");
    delay(1000);
    client.println("MAIL From: <cbbyrnes4@gmail.com>");
    delay(1000);
    client.println("RCPT To: <7329836241@txt.att.net>");
    delay(1000);
    client.println("DATA");
    delay(1000);
    client.println("To: 732986241@txt.att.net");
    delay(1000);
    client.println("Subject: Intruder Alert!");
    delay(1000);
    client.println("QUIT");
    delay(1000);
    client.println(".");
    delay(1000);
    client.println();
  } 
  else {
    // kf you didn't get a connection to the server:
    Serial.println("connection failed");
  }
}

void loop()
{
      ;
}

