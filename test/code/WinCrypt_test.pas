{
  Copyright (c) 2021, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit WinCrypt_test;

interface

uses
  Classes, SysUtils,
  WinCrypt,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TWinCryptTest = class sealed(TTestCase)
  const
    KEY = '73E719C5-C455-4836-99B6-BCA424A61E09';
  published
    procedure EncryptAdminRTestDotComReturnEncryptedText;
    procedure DecrypEncryptedTextReturnAdminRTestDotCom;
  end;

implementation

procedure TWinCryptTest.EncryptAdminRTestDotComReturnEncryptedText;
begin
  CheckEquals('MsYzAIkA2us891oFXbg=', String(WinCryptEncodeString('admin@test.com', KEY)));
end;

procedure TWinCryptTest.DecrypEncryptedTextReturnAdminRTestDotCom;
begin
  CheckEquals('admin@test.com', String(WinCryptDecodeString('MsYzAIkA2us891oFXbg=', KEY)));
end;

initialization

RegisterTest(TWinCryptTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
