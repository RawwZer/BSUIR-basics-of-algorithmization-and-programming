program Произведение;
{
  Multiplying two numbers (around 126 digit in each)
}

uses
  System.SysUtils;

var
  Num_1, Num_2: shortstring;
  N, K, I, j, Z1, Z2, RankOfNum, Border: smallint;
  L: boolean;
  ArrayOfSum: array [1 .. 256] of shortint;
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

            // A new rank of the sum
            If ArrayOfSum[I] = 10 then
            Begin
              ArrayOfSum[I] := 0;
              ArrayOfSum[I - 1] := ArrayOfSum[I - 1] + 1;
            End;

            RankOfNum := (Z1 * StrToInt(Num_1[N])) * (Z2 * StrToInt(Num_2[j]));

            if RankOfNum > 9 then
            Begin
              // Changing the rank
              RankOfNum := RankOfNum - 10;
              ArrayOfSum[I - 1] := ArrayOfSum[I - 1] + 1;
            End;

            ArrayOfSum[I] := ArrayOfSum[I] + RankOfNum;

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
            // A new rank of the sum
            If ArrayOfSum[I] = 10 then
            Begin
              ArrayOfSum[I] := 0;
              ArrayOfSum[I - 1] := ArrayOfSum[I - 1] + 1;
            End;

            RankOfNum := (Z1 * StrToInt(Num_1[N])) * (Z2 * StrToInt(Num_2[j]));

            If RankOfNum > 9 then
            Begin
              // Changing the rank
              RankOfNum := RankOfNum - 10;
              ArrayOfSum[I - 1] := ArrayOfSum[I - 1] + 1;
            End;

            ArrayOfSum[I] := ArrayOfSum[I] + RankOfNum;

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

  if Z1 = -1 then
    Insert('-', Num_1, 1);
  if Z2 = -1 then
    Insert('-', Num_2, 1);

  Write('Произведение чисел ', Num_1, ' и ', Num_2, ' равно ');

  // Outputting the sum
  j := 1;
  if ArrayOfSum[j] = 0 then
    While ArrayOfSum[j] = 0 do
      j := j + 1;

  for I := j to (LengthA - 1) do
    Write(ArrayOfSum[I]);

  readln;

end.
