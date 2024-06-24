unit UClass;

interface

uses
  UInterface;

type
  TCalculator = class(TInterfacedObject, ICalculator)
  public
    function Somar(A, B: Integer): Integer;
    function Subtrair(A, B: Integer): Integer;
  end;

function Calculator: ICalculator; cdecl;

exports
    Calculator;

implementation

function Calculator: ICalculator;
begin
  Result := TCalculator.Create;
end;

function TCalculator.Somar(A, B: Integer): Integer;
begin
  Result := A + B;
end;

function TCalculator.Subtrair(A, B: Integer): Integer;
begin
  Result := A - B;
end;

end.
