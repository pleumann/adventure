{$ifdef PASTA}

{ Keys are shown in reverse video between two half circles (see print.pas),
  which are user-defined characters 144 (left) and 145 (right) }
{$ifdef SYS_AGON}
{$define FIXED_CONFIG}
{$define KEY_CAPS}

const
  KEY_CAPS_UDG: array[0..15] of byte = (   { font leaves columns 0 and 7 empty }
    %00000001,
    %00000011,
    %00000111,
    %00000111,
    %00000111,
    %00000111,
    %00000011,
    %00000001,

    %10000000,
    %11000000,
    %11100000,
    %11100000,
    %11100000,
    %11100000,
    %11000000,
    %10000000
  );
{$endif}
{$ifdef SYS_ZXNEXT}
{$define FIXED_CONFIG}
{$define KEY_CAPS}

const
  KEY_CAPS_UDG: array[0..15] of byte = (   { only the leftmost 5 pixels }
    %00001100,
    %00011100,
    %00111100,
    %00111100,
    %00111100,
    %00111100,
    %00011100,
    %00001100,

    %11000000,
    %11100000,
    %11110000,
    %11110000,
    %11110000,
    %11110000,
    %11100000,
    %11000000
  );
{$endif}

{$endif}

{$ifdef FIXED_CONFIG}

{ Sets fixed configuration for platforms with a known screen (Agon, Next) }
procedure Read_Configuration;
var
  i: byte;

begin

  left_margin := 0;
  chars_per_line := ScreenWidth - 1;

{$ifdef SYS_AGON}
  r_start := #17#0#17#143;    { VDU 17: black on bright white }
  r_exit := #17#15#17#128;    { VDU 17: bright white on black }
  s_clrscr := #12;            { VDU 12: CLS }

  { VDU 23: define key caps }
  Write(#23#144);
  for i := 0 to 7 do Write(Chr(KEY_CAPS_UDG[i]));
  Write(#23#145);
  for i := 8 to 15 do Write(Chr(KEY_CAPS_UDG[i]));
{$endif}
{$ifdef SYS_ZXNEXT}
  chars_per_line := 50;       { layer 1,1 (set by loader.bas): 51 columns }
  r_start := #20#1;           { INVERSE 1 }
  r_exit := #20#0;            { INVERSE 0 }
  s_clrscr := #14;            { clear window }

  { Point UDG system variable to key caps (default location might be
    paged out by overlays) }
  Mem[23675] := Lo(Addr(KEY_CAPS_UDG));
  Mem[23676] := Hi(Addr(KEY_CAPS_UDG));
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