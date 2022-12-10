unit Lexeme;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils; 

type
  { Define an enumerated type for the different kinds of lexemes }
  TLexemeKind = (
    tkCommand,    { A command lexeme }
    tkExecutable, { An executable lexeme }
    tkPath,       { A path lexeme }
    tkArgument,   { An argument lexeme }
    tkPipe,       { A pipe lexeme }
    tkRedirect,   { A redirect lexeme }
    tkMacro       { A macro lexeme }
  );

  { Define a record type for representing command line lexemes }
  TLexeme = record
    Kind: TLexemeKind;  { The kind of the lexeme }
    Value: string;     { The value of the lexeme }
  end;

  TLexemeArray = array of TLexeme;

implementation

end.

