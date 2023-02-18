program ������������_��;
{
  Multiplying two numbers (around 126 digit in each)
}

uses
  System.SysUtils;

var
  Num_1, Num_2: shortstring;
  N, K, I, j, Z1, Z2, RankOfNum, S: smallint;
  L: boolean;
  ArrayOfMul: array [1 .. 256] of shortint;
  // Num_1, Num_2 - numbers, which must be multiplied
  // I, J, K, N - auxiliary variables for counting
  // RunkOfNum - intermediate value of n-digit multiplying of numbers
  // Z1, Z2 - variables of signs of numbers
  // ArrayOfMul - array to multiply Num_1 and Num_2
  // L - variable to check for errors
  // S - the numbering system

const
  LengthA = length(ArrayOfMul) + 1;
  // LengthA - Length ArrayOfSum

begin
  // Requiring and checking the Numbering system
  Repeat
    Write('������� ������� ���������: ');
    readln(S);

    if (S < 2) or (S > 62) then
    Begin
      Writeln('');

      L := False;
    End
    Else
      L := True;

  Until L;

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

    I := LengthA - 1;

    // Determine the number by which the work will occur
    if length(Num_1) >= length(Num_2) then
    Begin

      For j := length(Num_2) downto 1 do
        if (ord(Num_2[j]) < 48) or
          ((ord(Num_2[j]) >= 58) and (ord(Num_2[j]) <= 64)) then
        Begin
          Writeln('�� ����� �������� ������! ���������� ��� ���');

          L := False;
        End

        Else
        Begin
          for N := length(Num_1) downto 1 do
            if (ord(Num_1[N]) < 48) or
              ((ord(Num_1[N]) >= 58) and (ord(Num_1[N]) <= 64)) then
            Begin
              Writeln('�� ����� �������� ������! ���������� ��� ���');

              L := False;
            End

            Else
            Begin
              // Adding digits of the first number
              // as like they are in 10th numbering system
              if ord(Num_1[N]) <= 57 then
                RankOfNum := Z1 * (ord(Num_1[N]) - 48)
              Else
                RankOfNum := Z1 * (ord(Num_1[N]) - 55);

              if ord(Num_2[j]) <= 57 then
                RankOfNum := RankOfNum * Z2 * (ord(Num_2[j]) - 48)
              Else
                RankOfNum := RankOfNum * Z2 * (ord(Num_2[j]) - 55);

              if RankOfNum > (S-1) then
              Begin
                // Changing the rank
                ArrayOfMul[I-1] := ArrayOfMul[I-1] + (RankOfNum div S);
                RankOfNum := RankOfNum - ((RankOfNum div S) * S);
              End;

              ArrayOfMul[I] := ArrayOfMul[I] + RankOfNum;

              // A new rank of the sum
              If ArrayOfMul[I] > (S-1) then
              Begin
                ArrayOfMul[I] := ArrayOfMul[I] - ((ArrayOfMul[I] div S) * S);
                ArrayOfMul[I-1] := ArrayOfMul[I-1] + 1;
              End;

              I := I - 1;
              L := True;
            End;
          K := K + 1;
          I := LengthA - 1 - K;
        End;
    End

    Else
    Begin
      For N := length(Num_1) downto 1 do
        if (ord(Num_1[N]) < 48) or
          ((ord(Num_1[N]) >= 58) and (ord(Num_1[N]) <= 64)) then
        Begin
          Writeln('�� ����� �������� ������! ���������� ��� ���');

          L := False;
        End

        Else
        Begin
          for j := length(Num_2) downto 1 do
            if (ord(Num_2[j]) < 48) or
              ((ord(Num_2[j]) >= 58) and (ord(Num_2[j]) <= 64)) then
            Begin
              Writeln('�� ����� �������� ������! ���������� ��� ���');

              L := False;
            End

            Else
            Begin
              // Adding digits of the first number
              // as like they are in 10th numbering system
              if ord(Num_1[N]) <= 57 then
                RankOfNum := Z1 * (ord(Num_1[N]) - 48)
              Else
                RankOfNum := Z1 * (ord(Num_1[N]) - 55);
              if ord(Num_2[j]) <= 57 then
                RankOfNum := RankOfNum * Z2 * (ord(Num_2[j]) - 48)
              Else
                RankOfNum := RankOfNum * Z2 * (ord(Num_2[j]) - 55);

              if RankOfNum > (S-1) then
              Begin
                // Changing the rank
                ArrayOfMul[I-1] := ArrayOfMul[I-1] + (RankOfNum div S);
                RankOfNum := RankOfNum - ((RankOfNum div S) * S);
              End;

              ArrayOfMul[I] := ArrayOfMul[I] + RankOfNum;

              // A new rank of the sum
              If ArrayOfMul[I] > (S-1) then
              Begin
                ArrayOfMul[I] := ArrayOfMul[I] - ((ArrayOfMul[I] div S) * S);
                ArrayOfMul[I-1] := ArrayOfMul[I-1] + 1;
              End;

              I := I - 1;
              L := True;
            End;
          K := K + 1;
          I := LengthA - 1 - K;
        End;
    End;
  Until L;

  // Recreating the sign of the numbers
  if Z1 = -1 then
    Insert('-', Num_1, 1);
  if Z2 = -1 then
    Insert('-', Num_2, 1);

  Write('������������ ����� ', Num_1, ' � ', Num_2, ' ����� ');

  // Finding the start of the mul
  if length(Num_1) >= length(Num_2) then
    j := lengthA - 2*length(Num_1)
  else
    J := LengthA - 2*Length(Num_2);

  if ArrayOfMul[j] = 0 then
    While ArrayOfMul[j] = 0 do
      j := j + 1;
  If ArrayOfMul[J] < 0 then
    Write('-');

  // Outputting the mul in the required numbering system
  for I := j to (LengthA - 1) do
    if abs(ArrayOfMul[I]) <= 9 then
      Write(char((abs(ArrayOfMul[I]) + 48)))
    Else
      Write(char((abs(ArrayOfMul[I]) + 55)));

  readln;
end.
