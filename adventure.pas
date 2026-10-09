program Adventure;

{$ifndef PASTA}
uses crt;
{$endif}

{$I TYPES.PAS}
{$I CONSTS.PAS}

var 
  current_state       : byte;
  current_location    : byte;
  previous_location   : byte;
  key_hit             : char;
  game_over           : boolean;
  game_won            : boolean;
  success             : boolean;
  hero                : Tplayer;
  monsters            : Tmonsters;
  weapons             : Tweapons;
  armory              : Tarmor;
  key_legal           : boolean;
  target_items_number : byte;
  left_margin         : integer;
  chars_per_line      : integer;
  r_start             : string[4]; { reverse start code }
  r_exit              : string[4]; { reverse exit code }
  s_clrscr            : string[4]; { clear screen code }
  val_result          : integer;

  mystery_solved_5    : boolean;
  mystery_solved_6    : boolean;
  
  location_items   : array [0..MAP_SIZE, 0..MAX_ITEMS_IN_LOCATION] of byte;
  inventory_items  : array [0..MAX_INVENTORY] of byte;
  
{$I READKEY.PAS} { This function is only for Turbo Pascal 3.0 }
{$I CONF.PAS}
{$I PRINT.PAS}
{$I INFO.PAS}
{$I FIGHT.PAS}
{$I INIT.PAS}
{$I INVENTRY.PAS}
{$I DEFKEYS.PAS}
{$I LOCS.PAS}

{ Main program}
begin

