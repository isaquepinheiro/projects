unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  Classes,
  SysUtils,
  Hash;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    procedure _LoadDecryptedPasswordFromFile(const AFileName: String;
      const AKey: String; out APassword: String);
    procedure _SimpleXOREncryption(var AData: TBytes; const AKey: TBytes);
    procedure _SaveEncryptedPasswordToFile(const AFileName: String;
      const APassword: String; const AKey: String);
    procedure _RestoreBinaryFile(const AResourceName: String;
      const AFilePath: String);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{$R file_res.res}

procedure TForm1._SimpleXOREncryption(var AData: TBytes; const AKey: TBytes);
var
  LFor: Integer;
  LKeyLen: Integer;
begin
  LKeyLen := Length(AKey);
  if LKeyLen = 0 then
    raise Exception.Create('Key cannot be empty');

  for LFor := 0 to Length(AData) - 1 do
    AData[LFor] := AData[LFor] xor AKey[LFor mod LKeyLen];
end;

procedure TForm1._SaveEncryptedPasswordToFile(const AFileName: String;
  const APassword: String; const AKey: String);
var
  LKeyHash: TBytes;
  LPasswordBytes: TBytes;
  LFileStream: TFileStream;
begin
  // Crie um hash da chave usando SHA-256
  LKeyHash := THashSHA2.GetHashBytes(AKey);
  // Converte a senha para bytes
  LPasswordBytes := TEncoding.UTF8.GetBytes(APassword);
  // Criptografe a senha usando uma simples criptografia XOR
  _SimpleXOREncryption(LPasswordBytes, LKeyHash);
  // Salve a senha criptografada em um arquivo binário
  LFileStream := TFileStream.Create(AFileName, fmCreate);
  try
    LFileStream.WriteBuffer(LPasswordBytes, Length(LPasswordBytes));
  finally
    LFileStream.Free;
  end;
end;

procedure TForm1._LoadDecryptedPasswordFromFile(const AFileName: String;
  const AKey: String; out APassword: String);
var
  LKeyHash: TBytes;
  LEncryptedBytes: TBytes;
  LFileStream: TFileStream;
begin
  // Crie um hash da chave usando SHA-256
  LKeyHash := THashSHA2.GetHashBytes(AKey);
  // Leia o arquivo binário criptografado
  LFileStream := TFileStream.Create(AFileName, fmOpenRead);
  try
    SetLength(LEncryptedBytes, LFileStream.Size);
    LFileStream.ReadBuffer(LEncryptedBytes, LFileStream.Size);
  finally
    LFileStream.Free;
  end;
  // Descriptografe a senha usando a simples criptografia XOR
  _SimpleXOREncryption(LEncryptedBytes, LKeyHash);
  // Converta os bytes de volta para String
  APassword := TEncoding.UTF8.GetString(LEncryptedBytes);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  _SaveEncryptedPasswordToFile('encrypted_password.bin', '123456big', 'mysecretkey');
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  LDecryptedPassword: String;
begin
  _LoadDecryptedPasswordFromFile('encrypted_password.bin', 'mysecretkey', LDecryptedPassword);
  ShowMessage('Decrypted Password: ' + LDecryptedPassword);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  _RestoreBinaryFile('BINARYFILE', '.\file_res.bin');
end;

procedure TForm1._RestoreBinaryFile(const AResourceName: String;
  const AFilePath: String);
var
  LResourceStream: TResourceStream;
  LFileStream: TFileStream;
begin
  // Verifica se o arquivo já existe no caminho especificado
  if FileExists(AFilePath) then
    Exit;

  try
    // Tenta criar um stream para acessar o recurso especificado
    LResourceStream := TResourceStream.Create(HInstance, AResourceName, RT_RCDATA);
    // Tenta criar um stream para escrever no arquivo especificado
    LFileStream := TFileStream.Create(AFilePath, fmCreate);
    try
      // Copia o conteúdo do recurso para o arquivo
      LFileStream.CopyFrom(LResourceStream, 0);
    finally
      // Libera o stream do arquivo após a cópia
      LFileStream.Free;
      // Libera o stream do recurso após a cópia
      LResourceStream.Free;
    end;
  except
    on E: Exception do
      raise Exception.Create('Erro ao restaurar o arquivo binário: ' + E.Message);
  end;
end;

end.


