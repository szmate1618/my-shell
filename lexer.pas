unit Lexer;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, StrUtils,
  Lexeme, Command;

type
  TLexer = class
  private
  public
    constructor Create();
    function GetLexemesFromCommand(const command: string): TLexemeArray;
    function IsQuitCommand(const lexemes: TLexemeArray): boolean;
    function IsCommand(const token: string): boolean;
  end;

implementation

constructor TLexer.Create;
begin

end;

{ Parse a command line string into an array of tokens }
function TLexer.GetLexemesFromCommand(const command: string): TLexemeArray;
var
  delimiters: string = ' \t\r\n';
  tokens: array of string;
  token: string;
  lexemes: TLexemeArray = ();
  lexeme: TLexeme;
  quoted: Boolean;  // TODO: Handle quotes.
begin
  tokens := SplitString(command, delimiters);

  { Initialize the array of lexemes }
  SetLength(lexemes, 0);

  { Split the command line string into tokens using the regular expression }
  for token in tokens do
  begin
    lexeme.Value := Trim(token);

    if lexeme.Value = '|' then lexeme.Kind := tkPipe
    else if lexeme.Value = '>' then lexeme.Kind := tkRedirect
    else if lexeme.Value = '<' then lexeme.Kind := tkRedirect
    else if IsCommand(lexeme.Value) then lexeme.Kind := tkCommand
    else lexeme.Kind := tkUnknown;

    { Add the token to the array of lexemes }
    SetLength(lexemes, Length(lexemes) + 1);
    lexemes[High(lexemes)] := lexeme;

  end;

  { Return the array of tokens }
  Result := lexemes;
end;

function TLexer.IsQuitCommand(const lexemes: TLexemeArray): boolean;
begin
  // TODO: Think about uppercase-lowercase issues.
  Result := (lexemes[Low(lexemes)].Kind = tkCommand) and
  ((lexemes[Low(lexemes)].Value = 'quit') or (lexemes[Low(lexemes)].Value = 'exit'));
end;

function TLexer.IsCommand(const token: string): boolean;
var
  i: integer;
begin
  Result := False;
  for i := Low(kCommands) to High(kCommands) do
    begin
      if (token = kCommands[i]) then
      begin
        Result := True;
        Break;
      end;
    end;
end;

end.

