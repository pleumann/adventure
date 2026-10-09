{$ifdef PASTA}

{ Sets fixed configuration for the PASTA/80 target platforms }
procedure Read_Configuration;
begin

  left_margin := 0;
  chars_per_line := ScreenWidth - 1;

{$ifdef SYS_CPM}
  r_start := #27'p';          { VT52: reverse on }
  r_exit := #27'q';           { VT52: reverse off }
  s_clrscr := #27'H'#27'J';   { VT52: home, clear to end of screen }
{$endif}
{$ifdef SYS_AGON}
  r_start := #17#135;         { VDU 17,135: white background }
  r_exit := #17#128;          { VDU 17,128: black background }
  s_clrscr := #12;            { VDU 12: CLS }
{$endif}
{$ifdef SYS_ZXNEXT}
  chars_per_line := 50;       { layer 1,1 (set by loader.bas): 51 columns }
  r_start := #20#1;           { INVERSE 1 }
  r_exit := #20#0;            { INVERSE 0 }
  s_clrscr := #14;            { clear window }
{$endif}

end;

{$else}

{ Reads stored configuration }
procedure Read_Configuration;
var
  file_var: Text;
  s_left_margin: string[1];
  s_chars_per_line: string[2];
  
const
  FILE_NAME = 'ADVCONF.DAT';

begin

  Assign (file_var, FILE_NAME);

  {$I-}

  Reset (file_var);

  {$I+}

  if IOresult <> 0 then begin

    Writeln;
    Writeln ('Configuration file doesn''t exist.');
    Writeln ('Run game configuration app first!');
    Writeln;
    halt;

  end;

  Readln (file_var, s_left_margin);
  Readln (file_var, s_chars_per_line);
  Readln (file_var, r_start);
  Readln (file_var, r_exit);
  Readln (file_var, s_clrscr);

  Val (s_left_margin, left_margin, val_result);
  Val (s_chars_per_line, chars_per_line, val_result);

  Close (file_var);

end;

{$endif}