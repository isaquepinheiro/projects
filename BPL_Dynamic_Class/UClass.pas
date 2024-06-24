unit UClass;

interface

uses
  SysUtils,
  UInterface;

type
  TCalculator = class(TInterfacedObject, ICalculator)
  private
    function _Somar(A, B: Integer): Integer;
  public
    function Somar(A, B: Integer): Integer;
    function Subtrair(A, B: Integer): Integer;
  end;

function New: ICalculator; cdecl;

exports
    New;

implementation

function New: ICalculator;
begin
  Result := TCalculator.Create;
end;

function TCalculator.Somar(A, B: Integer): Integer;
begin
  Result := _Somar(A, B);
end;

function TCalculator.Subtrair(A, B: Integer): Integer;
begin
  Result := A - B;
end;

function TCalculator._Somar(A, B: Integer): Integer;
begin
  Result := A + B;
  raise Exception.Create('Error Message');
end;

end.
