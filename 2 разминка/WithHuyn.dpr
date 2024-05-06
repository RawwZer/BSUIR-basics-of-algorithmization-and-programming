program WithHuyn;

{
  Program for coding and decoding the text
  from files from the directory
}
uses
  SysUtils, SetMatrix;

{$I 'D:\Универ\Разминки\Файлики\Loading.pas'}

// Subprogram for coding a text from given file
procedure Coding(var TextFUser: String; Bname: String);
type
  TDirection = (Up = 0, Right, Down, Left);
var
  i, j, n, k, b, centre, cycles, raws: integer;
  DClockwise, change: boolean;
  Direction, Start: TDirection;
  ResOfCycle: String;
  ResF: TextFile;
begin
  Randomize;

  // Preparation of required parameters (length of matrix,
  // its series, center; number of times to encode text)
  n := Length(TextFUser);
  raws := round(sqrt(n));
  centre := round((n + 1) / 2);
  cycles := Random(19) + 1;

  setlength(ResOfCycle, n);

  // Creating the result file
  AssignFile(ResF, Bname);
  Rewrite(ResF);

  // Choosing by random the direction (clockwise)
  // Writting value of cycles and direction to the file
  DClockwise := boolean(Random(2));
  Writeln(ResF, 'Clockwise: ', DClockwise);
  Writeln(ResF, 'Number of cycles: ', cycles);
  Writeln('Число проходов: ', cycles);

  for j := 1 to cycles do
  Begin
    // Choosing by random a start direction (TDirection)
    Direction := TDirection(Random(4));
    Start := Direction;
    ResOfCycle[1] := TextFUser[centre];
    case Direction of
      Up:
        begin
          k := centre - raws;
          Writeln(ResF, 'U');
        end;
      Right:
        begin
          k := centre + 1;
          Writeln(ResF, 'R');
        end;
      Down:
        begin
          k := centre + raws;
          Writeln(ResF, 'D');
        end;
      Left:
        begin
          k := centre - 1;
          Writeln(ResF, 'L');
        end;
    end;
    ResOfCycle[2] := TextFUser[k];
    if DClockwise then
    Begin
      If Direction <> high(TDirection) then
        inc(Direction)
      Else
        Direction := Low(TDirection)
    End
    Else
    Begin
      if Direction <> Low(TDirection) then
        dec(Direction)
      Else
        Direction := High(TDirection);
    End;
    i := 3;
    b := 1;

    // Unwind the old text 'matrix' and assign each element of this
    // 'matrix' to a new element of the new text
    While i <= n do
    begin
      // The decision of changing the direction to the next
      change := False;
      // Calculating an index of a next element of the
      // unwinding 'matrix' and checking for the change and
      // 'borders' of 'matrix'
      case Direction of
        Up:
          if (k - raws) < (centre - raws * b - b) then
            change := True
          else
            k := k - raws;
        Right:
          if (k = (centre - raws * b + b)) or (k = (centre + raws * b + b)) or
            (k = (centre + b)) then
          Begin
            change := True;
            If (Direction = Start) and (k mod raws <> 0) then
            Begin
              k := k + 1;
              ResOfCycle[i] := TextFUser[k];
              inc(i);
              inc(b);
            End;
          End
          else
            k := k + 1;
        Down:
          if ((k + raws) > (centre + raws * b + b)) then
            change := True
          else
            k := k + raws;
        Left:
          if (k = (centre - raws * b - b)) or (k = (centre + raws * b - b)) or
            (k = (centre - b)) then
          Begin
            change := True;
            If (Direction = Start) and ((k - 1) mod raws <> 0) then
            Begin
              k := k - 1;
              ResOfCycle[i] := TextFUser[k];
              inc(i);
              inc(b);
            End;
          End
          else
            k := k - 1;
      end;

      // Changing the direction to the next
      if change then
      Begin
        if DClockwise then
        Begin
          If Direction <> high(TDirection) then
            inc(Direction)
          Else
            Direction := Low(TDirection)
        End
        Else
        Begin
          if Direction <> Low(TDirection) then
            dec(Direction)
          Else
            Direction := High(TDirection);
        End;
        // If new direction is the start one (Up/Down) then inc value
        // of the turn
        If (Direction = Start) and ((Start = Down) or (Start = Up)) then
          inc(b);
      End
      else
      Begin
        // Assign the next element of the new text the
        // desired value of the old one
        ResOfCycle[i] := TextFUser[k];
        inc(i);
      End;

    end;
    // Assign new text instead of old
    TextFUser := ResOfCycle;
  End;
  // Closing the result file
  Writeln(ResF, TextFUser);
  CloseFile(ResF);
end;

// Subprorgam for decoding a text from given file
// with special format
function Decoding(FName, Bname: String): String;
type
  TDirection = (Up = 1, Right, Down, Left);
var
  i, j, n, b, k, centre, cycles, raws: integer;
  DClockwise, change: boolean;
  Direction, Start: TDirection;
  ResOfCycle, TextFUser: String;
  GavenF, ResF: TextFile;
  ArrOfDir: array of byte;
