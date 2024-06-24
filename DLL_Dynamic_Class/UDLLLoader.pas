unit UDLLLoader;

interface

uses
  UInterface,
  SysUtils;

type
  TDLLLoader = class(TInterfacedObject, ICalculator)
  private
    FDLLHandle: HMODULE;
    FCalculator: ICalculator;
    function _LoadBPL(const DLLPath: string): Boolean;
  public
    constructor Create(const DLLPath: string);
    destructor Destroy; override;
    function Somar(A, B: Integer): Integer;
    function Subtrair(A, B: Integer): Integer;
  end;

implementation

uses
  Winapi.Windows;

constructor TDLLLoader.Create(const DLLPath: string);
type
  TNewFunction = function: ICalculator; cdecl;
var
  NewFunc: TNewFunction;
begin
  inherited Create;
  if not _LoadBPL(DLLPath) then
    raise Exception.Create('Erro ao carregar a DLL');

  @NewFunc := GetProcAddress(FDLLHandle, 'Calculator');
  if not Assigned(NewFunc) then
    raise Exception.Create('Função Calculator não encontrada na DLL');

  FCalculator := NewFunc;
end;

destructor TDLLLoader.Destroy;
begin
  FCalculator := nil;
  if FDLLHandle <> 0 then
    FreeLibrary(FDLLHandle);
  inherited;
end;

function TDLLLoader._LoadBPL(const DLLPath: string): Boolean;
begin
  FDLLHandle := LoadLibrary(PChar(DLLPath));
  Result := FDLLHandle <> 0;
end;

function TDLLLoader.Somar(A, B: Integer): Integer;
begin
  Result := FCalculator.Somar(A, B);
end;

function TDLLLoader.Subtrair(A, B: Integer): Integer;
begin
  Result := FCalculator.Subtrair(A, B);
end;

end.

