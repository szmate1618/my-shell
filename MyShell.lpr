program MyShell;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, SysUtils, CustApp,
  MyReadLine, Command
  { you can add units after this };

type

  { TMyShell }

  TMyShell = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ TMyShell }

procedure TMyShell.DoRun;
var
  ErrorMsg: String;
begin
  // quick check parameters
  ErrorMsg:=CheckOptions('h', 'help');
  if ErrorMsg<>'' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h', 'help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;

  { add your program here }

  // stop program loop
  Terminate;
end;

constructor TMyShell.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor TMyShell.Destroy;
begin
  inherited Destroy;
end;

procedure TMyShell.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

var
  Application: TMyShell;
  ReadLine: TMyReadLine;
begin
  Application:=TMyShell.Create(nil);
  Application.Title:='My Shell';
  Application.Run;

  ReadLine:=TMyReadLine.Create;
  repeat
    ReadLine.WritePrompt;
    ReadLine.ReadLine;
  until ReadLine.QuitCommandIssued;

  Application.Free;
end.

