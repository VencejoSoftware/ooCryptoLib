{
  Copyright (c) 2021, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
program CryptDemo;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  SysUtils,
  KeyCipher,
  CryptLib in '..\..\code\CryptLib.pas';

var
  Cipher: IKeyCipher;

procedure DemoCrypt;
const
  KEY = '441CB2B3-CA75-4545-A4E3-195718ED822A';
var
  Encrypted: String;
begin
  WriteLn(BoolToStr(Cipher.IsValidKey(KEY), True));
  Cipher.ChangeKey(KEY);
  WriteLn(BoolToStr(Cipher.IsValidKey(KEY), True));
  Encrypted := Cipher.Encode('test@1234.com');
  WriteLn(Format('%s >> encrypted >> %s', ['test@1234.com', Encrypted]));
  WriteLn(Format('%s << decrypted << %s', [Encrypted, Cipher.Decode(Encrypted)]));
end;

begin
{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := (DebugHook <> 0);
{$WARN SYMBOL_PLATFORM ON}
  try
    Cipher := TCryptLib.New('..\..\..\..\dll\build\Win64\Debug\CryptLib.dll');
    DemoCrypt;
    WriteLn('Press any key to exit');
    ReadLn;
  except
    on E: Exception do
      WriteLn(E.ClassName, ': ', E.Message);
  end;

end.
