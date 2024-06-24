program PExecutable;

uses
//  FastMM4,
  Vcl.Forms,
  UExecutable in 'UExecutable.pas' {Form1},
  UInterface in 'UInterface.pas',
  UBPLLoader in 'UBPLLoader.pas';

{$R *.res}

begin
//  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
