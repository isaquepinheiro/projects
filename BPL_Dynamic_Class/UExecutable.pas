unit UExecutable;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UBPLLoader, UInterface,
  Vcl.AppEvnts,

  JclDebug, JclHookExcept;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    ApplicationEvents1: TApplicationEvents;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
  private
    { Private declarations }
    FLoader: ICalculator;
    procedure DoMeuClick;
    function PrepareStackInfoList: String;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ApplicationEvents1Exception(Sender: TObject; E: Exception);
begin
  Memo1.Clear;
  Memo1.Lines.Add(PrepareStackInfoList());

//  Memo1.Lines.Add('++++++++++++++++++++++');
//  Memo1.Lines.Add(E.StackTrace);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  DoMeuClick;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Edit3.Text := FloatToStr( FLoader.Subtrair(StrToIntDef(Edit1.Text, 0), StrToIntDef(Edit2.Text, 0)) );
end;

procedure TForm1.DoMeuClick;
begin
  Edit3.Text := FloatToStr( FLoader.Somar(StrToIntDef(Edit1.Text, 0), StrToIntDef(Edit2.Text, 0)) );
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Pilha em Detalhe
  JclStackTrackingOptions := [stStack,
                              stExceptFrame,
                              stRawMode,
                              stAllModules,
                              stStaticModuleList,
                              stDelayedTrace,
                              stTraceAllExceptions];
  JclStartExceptionTracking();


  TCalculator.LoadPackage('.\', 'BPL_Class.bpl');
  //
  FLoader := TCalculator.Create;
end;

function TForm1.PrepareStackInfoList: String;
var
  LStackList: TJclStackInfoList;
  LStackTrace: TStringList;
begin
  Result := 'Pilha de erros vazia!';
  LStackList := JclCreateStackList(True, 3, nil);
  LStackTrace := TStringList.Create;
  try
    if Assigned(LStackList) then
      LStackList.AddToStrings(LStackTrace, True, True, True, False);
    Result := LStackTrace.Text;
  finally
    LStackList.Free;
    LStackTrace.Free;
  end;

//      for i := LStackTrace.Count - 1 downto 0 do
//      begin
//        Line := LStackTrace[i];
//        if not ((Pos('meuexe.exe', Line) > 0) or (Pos('BPL_Class.bpl', Line) > 0)) then
//        begin
//          LStackTrace.Delete(i);
//        end;

end;

end.