begin
{$I 'D:\Универ\Разминки\Файлики\GettingValues.pas'}
  if (IOResult <> 0) or not change then
    Writeln('Некорректный файл для декодирования!')
  Else
  Begin
    setlength(ArrOfDir, cycles);
    for i := 0 to cycles - 1 do
    Begin
      Readln(GavenF, TextFUser);
      if TextFUser = 'U' then
        ArrOfDir[i] := 1
      else if TextFUser = 'R' then
        ArrOfDir[i] := 2
      else if TextFUser = 'D' then
        ArrOfDir[i] := 3
      else if TextFUser = 'L' then
        ArrOfDir[i] := 4;
    End;

    Readln(GavenF, TextFUser);
    n := Length(TextFUser);
    raws := round(sqrt(n));
    centre := round((n + 1) / 2);
    CloseFile(GavenF);

    setlength(ResOfCycle, n);
    for j := 1 to cycles do
    Begin
      ResOfCycle[centre] := TextFUser[1];
      Direction := TDirection(ArrOfDir[cycles - j]);
      Start := Direction;
      case Direction of
        Up:
          k := centre - raws;
        Right:
          k := centre + 1;
        Down:
          k := centre + raws;
        Left:
          k := centre - 1;
      end;

      ResOfCycle[k] := TextFUser[2];
      if DClockwise then
      Begin
        If Direction <> high(TDirection) then
          inc(Direction)
        Else
          Direction := Low(TDirection)
      End
      Else
      Begin
        if Direction <> Low(TDirection) then
          dec(Direction)
        Else
          Direction := High(TDirection);
      End;
      i := 3;
      b := 1;
      // Unwind the old text 'matrix' and assign each element of this
      // 'matrix' to a new element of the new text
      While i <= n do
      begin
        // The decision of changing the direction to the next
        change := False;
        // Calculating an index of a next element of the
        // unwinding 'matrix' and checking for the change and
        // 'borders' of 'matrix'
        case Direction of
          Up:
            if (k - raws) < (centre - raws * b - b) then
              change := True
            else
              k := k - raws;
          Right:
            if (k = (centre - raws * b + b)) or (k = (centre + raws * b + b)) or
              (k = (centre + b)) then
            Begin
              change := True;
              If (Direction = Start) and (k mod raws <> 0) then
              Begin
                k := k + 1;
                ResOfCycle[k] := TextFUser[i];
                inc(i);
                inc(b);
              End;
            End
            else
              k := k + 1;
          Down:
            if ((k + raws) > (centre + raws * b + b)) then
              change := True
            else
              k := k + raws;
          Left:
            if (k = (centre - raws * b - b)) or (k = (centre + raws * b - b)) or
              (k = (centre - b)) then
            Begin
              change := True;
              If (Direction = Start) and ((k - 1) mod raws <> 0) then
              Begin
                k := k - 1;
                ResOfCycle[k] := TextFUser[i];
                inc(i);
                inc(b);
              End;
            End
            else
              k := k - 1;
        end;
        // Changing the direction to the next
        if change then
        Begin
          if DClockwise then
          Begin
            If Direction <> high(TDirection) then
              inc(Direction)
            Else
              Direction := Low(TDirection)
          End
          Else
          Begin
            if Direction <> Low(TDirection) then
              dec(Direction)
            Else
              Direction := High(TDirection);
          End;
          // If new direction is the start one (Up/Down) then inc value
          // of the turn
          If (Direction = Start) and ((Start = Down) or (Start = Up)) then
            inc(b);
        End
        else
        Begin
          // Assign the next element of the new text the
          // desired value of the old one
          ResOfCycle[k] := TextFUser[i];
          inc(i);
        End;

      end;
      // Assign new text instead of old
      TextFUser := ResOfCycle;
    End;
    // Opening, writting into and closing the result file
    AssignFile(ResF, Bname);
    Rewrite(ResF);
    Result := TextFUser;
    Writeln(ResF, TextFUser);
    CloseFile(ResF);
  End;

end;

var
  Answer, Text, TypeC, FName: String;
  WrongAnswer: boolean;

const
  BNameCode = 'coded.txt';
  BNameDecode = 'decoded.txt';
  // Default file names to save

begin
  SetCurrentDir('D:\Универ\Разминки\Файлики');
  Repeat
    Writeln('Выполнить кодирование (code) или декодирование (decode) ?');
    Readln(TypeC);
    WrongAnswer := True;
    if (TypeC = 'code') or (TypeC = 'decode') then
    begin
      Writeln('Введите имя текстового файла, располагающегося в следующей');
      Writeln('директории: "D:\Универ\Разминки\Файлики"');
      Readln(Text);
      if TypeC = 'code' then
      Begin
        Text := LoadTextFromFile(Text + '.txt');
        SetMatrixLength(Text);
        Coding(Text, BNameCode);
        Writeln('Результат кодирования:');
        FName := BNameCode;
      End
      Else if TypeC = 'decode' then
      Begin
        Text := Decoding(Text + '.txt', BNameDecode);
        Writeln('Результат декодирования:');
        FName := BNameDecode;
      End;
      // Outputting the final text without the special symbol
      Text := StringReplace(Text, '#', '', [rfReplaceAll]);
      Writeln(Text);
      WrongAnswer := False;
    end
    Else
      Writeln('Такой функции нет! Попробуйте еще раз!');

  Until not WrongAnswer;

  // If it's neccessary saving and renaming the final file
  Write('Сохранить в файл? (Y/N): ');
  Readln(Answer);
  if Answer = 'Y' then
  begin
    Writeln('Введите имя файла, под которым хотите сохранить');
    Writeln(TypeC, 'd текст (enter, если ', FName, ')');
    Readln(Answer);
    If not(Answer = '') then
      ReNameFile(FName, Answer + '.txt');
    Writeln(TypeC, 'd запись сохранена');
  End
  Else
    DeleteFile(FName);

  Readln;

end.
