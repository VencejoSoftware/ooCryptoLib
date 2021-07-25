{
  Copyright (c) 2021, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
library CryptLib;

uses
  SimpleShareMem,
  SysUtils,
  Version,
  VersionStage,
  VersionFormat,
  WinCrypt in '..\..\code\WinCrypt.pas';

{$R *.res}

var
  CryptKey: WideString;

function Version: IVersion; stdcall;
begin
  Result := TVersion.New(1, 0, 0, 0, TVersionStage.New(TVersionStageCode.Productive), EncodeDate(2021, 07, 23));
end;

function Encode(const Text: WideString): WideString; stdcall; export;
begin
  Result := WideString(WinCryptEncodeString(AnsiString(Text), AnsiString(CryptKey)));
end;

function Decode(const Text: WideString): WideString; stdcall; export;
begin
  Result := WideString(WinCryptDecodeString(AnsiString(Text), AnsiString(CryptKey)));
end;

function IsValidKey(const CryptKeyToValidate: WideString): Boolean; stdcall; export;
begin
  Result := CryptKeyToValidate = CryptKey;
end;

procedure ChangeKey(const NewCryptKey: WideString); stdcall; export;
begin
  CryptKey := NewCryptKey;
end;

exports
  Version,
  Encode,
  Decode,
  ChangeKey,
  IsValidKey;

begin
  CryptKey := 'C785AFDD-41DC-48BB-8BAD-74F5161677B5';
  IsMultiThread := True;

end.
