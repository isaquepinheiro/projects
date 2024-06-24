unit UInterface;

interface

type
  ICalculator = interface
    ['{1A910780-0940-42B2-806D-84DDD1040C53}']
    function Somar(A, B: Integer): Integer;
    function Subtrair(A, B: Integer): Integer;
  end;

implementation

end.
