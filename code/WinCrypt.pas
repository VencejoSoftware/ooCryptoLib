{
  Copyright (c) 2021, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit WinCrypt;

interface

uses
  Windows;

const
  ADVAPI_DLL = 'ADVAPI32.DLL';
  PROV_RSA_FULL = 1;
  PROV_RSA_AES = 24;
  KP_MODE = 4;
  CRYPT_VERIFYCONTEXT = $F0000000;
  CRYPT_MACHINE_KEYSET = $00000020;
  CRYPT_NEWKEYSET = $00000008;
  CRYPT_EXPORTABLE = $1;
  NTE_BAD_KEYSET = Windows.NTE_BAD_KEYSET;
  // algo class ids
  ALG_CLASS_HASH = 4 shl 13;
  ALG_TYPE_ANY = 0;
  // Hash sub ids
  ALG_SID_MD2 = 1;
  ALG_SID_MD4 = 2;
  ALG_SID_MD5 = 3;
  ALG_SID_SHA = 4;
  ALG_SID_SHA1 = 4;
  ALG_SID_MAC = 5;
  ALG_SID_SSL3SHAMD5 = 8;
  ALG_SID_HMAC = 9;
  ALG_SID_TLS1PRF = 10;
  ALG_SID_HASH_REPLACE_OWF = 11;
  // algorithm identifier definitions
  CALG_MD2 = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_MD2;
  CALG_MD4 = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_MD4;
  CALG_MD5 = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_MD5;
  CALG_SHA = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_SHA;
  CALG_SHA1 = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_SHA1;
  CALG_MAC = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_MAC;
  CALG_SSL3_SHAMD5 = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_SSL3SHAMD5;
  CALG_HMAC = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_HMAC;
  CALG_TLS1PRF = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_TLS1PRF;
  CALG_HASH_REPLACE_OWF = ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_HASH_REPLACE_OWF;
  // some encryption algorithm definitions
  CALG_RC4 = $00006801;
  CALG_RC5 = $0000660D;
  CALG_3DES = $00006603;
  CALG_AES128 = 26126;
  // use with PROV_RSA_AES To get SHA-2 values.
  CALG_SHA256 = $0000800C;
  CALG_SHA384 = $0000800D;
  CALG_SHA512 = $0000800E;
  // gethashparam tags
  HP_ALGID = $0001;
  HP_HASHVAL = $0002;
  HP_HASHSIZE = $0004;
  HP_HMAC_INFO = $0005;
  HP_TLS1PRF_LABEL = $0006;
  HP_TLS1PRF_SEED = $0007;

  MS_ENHANCED_PROV: PAnsiChar = 'Microsoft Enhanced Cryptographic Provider v1.0';
  MS_ENHANCED_PROV_A: PAnsiChar = 'Microsoft Enhanced Cryptographic Provider v1.0';
  MS_ENHANCED_PROV_W: PWideChar = 'Microsoft Enhanced Cryptographic Provider v1.0';

  CRYPT32_DLL = 'crypt32.dll';
  CRYPT_STRING_BASE64HEADER = $00000000; // Base64, with certificate beginning and ending headers.
  CRYPT_STRING_BASE64 = $00000001; // Base64, without headers.
  CRYPT_STRING_BINARY = $00000002; // Pure binary copy.
  CRYPT_STRING_BASE64REQUESTHEADER = $00000003; // Base64, with request beginning and ending headers.
  CRYPT_STRING_HEX = $00000004; // hexadecimal only.
  CRYPT_STRING_HEXASCII = $00000005; // Hexadecimal, with ASCII character display.
  // Tries the following, in order: CRYPT_STRING_BASE64HEADER    CRYPT_STRING_BASE64
  CRYPT_STRING_BASE64_ANY = $00000006;
  // Tries the following, in order: CRYPT_STRING_BASE64HEADER
  // CRYPT_STRING_BASE64    CRYPT_STRING_BINARY
  CRYPT_STRING_ANY = $00000007;
  CRYPT_STRING_HEX_ANY = $00000008;
  CRYPT_STRING_BASE64X509CRLHEADER = $00000009; // Base64, with X.509 CRL beginning and ending headers.
  CRYPT_STRING_HEXADDR = $0000000A; // Hexadecimal, with address display.
  CRYPT_STRING_HEXASCIIADDR = $0000000B; // Hexadecimal, with ASCII character and address display.
  CRYPT_STRING_HEXRAW = $0000000C; // A raw hexadecimal string.
  CRYPT_STRING_STRICT = $20000000; // Enforce strict decoding of ASN.1 text formats.
  CRYPT_STRING_NOCRLF = $40000000; // Do not append any new line characters to the encoded string.
  CRYPT_STRING_NOCR = $80000000; // Only use the line feed (LF) character (0x0A) for a new line.

  CRYPT_MODE_CBC = 1;
  CRYPT_MODE_ECB = 2;
  CRYPT_MODE_CFB = 4;

type
  TCryptProv = THandle;
  TAlgID = integer;
  TCryptKey = pointer;
  TCryptHash = pointer;

function CryptAcquireContext(var phProv: TCryptProv; szContainer: PAnsiChar; szProvider: PAnsiChar; dwProvType: DWord;
  dwFlags: DWord): boolean; stdcall;
function CryptAcquireContextA(phProv: TCryptProv; szContainer: PAnsiChar; szProvider: PAnsiChar; dwProvType: DWord;
  dwFlags: DWord): boolean; stdcall;
function CryptAcquireContextW(phProv: TCryptProv; szContainer: PWideChar; szProvider: PWideChar; dwProvType: DWord;
  dwFlags: DWord): boolean; stdcall;
function CryptCreateHash(phProv: TCryptProv; Algid: TAlgID; hKey: TCryptKey; dwFlags: DWord; var phHash: TCryptHash)
  : boolean; stdcall;
function CryptHashData(phHash: TCryptHash; pbData: pointer; dwDataLen: DWord; dwFlags: DWord): boolean; stdcall;
function CryptGetHashParam(phHash: TCryptHash; dwParam: DWord; pbData: pointer; var dwDataLen: DWord; dwFlags: DWord)
  : boolean; stdcall;
function CryptDestroyHash(phHash: TCryptHash): boolean; stdcall;
function CryptDestroyKey(phKey: TCryptKey): boolean; stdcall;
function CryptReleaseContext(phProv: TCryptProv; dwFlags: DWord): boolean; stdcall;
function CryptSetKeyParam(key: TCryptKey; dwParam: longint; pbData: pbyte; dwFlags: longint): boolean; stdcall;
function CryptGenRandom(phProv: TCryptProv; dwLen: DWord; pbBuffer: pointer): BOOL; Stdcall;

function CryptStringToBinary(pszString: PChar; cchString: DWord; dwFlags: DWord; pbBinary: pointer;
  var pcbBinary: DWord; var pdwSkip: DWord; var pdwFlags: DWord): boolean; stdcall;

function CryptBinaryToString(pbBinary: pointer; cbBinary: DWord; dwFlags: DWord; pszString: PChar;
  var pcchString: DWord): boolean; stdcall;

function CryptStringToBinaryA(pszString: PAnsiChar; cchString: DWord; dwFlags: DWord; pbBinary: pointer;
  var pcbBinary: DWord; var pdwSkip: DWord; var pdwFlags: DWord): boolean; stdcall;

function CryptBinaryToStringA(pbBinary: pointer; cbBinary: DWord; dwFlags: DWord; pszString: PAnsiChar;
  var pcchString: DWord): boolean; stdcall;

function CryptStringToBinaryW(pszString: PWideChar; cchString: DWord; dwFlags: DWord; pbBinary: pointer;
  var pcbBinary: DWord; var pdwSkip: DWord; var pdwFlags: DWord): boolean; stdcall;

function CryptBinaryToStringW(pbBinary: pointer; cbBinary: DWord; dwFlags: DWord; pszString: PWideChar;
  var pcchString: DWord): boolean; stdcall;

function CryptEncrypt(hKey: TCryptKey; hHash: TCryptHash; Final: BOOL; dwFlags: DWord; pbData: pointer;
  var pdwDataLen: DWord; dwBufLen: DWord): BOOL; stdcall;

function CryptDecrypt(hKey: TCryptKey; hHash: TCryptHash; Final: BOOL; dwFlags: DWord; pbData: pointer;
  var pdwDataLen: DWord): BOOL; stdcall;

function CryptDeriveKey(hProv: TCryptProv; Algid: TAlgID; hBaseData: TCryptHash; dwFlags: DWord; var phKey: TCryptKey)
  : BOOL; stdcall;

function CryptAcquireContext; external ADVAPI_DLL Name 'CryptAcquireContextA';
function CryptAcquireContextA; external ADVAPI_DLL name 'CryptAcquireContextA';
function CryptAcquireContextW; external ADVAPI_DLL name 'CryptAcquireContextW';
function CryptCreateHash; external ADVAPI_DLL name 'CryptCreateHash';
function CryptHashData; external ADVAPI_DLL name 'CryptHashData';
function CryptGetHashParam; external ADVAPI_DLL name 'CryptGetHashParam';
function CryptDestroyHash; external ADVAPI_DLL name 'CryptDestroyHash';
function CryptDestroyKey; external ADVAPI_DLL name 'CryptDestroyKey';
function CryptReleaseContext; external ADVAPI_DLL name 'CryptReleaseContext';
function CryptSetKeyParam; external ADVAPI_DLL name 'CryptSetKeyParam';
function CryptGenRandom; external ADVAPI_DLL name 'CryptGenRandom';
function CryptEncrypt; external ADVAPI_DLL name 'CryptEncrypt';
function CryptDecrypt; external ADVAPI_DLL name 'CryptDecrypt';
function CryptDeriveKey; external ADVAPI_DLL name 'CryptDeriveKey';

function CryptStringToBinary; external CRYPT32_DLL name 'CryptStringToBinaryA';
function CryptBinaryToString; external CRYPT32_DLL name 'CryptBinaryToStringA';
function CryptStringToBinaryA; external CRYPT32_DLL name 'CryptStringToBinaryA';
function CryptBinaryToStringA; external CRYPT32_DLL name 'CryptBinaryToStringA';
function CryptStringToBinaryW; external CRYPT32_DLL name 'CryptStringToBinaryW';
function CryptBinaryToStringW; external CRYPT32_DLL name 'CryptBinaryToStringW';

function WinCryptDecodeString(const Text, SeedKey: AnsiString): AnsiString;
function WinCryptEncodeString(const Text, SeedKey: AnsiString): AnsiString;

implementation

function WinCryptDecodeString(const Text, SeedKey: AnsiString): AnsiString;
var
  key: TCryptKey;
  Hash: TCryptHash;
  Prov: TCryptProv;
  DataLen, Skip, Flags, BufSize: DWord;
  DataBuf: pointer;
  Param: longint;
begin
  Param := CRYPT_MODE_CBC;
  CryptAcquireContext(Prov, nil, nil, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT);
  CryptCreateHash(Prov, CALG_SHA1, nil, 0, Hash);
  CryptHashData(Hash, @SeedKey[1], Length(SeedKey) * SizeOf(ansichar), 0);
  CryptDeriveKey(Prov, CALG_RC4, Hash, 0, key);
  CryptSetKeyParam(key, KP_MODE, @Param, 0);
  CryptDestroyHash(Hash);
  DataLen := Length(Text) + 1;
  BufSize := 0;
  CryptStringToBinaryA(@Text[1], DataLen, CRYPT_STRING_BASE64, nil, BufSize, Skip, Flags);
  GetMem(DataBuf, BufSize);
  ZeroMemory(DataBuf, BufSize);
  try
    CryptStringToBinaryA(@Text[1], DataLen, CRYPT_STRING_BASE64, DataBuf, BufSize, Skip, Flags);
    CryptDecrypt(key, nil, True, 0, DataBuf, BufSize);
    CryptDestroyKey(key);
    SetLength(Result, BufSize);
    Move(DataBuf^, Result[1], BufSize);
    CryptReleaseContext(Prov, 0);
  finally
    FreeMem(DataBuf);
  end;
end;

function WinCryptEncodeString(const Text, SeedKey: AnsiString): AnsiString;
var
  key: TCryptKey;
  Hash: TCryptHash;
  Prov: TCryptProv;
  DataLen, BufSize: DWord;
  DataBuf: pbyte;
  Param: longint;
begin
  Param := CRYPT_MODE_CBC;
  CryptAcquireContext(Prov, nil, nil, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT);
  CryptCreateHash(Prov, CALG_SHA1, nil, 0, Hash);
  CryptHashData(Hash, @SeedKey[1], Length(SeedKey) * SizeOf(ansichar), 0);
  CryptDeriveKey(Prov, CALG_RC4, Hash, CRYPT_EXPORTABLE, key);
  CryptSetKeyParam(key, KP_MODE, @Param, 0);
  CryptDestroyHash(Hash);
  DataLen := Length(Text);
  BufSize := DataLen + 1;
  GetMem(DataBuf, BufSize);
  ZeroMemory(DataBuf, BufSize);
  try
    Move(Text[1], DataBuf^, DataLen);
    CryptEncrypt(key, nil, True, 0, DataBuf, DataLen, BufSize);
    CryptDestroyKey(key);
    CryptReleaseContext(Prov, 0);
    BufSize := 0;
    CryptBinaryToStringA(DataBuf, DataLen, CRYPT_STRING_BASE64 or CRYPT_STRING_NOCRLF, nil, BufSize);
    SetLength(Result, BufSize);
    CryptBinaryToStringA(DataBuf, DataLen, CRYPT_STRING_BASE64 or CRYPT_STRING_NOCRLF, @Result[1], BufSize);
    Result := Copy(Result, 1, Pred(Length(Result)));
  finally
    FreeMem(DataBuf);
  end;
end;

end.
