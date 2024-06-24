unit UTest;

interface

uses
  DUnitX.TestFramework,
  UInterface, UBPLLoader;

type
  [TestFixture]
  TBPLDynamic = class
  private
    FBPLLoader: ICalculator;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    [TestCase('Somar','1,2')]
    procedure Somar(const AValue1 : Integer;const AValue2 : Integer);
    [Test]
    [TestCase('Subtrair','4,2')]
    procedure Subtrair(const AValue1 : Integer;const AValue2 : Integer);
  end;

implementation

procedure TBPLDynamic.Setup;
begin
  TCalculator.LoadPackage('.\', 'BPL_Class.bpl');
  //
  FBPLLoader := TCalculator.Create;
end;

procedure TBPLDynamic.TearDown;
begin

end;

procedure TBPLDynamic.Somar(const AValue1 : Integer;const AValue2 : Integer);
var
  LResult: Integer;
begin
  LResult := FBPLLoader.Somar(AVAlue1, AValue2);

  Assert.AreEqual(3, LResult, 'Total Diff Somar()')
end;

procedure TBPLDynamic.Subtrair(const AValue1, AValue2: Integer);
var
  LResult: Integer;
begin
  LResult := FBPLLoader.Subtrair(AVAlue1, AValue2);

  Assert.AreEqual(2, LResult, 'Total Diff Subtrair()')
end;

initialization
  TDUnitX.RegisterTestFixture(TBPLDynamic);

end.
