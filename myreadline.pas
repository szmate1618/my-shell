unit MyReadLine;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  Lexeme, Lexer, Interpreter;

type
  TMyReadLine = class
  private
    FPrompt: string;
    FCurrentLine: string;
    FHistory: array of string;
    FLexer: TLexer;
    FInterpreter: TInterpreter;
    procedure PushToHistory;
  public
    constructor Create(const Prompt: string = #27'[31m> '#27'[0m');
    procedure WritePrompt;
    function ReadLine: string;
    function GetLexemes: TLexemeArray;
    function QuitCommandIssued: boolean;
    procedure ExecuteCurrentLine;
  end;

implementation

constructor TMyReadLine.Create(const Prompt: string);
begin
  FPrompt := Prompt;
  FLexer := TLexer.Create;
  FInterpreter := TInterpreter.Create;
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

function TMyReadLine.QuitCommandIssued: boolean;
begin
  Result := Flexer.IsQuitCommand(FLexer.GetLexemesFromCommand(FCurrentLine));
end;

procedure TMyReadLine.ExecuteCurrentLine;
begin
  FInterpreter.Execute(FLexer.GetLexemesFromCommand(FCurrentLine));
end;

end.