{$ifdef SYS_ZXNEXT}
  SetCpuSpeed(3);             { 28 MHz }
{$endif}

  Read_Configuration;

  Write(s_clrscr);

  current_state := STATE_TITLE;
  
  repeat 
  
    case current_state of
    
      STATE_TITLE:
      begin
      
        Randomize;
        Init_Monsters;
        Init_Weapons;
        Init_Armory;
        Init_Locations;
        Init_Inventory;
        Init_Hero;

        Write(s_clrscr);

        if r_start = '' then begin

          WriteLn;
          WriteLn;
          WriteLn;
          Writeln ('               T  A  L  E         ');

        end else begin

          Writeln;
          Writeln ('       ' + r_start + '  ' + r_exit + '     ' + r_start + '     ' + r_exit + '  ' + r_start + '  ' +
                  r_exit + '       ' + r_start + '     ' + r_exit + ' ');
          Writeln ('     ' + r_start + '      ' + r_exit + '  ' + r_start + '  ' + r_exit + '   ' + r_start + '  ' + r_exit + 
                  ' ' + r_start + '  ' + r_exit + '      ' + r_start + '  ' + r_exit + '   ' + r_start + '  ' + r_exit);
          Writeln ('       ' + r_start + '  ' + r_exit + '    ' + r_start + '       ' + r_exit + ' ' + r_start + '  ' + 
                  r_exit + '      ' + r_start + '    ' + r_exit + '   ');
          Writeln ('       ' + r_start + '  ' + r_exit + '    ' + r_start + '  ' + r_exit + '   ' + r_start + '  ' + r_exit + 
                  ' ' + r_start + '  ' + r_exit + '   ' + r_start + '  ' + r_exit + ' ' + r_start + '  ' + r_exit + '   ' + 
                  r_start + '  ' + r_exit);
          Writeln ('        ' + r_start + '   ' + r_exit + '  ' + r_start + '  ' + r_exit + '   ' + r_start + '  ' + r_exit + 
                  '  ' + r_start + '    ' + r_exit + '    ' + r_start + '     ' + r_exit + ' ');
          WriteLn;

        end;
        Writeln ('      O F   A N C I E N T   L A N D');
        Writeln;
        Print_Formatted_Text ('A world where gods walk the earth and ancient');
        Print_Formatted_Text ('monsters lurk in the shadows of every tree.');
        Writeln;
        Print_Formatted_Text ('          2025 New Generation');
        Print_Formatted_Text ('              Version 0.95   ');
        Writeln;
        Print_Formatted_Text ('  Press [S] to start [Q] to exit to OS.');
        WriteLn;
        Writeln;

        repeat
        
          key_hit := Upcase(ReadKey);

        until (key_hit = 'S') or (key_hit = 'Q');

        case key_hit of
          
          'S': current_state := STATE_GAME;
          'Q': current_state := STATE_EXIT;
        
        end;

      end;

      STATE_GAME:
      begin
        
        current_location := LOCATION_START;
        game_over := FALSE;
        game_won := FALSE;
      
        Intro;
        
        repeat
        
          case current_location of 

            LOCATION_SACRED_GROVE:
            begin 
              Location_01; 
            end;

            LOCATION_ETERNAL_WHISPER:
            begin 
              Location_02; 
            end;

            LOCATION_CROSSROADS_OF_THORNS:
            begin 
              Location_03; 
            end;

            LOCATION_CLIFF_OF_FORGETFULNESS:
            begin 
              Location_04; 
            end;

            LOCATION_TOMB_OF_THE_GODS:
            begin 
              Location_05; 
            end;

            LOCATION_FOREST_OF_WHISPERS:
            begin 
              Location_06; 
            end;

            LOCATION_STONE_THRESHOLD:
            begin 
              Location_07; 
            end;

            LOCATION_SOUNDLESS_PASS:
            begin 
              Location_08; 
            end;

            LOCATION_LAKE: 
            begin 
              Location_09; 
            end;

            LOCATION_ISLAND:
            begin 
              Location_10; 
            end;

            LOCATION_INFINITE_STAIRCASE:
            begin 
              Location_11; 
            end;

            LOCATION_CROSSROADS_OF_SHADOWS:
            begin 
              Location_12; 
            end;

            LOCATION_GOLDEN_FIELD:
            begin 
              Location_13; 
            end;

            LOCATION_BUSHES:
            begin 
              Location_14; 
            end;

            LOCATION_START: 
            begin 
              Location_15; 
            end;

            LOCATION_MOUND_INSIDE:
            begin 
              Location_16; 
            end;

            LOCATION_ECHOES_OF_THE_ANCIENTS:
            begin 
              Location_17; 
            end;

            LOCATION_FORGOTTEN_BASIN:
            begin 
              Location_18; 
            end;

            LOCATION_FOREST_1:
            begin 
              Location_19; 
            end;

            LOCATION_STREAM:
            begin 
              Location_20; 
            end;

            LOCATION_CAVE:
            begin 
              Location_21; 
            end;

            LOCATION_MOUND:
            begin 
              Location_22; 
            end;

            LOCATION_WIND_AND_BONE_PASS:
            begin 
              Location_23; 
            end;

            LOCATION_FOREST_2:
            begin 
              Location_25; 
            end;

            LOCATION_SPRING:
            begin 
              Location_26; 
            end;

            LOCATION_ROCKS:
            begin 
              Location_27; 
            end;

            LOCATION_MORANA_CIRCLE:
            begin 
              Location_28; 
            end;

            LOCATION_LAKE_OF_SOULS:
            begin 
              Location_29; 
            end;

            LOCATION_MELT_SWAMP:
            begin 
              Location_30; 
            end;

            LOCATION_FOREST_3:
            begin 
              Location_31; 
            end;

            LOCATION_SVAROGS_STONE_CIRCLE:
            begin 
              Location_32; 
            end;

            LOCATION_THE_LESHY_VALLEY:
            begin 
              Location_33; 
            end;

            LOCATION_LAKE_NIGHT_DAY:
            begin 
              Location_34; 
            end;

            LOCATION_DARK_HARBOUR:
            begin 
              Location_35; 
            end;

            LOCATION_BLOODY_ROOTS:
            begin 
              Location_36; 
            end;
          
          end;

        until (game_over = TRUE) or (current_state <> STATE_GAME); {* REPEAT THROUGH LOCATIONS *}
        
        current_state := STATE_TITLE;
      
      end;
    
    end; {* CASE GAME STATE *}
  
  until current_state = STATE_EXIT;
  
end.