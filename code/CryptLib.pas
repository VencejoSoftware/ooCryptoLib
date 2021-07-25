{
  Copyright (c) 2021, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit CryptLib;

interface

uses
  LibraryCore,
  Version,
  Cipher, KeyCipher;

type
  ICryptLib = interface(IKeyCipher)
    ['{D593E5DC-5A3A-4B8F-8FCD-37C10C840E67}']
    function Version: IVersion;
  end;

  TCryptLib = class sealed(TInterfacedObject, ICryptLib)
  strict private
  type
    TCrypt = function(const Text: WideString): WideString; stdcall;
    TIsValidKey = function(const CryptKeyToValidate: WideString): Boolean; stdcall;
    TChangeKey = procedure(const Key: WideString); stdcall;
  strict private
    _LibraryCore: ILibraryCore;
    _Encode, _Decode: TCrypt;
    _IsValidKey: TIsValidKey;
    _ChangeKey: TChangeKey;
  public
    function Version: IVersion;
    function Encode(const Text: WideString): WideString;
    function Decode(const Text: WideString): WideString;
    function IsValidKey(const Key: WideString): Boolean;
    procedure ChangeKey(const Key: WideString);
    constructor Create(const LibraryPath: String);
    class function New(const LibraryPath: String): ICryptLib;
  end;

implementation

function TCryptLib.Version: IVersion;
begin
  Result := _LibraryCore.Version;
end;

function TCryptLib.Encode(const Text: WideString): WideString;
begin
  if Assigned(@_Encode) then
    Result := _Encode(Text);
end;

function TCryptLib.Decode(const Text: WideString): WideString;
begin
  if Assigned(@_Decode) then
    Result := _Decode(Text);
end;

function TCryptLib.IsValidKey(const Key: WideString): Boolean;
begin
  if Assigned(@_IsValidKey) then
    Result := _IsValidKey(Key)
  else
    Result := False;
end;

procedure TCryptLib.ChangeKey(const Key: WideString);
begin
  if Assigned(@_ChangeKey) then
    _ChangeKey(Key);
end;

constructor TCryptLib.Create(const LibraryPath: String);
begin
  _LibraryCore := TLibraryCore.New(LibraryPath, 'CryptLib');
  @_Encode := _LibraryCore.GetMethodAddress('Encode');
  @_Decode := _LibraryCore.GetMethodAddress('Decode');
  @_IsValidKey := _LibraryCore.GetMethodAddress('IsValidKey');
  @_ChangeKey := _LibraryCore.GetMethodAddress('ChangeKey');
end;

class function TCryptLib.New(const LibraryPath: String): ICryptLib;
begin
  Result := TCryptLib.Create(LibraryPath);
end;

end.
