unit UExecutable;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UDLLLoader, UInterface;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FBPLLoader: ICalculator;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Edit3.Text := FloatToStr( FBPLLoader.Somar(StrToIntDef(Edit1.Text, 0), StrToIntDef(Edit2.Text, 0)) );
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Edit3.Text := FloatToStr( FBPLLoader.Subtrair(StrToIntDef(Edit1.Text, 0), StrToIntDef(Edit2.Text, 0)) );
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FBPLLoader := TDLLLoader.Create('DLL_Class.dll');
end;

end.
