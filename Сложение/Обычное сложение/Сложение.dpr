program ��������;
{
  Adding two numbers (around 255 digits in each)
}

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

var
  Num_1, Num_2: shortstring;
  I, j, Z1, Z2, RankOfNumber, Border: smallint;
  L: boolean;
  ArrayOfSum: array [1 .. 256] of smallint;
  // Num_1, Num_2 - numbers, which must be added
  // I, J, Border - auxiliary variables for counting
  // RunkOfNumber - intermediate value of n-digit addition of numbers
  // Z - variable of sign of number
  // ArrayOfSum - array to add Num_1 and Num_2
  // L - variable to check for errors

const
  LengthA = length(ArrayOfSum) + 1;
  // LengthA - Length ArrayOfSum

begin

  // Requiring the first number
  Repeat
    Write('������� ������ �����: ');
    readln(Num_1);

    // Checking for sign of the first number
    if Num_1[1] = '-' then
    Begin
      Delete(Num_1, 1, 1);
      Z1 := -1;
    End
    else
      Z1 := 1;

    j := length(Num_1);

    // Trying convert string of the first number to array of it
    Try
      begin

        // Inicialization from last digit to the first
        // to array element from the end of it
        for I := (LengthA - 1) downto (LengthA - length(Num_1)) do
        Begin
          ArrayOfSum[I] := Z1 * StrToInt(Num_1[j]);

          j := j - 1;
        End;

        L := True;
      end;
    except
      on e: EConvertError do
      begin
        Writeln('�� ����� �� �����! ��������� �������!');
        Writeln('');

        L := False;
      end;

    End;
  Until L;

  Repeat

    // Requiring the second number
    Write('������� ������ �����: ');
    readln(Num_2);

    // Checking for sign of the second number
    if Num_2[1] = '-' then
    Begin
      Delete(Num_2, 1, 1);
      Z2 := -1;
    End
    else
      Z2 := 1;

    j := length(Num_2);

    Try
      begin
        // Seting the border of adding digits
        Border := LengthA - length(Num_2);

        I := (LengthA - 1);

        While I >= Border do
        Begin

          // A new rank of the sum
          If ArrayOfSum[I] = 10 then
          Begin
            ArrayOfSum[I] := 0;
            ArrayOfSum[I - 1] := ArrayOfSum[I - 1] + 1;

            // Increasing border and length of the sum
            // as we have a new rank of the sum
            if I = Border then
            begin
              Border := Border - 1;
            end;

          End;

          // If the second number isn't over
          If j <> 0 then
          begin
            RankOfNumber := ArrayOfSum[I] + Z2 * StrToInt(Num_2[j]);

            // If the digit is negative to deleting the sign
            if (RankOfNumber < 0) and (I > Border) then
              RankOfNumber := -RankOfNumber;

            // A new rank of the sum
            if RankOfNumber > 9 then
            Begin
              // Increasing border as we have a new rank of the sum
              if I = Border then
                Border := Border - 1;

              // Changing the rank
              ArrayOfSum[I] := RankOfNumber - 10;
              ArrayOfSum[I - 1] := ArrayOfSum[I - 1] + 1;
            End
            Else
              ArrayOfSum[I] := RankOfNumber;

            j := j - 1;
          end;

          I := I - 1;
        End;

        L := True;
      end;

    except
      on e: EConvertError do
      begin
        Writeln('�� ����� �� �����! ��������� �������!');

        L := False;
      end;

    End;

  Until L;


  // Recreating the sign of the numbers
  if Z1 = -1 then
    Insert('-', Num_1, 1);
  if Z2 = -1 then
    Insert('-', Num_2, 1);

  Write('����� ����� ', Num_1, ' � ', Num_2, ' ����� ');

  // Finding a border of length of the sum
  If length(Num_2) > length(Num_1) then
    j := (LengthA - length(Num_2)) - 1
  Else
    j := (LengthA - length(Num_1)) - 1;

  if ArrayOfSum[j] = 0 then
    While ArrayOfSum[j] = 0 do
      j := j + 1;

  // Outputting the sum
  for I := j to (LengthA - 1) do
    Write(ArrayOfSum[I]);

  readln;

end.
