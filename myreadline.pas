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
    procedure PushToHistory;
  public
    constructor Create(const Prompt: string);
    procedure WritePrompt;
    function ReadLine: string;
    function GetTokens: TTokenArray;
  end;

implementation

constructor TMyReadLine.Create(const Prompt: string = "> ");
begin
  FPrompt := Prompt;
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

function TMyReadLine.GetTokens: TArray<string>;
begin
  Result := FCurrentLine.Split([' ']);
end;

procedure TMyReadLine.PushToHistory;
begin
  SetLength(FHistory, Length(FHistory) + 1);
  FHistory[High(FHistory)] := FCurrentLine;
end;

end.

