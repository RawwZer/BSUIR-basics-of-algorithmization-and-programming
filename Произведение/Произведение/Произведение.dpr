program Произведение;
{
  Multiplying two numbers (around 126 digit in each)
}

uses
  System.SysUtils;

var
  Num_1, Num_2: shortstring;
  N, K, I, j, Z1, Z2, RankOfNum: smallint;
  L: boolean;
  ArrayOfMul: array [1 .. 256] of shortint;
  // Num_1, Num_2 - numbers, which must be multiplied
  // I, J, N, K - auxiliary variables for counting
  // RunkOfNum - intermediate value of n-digit multiplying of numbers
  // Z1, Z2 - variables of signs of numbers
  // ArrayOfMul - array to multiply Num_1 and Num_2
  // L - variable to check for errors

const
  LengthA = length(ArrayOfMul) + 1;
  // LengthA - Length ArrayOfSum

begin

  Repeat
    Write('Введите первое число: ');
    readln(Num_1);

    // Checking for sign of the first number
    if Num_1[1] = '-' then
    Begin
      Delete(Num_1, 1, 1);
      Z1 := -1;
    End
    else
      Z1 := 1;

    // Requiring the second number
    Write('Введите второе число: ');
    readln(Num_2);

    // Checking for sign of the second number
    if Num_2[1] = '-' then
    Begin
      Delete(Num_2, 1, 1);
      Z2 := -1;
    End
    else
      Z2 := 1;

    Try

      I := LengthA - 1;

      // Determine the number by which the work will occur
      if length(Num_1) >= length(Num_2) then
      Begin

        For j := length(Num_2) downto 1 do
        Begin

          for N := length(Num_1) downto 1 do
          Begin
            RankOfNum := (Z1 * StrToInt(Num_1[N])) * (Z2 * StrToInt(Num_2[j]));

            if RankOfNum > 9 then
            Begin
              // Changing the rank
              ArrayOfMul[I-1] := ArrayOfMul[I-1] + (RankOfNum div 10);
              RankOfNum := RankOfNum - ((RankOfNum div 10)*10);
            End;

            ArrayOfMul[I] := ArrayOfMul[I] + RankOfNum;

            // A new rank of the sum
            If ArrayOfMul[I] > 9 then
            Begin
              ArrayOfMul[I] := ArrayOfMul[I] - ((ArrayOfMul[I] div 10)*10);
              ArrayOfMul[I-1] := ArrayOfMul[I-1] + 1;
            End;

            // Deleting the minus until we work with the first digit
            if (RankOfNum < 0) and (j > 1) then
              RankOfNum := -RankOfNum;

            I := I - 1;
          End;
          K := K + 1;
          I := LengthA - 1 - K;
        End;
      End
      Else
      Begin
        For N := length(Num_1) downto 1 do
        Begin

          for j := length(Num_2) downto 1 do
          Begin
            RankOfNum := (Z1 * StrToInt(Num_1[N])) * (Z2 * StrToInt(Num_2[j]));

            If RankOfNum > 9 then
            Begin
              // Changing the rank
              ArrayOfMul[I-1] := ArrayOfMul[I-1] + (RankOfNum div 10);
              RankOfNum := RankOfNum - ((RankOfNum div 10)*10);
            End;

            ArrayOfMul[I] := ArrayOfMul[I] + RankOfNum;

            // A new rank of the sum
            If ArrayOfMul[I] > 9 then
            Begin
              ArrayOfMul[I] := ArrayOfMul[I] - ((ArrayOfMul[I] div 10)*10);
              ArrayOfMul[I-1] := ArrayOfMul[I-1] + 1;
            End;

            // Deleting the minus until we work with the first digit
            if (RankOfNum < 0) and (N > 1) then
              RankOfNum := -RankOfNum;

            I := I - 1;
          End;
          K := K + 1;
          I := LengthA - 1 - K;
        End;
      End;

      L := true;
    except
      on e: EConvertError do
      begin
        Writeln('Вы ввели не число! Повторите попытку!');

        L := False;
      end;

    End;

  Until L;

  // Recreating the sign of the numbers
  if Z1 = -1 then
    Insert('-', Num_1, 1);
  if Z2 = -1 then
    Insert('-', Num_2, 1);

  Write('Произведение чисел ', Num_1, ' и ', Num_2, ' равно ');

  // Outputting the mul
  j := 1;
  if ArrayOfMul[j] = 0 then
    While ArrayOfMul[j] = 0 do
      j := j + 1;

  for I := j to (LengthA - 1) do
    Write(ArrayOfMul[I]);

  readln;
end.
