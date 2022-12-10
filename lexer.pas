unit Lexer;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  Lexeme;

type
  TLexer = class
  private
  public
    constructor Create();
    function GetLexemesFromCommand(const command: string): TLexemeArray;
    function IsQuitCommand(const tokens: TLexemeArray): boolean;
  end;

implementation

constructor TLexer.Create;
begin

end;

{ Parse a command line string into an array of tokens }
function TLexer.GetLexemesFromCommand(const command: string): TLexemeArray;
var
  delimiters: string;
  tokens: array of string;
  token: string;
  lexemes: TLexemeArray;
  lexeme: TLexeme;
  quoted: Boolean;  // TODO: Handle quotes.
begin
  { Create a regular expression to match pipe/redirect characters }
  delimiters := ' \t\r\n';

  tokens = SplitString(command, delimiters);

  { Initialize the array of lexemes }
  SetLength(lexemes, 0);

  { Split the command line string into tokens using the regular expression }
  for Lexeme in tokens do
  begin
    lexeme :=
    { Extract the token from the command line string }
    Lexeme.Value := line.Substring(match.Index, match.Length);
    case Lexeme.Value of
      '|': Lexeme.Kind := tkPipe;
      '>', '<': Lexeme.Kind := tkRedirect;
    else
      Lexeme.Kind := tkMacro;
    end;

    { Add the token to the array of lexemes }
    SetLength(lexemes, Length(lexemes) + 1);
    tokens[High(lexemes)] := Lexeme;

  end;

  { Return the array of tokens }
  Result := tokens;
end;

function IsQuitCommand(const lexemes: TLexemeArray): boolean;
begin
  // TODO: Think about uppercase-lowercase issues.
  Result := lexemes[Low(lexemes)].Kind = tkCommand and
  (lexemes[Low(lexemes)].Value = "quit" or lexemes[Low(lexemes)].Value = "exit");
end;

end.

