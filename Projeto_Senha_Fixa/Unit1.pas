unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    function GenerateDailyPassword(CNPJ: string): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.DateUtils;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  LCNPJ: string;
  LDailyPassword: string;
begin
  // Definir o CNPJ (substitua pelo CNPJ desejado)
  LCNPJ := '12345678000195'; // Exemplo de CNPJ

  // Gerar a senha diária
  LDailyPassword := GenerateDailyPassword(LCNPJ);

  // Exibir a senha gerada
  ShowMessage(LDailyPassword);
end;

function TForm1.GenerateDailyPassword(CNPJ: string): string;
const
  Characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
var
  Today: TDate;
  TodayStr: string;
  CombinedStr: string;
  Hash: Int64;
  I: Integer;
  Password: string;
begin
  // Verificar se o CNPJ tem 14 caracteres
  if Length(CNPJ) <> 14 then
    raise Exception.Create('CNPJ inválido. Deve ter 14 dígitos.');

  // Obter a data atual
  Today := Date;

  // Converter a data em uma string no formato 'yyyymmdd'
  TodayStr := FormatDateTime('yyyymmdd', Today);

  // Selecionar posições específicas do CNPJ e combinar com a data
  CombinedStr := CNPJ[1] + CNPJ[5] + CNPJ[9] + CNPJ[13] + TodayStr;

  // Inicializar o hash
  Hash := 0;

  // Calcular um hash simples a partir da string combinada
  for I := 1 to Length(CombinedStr) do
    Hash := Hash * 31 + Ord(CombinedStr[I]);

  // Inicializar a senha como uma string vazia
  Password := '';

  // Gerar uma senha de 8 caracteres a partir do hash
  for I := 1 to 8 do
  begin
    Password := Password + Characters[(Hash mod Length(Characters)) + 1];
    Hash := Hash div Length(Characters);  // Atualizar o hash para a próxima iteração
  end;

  Result := Password;
end;


end.
