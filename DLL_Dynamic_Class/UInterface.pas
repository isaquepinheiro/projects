unit UInterface;

interface

type
  ICalculator = interface
    ['{745A9EB5-C372-48F8-85CF-612E5BF1CCBE}']
    function Somar(A, B: Integer): Integer;
    function Subtrair(A, B: Integer): Integer;
  end;

implementation

end.
