unit MyReadLine;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  Lexeme, Lexer;

type
  TMyReadLine = class
  private
    FPrompt: string;
    FCurrentLine: string;
    FHistory: array of string;
    FLexer: TLexer;
    procedure PushToHistory;
  public
    constructor Create(const Prompt: string = '> ');
    procedure WritePrompt;
    function ReadLine: string;
    function GetLexemes: TLexemeArray;
  end;

implementation

constructor TMyReadLine.Create(const Prompt: string);
begin
  FPrompt := Prompt;
  FLexer := TLexer.Create;
end;

procedure TMyReadLine.WritePrompt;
begin
  Write(FPrompt);
end;

function TMyReadLine.ReadLine: string;
begin
  Readln(FCurrentLine);
  PushToHistory;
  Result := FCurrentLine;
end;

function TMyReadLine.GetLexemes: TLexemeArray;
begin
  Result := FLexer.GetLexemesFromCommand(FCurrentLine);
end;

procedure TMyReadLine.PushToHistory;
begin
  SetLength(FHistory, Length(FHistory) + 1);
  FHistory[High(FHistory)] := FCurrentLine;
end;

end.

