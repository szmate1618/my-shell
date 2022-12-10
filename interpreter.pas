unit Interpreter;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Process,
  Lexeme;

type
  TInterpreter = class
  public
    procedure Execute(const lexemes: TLexemeArray);
  end;

implementation

procedure TInterpreter.Execute(const Lexemes: TLexemeArray);
const
  BUF_SIZE = 2048; // Buffer size for reading the output in chunks
var
  processes: array of TProcess = ();
  output: string;
  i: integer;
  OutputStream: TStream;
  BytesRead: longint;
  Buffer: array[1..BUF_SIZE] of byte;
begin
  // Create an array of TProcess objects for the lexemes that have .Kind = tkExecutable
  SetLength(processes, 0);
  for i := Low(lexemes) to High(lexemes) do
    if Lexemes[i].Kind = tkExecutable then
    begin
      SetLength(processes, Length(processes) + 1);
      processes[High(processes)] := TProcess.Create(nil);
      processes[High(processes)].Executable := lexemes[i].Value;
      processes[High(processes)].Options := [poUsePipes];
    end
    else if Lexemes[i].Kind = tkUnknown then  // TODO: Fix this logic, improve lexer.
    begin
      processes[High(processes)].Parameters.Add(lexemes[i].Value);
    end;
  
  for i := Low(processes) to High(processes) do
  begin
    processes[i].Execute;
  end;
  // TODO: Free the processes I guess.
end;

end.

