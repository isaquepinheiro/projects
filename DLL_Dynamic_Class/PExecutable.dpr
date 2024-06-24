program PExecutable;

uses
  Vcl.Forms,
  UExecutable in 'UExecutable.pas' {Form1},
  UInterface in 'UInterface.pas',
  UDLLLoader in 'UDLLLoader.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
