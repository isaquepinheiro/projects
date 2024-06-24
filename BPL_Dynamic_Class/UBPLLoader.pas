unit UBPLLoader;

interface

uses
  Windows,
  SysUtils,
  UInterface;

type
  TCalculator = class(TInterfacedObject, ICalculator)
  private
    class var FHandle: HMODULE;
  private
    FCalculator: ICalculator;
  public
    constructor Create;
    destructor Destroy; override;
    class function LoadPackage(const ABPLPath: string; const ABPLName: string): String;
    function Somar(A, B: Integer): Integer;
    function Subtrair(A, B: Integer): Integer;
  end;

implementation

constructor TCalculator.Create;
var
  LNewFunc: function: ICalculator; cdecl;
begin
  inherited Create;
  @LNewFunc := GetProcAddress(FHandle, 'New');
  if not Assigned(LNewFunc) then
    raise Exception.Create('Função New não encontrada na BPL');

  FCalculator := LNewFunc();
end;

destructor TCalculator.Destroy;
begin
  FCalculator := nil;
  if FHandle <> 0 then
    UnloadPackage(FHandle);
  inherited;
end;

class function TCalculator.LoadPackage(const ABPLPath: String; const ABPLName: string): String;
begin
  FHandle := SysUtils.LoadPackage(ABPLPath + ABPLName);
  if FHandle = 0 then
    raise Exception.Create('Erro ao carregar a BPL');

  Result := ABPLName;
end;

function TCalculator.Somar(A, B: Integer): Integer;
begin
  if not Assigned(FCalculator) then
    raise Exception.Create('Error Message');
  Result := FCalculator.Somar(A, B);
end;

function TCalculator.Subtrair(A, B: Integer): Integer;
begin
  if not Assigned(FCalculator) then
    raise Exception.Create('Error Message');
  Result := FCalculator.Subtrair(A, B);
end;

end.

