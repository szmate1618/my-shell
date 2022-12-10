unit testlexer;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry,
  Lexer;

type

  TTestLexer= class(TTestCase)
  private
    FLexer: TLexer;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestQuitCondition;
  end;

implementation

procedure TTestLexer.TestQuitCondition;
begin
  CheckEquals(True, FLexer.IsQuitCommand(FLexer.GetLexemesFromCommand('quit')));
  CheckEquals(True, FLexer.IsQuitCommand(FLexer.GetLexemesFromCommand('exit')));
  CheckEquals(False, FLexer.IsQuitCommand(FLexer.GetLexemesFromCommand('abc')));
end;

procedure TTestLexer.SetUp;
begin
  FLexer := TLexer.Create;
end;

procedure TTestLexer.TearDown;
begin

end;

initialization

  RegisterTest(TTestLexer);
end.

