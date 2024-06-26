program ���������_��;
{
  Substracting two numbers (around 255 digits in each)
}

uses
  System.SysUtils;

var
  Num_1, Num_2, Check: shortstring;
  N, I, j, Z1, Z2, K, RankOfNum: smallint;
  L: boolean;
  ArrayOfSub: array [1 .. 255] of smallint;
  // Num_1, Num_2 - numbers, which must be substracting
  // I, J, K - auxiliary variables for counting
  // Z1, Z2 - variable of sign of numbers
  // Check - variable for keeping the value of the first number
  // ArrayOfSub - array to substract Num_1 and Num_2
  // L - variable to check for errors
  // N - the numbering system

const
  LengthA = length(ArrayOfSub) + 1;
  // LengthA - Length ArrayOfSum

begin

  // Requiring and checking the Numbering system
  Repeat
    Write('������� ������� ���������: ');
    readln(N);

    if (N < 2) or (N > 62) then
    Begin
      Writeln('');

      L := False;
    End
    Else
      L := True;

  Until L;

  // Requiring numbers
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

    if (length(Num_1) < length(Num_2)) and (Z1*Z2 = 1) then
    Begin
      Check := Num_2;
      Num_2 := Num_1;
      Num_1 := Check;

      If Z1 = 1 then
        // As we swap, then the final sign will be negative
        Check := '-'
      Else
      Begin
        Check := '.';
        Z1 := 1;
        Z2 := 1;
      End;
    End;

    if (length(Num_1) > length(Num_2)) and (Z1 = -1) and (Z2 = -1) then
      // As we swap, then the final sign will be negative
      Check := '-';

    j := length(Num_1);

    // Trying convert string of the first number to array of it
    begin

      // Checking for the biggest number and adding it to array
      if (length(Num_1) = length(Num_2)) and (Z1 = 1) and (Z2 = 1) then
      Begin
        Repeat
          I := I + 1;

          // Cheking for right symbols
          if (ord(Num_1[i]) < 48) or
            ((ord(Num_1[i]) >= 58) and (ord(Num_1[i]) <= 64)) then
          Begin
            Writeln('�� ����� �������� ������! ���������� ��� ���');

            L := False;
          End
          Else
            L := True;
        Until (ord(Num_1[I]) < ord(Num_2[I])) or (I = length(Num_1));

        if I < length(Num_1) then
        Begin
          Check := Num_1;
          Num_1 := Num_2;
          Num_2 := Check;

          // As we swap, then the final sign will be negative
          Check := '-';
        End;
      End;

      j := length(Num_1);

      for I := (LengthA - 1) downto (LengthA - length(Num_1)) do
      Begin
        // Adding digits of the first number
        // as like they are in 10th numbering system
        if ord(Num_1[j]) <= 57 then
          ArrayOfSub[I] := ord(Num_1[j]) - 48
        Else
          ArrayOfSub[I] := ord(Num_1[j]) - 55;

        j := j - 1;
      End;

      L := True;
    end;
  Until L;

  j := length(Num_2);
  I := (LengthA - 1);

  While I >= (LengthA - length(Num_2)) do
  Begin

    // A new rank of the sub
    If ArrayOfSub[I] = -N then
    Begin
      ArrayOfSub[I] := 0;
      ArrayOfSub[I-1] := ArrayOfSub[I-1] - 1;
    End;
    If ArrayOfSub[I] = N then
    Begin
      ArrayOfSub[I] := 0;
      ArrayOfSub[I-1] := ArrayOfSub[I-1] + 1;
    End;

    // If the second number isn't over
    If j <> 0 then
    begin

      // as like digits of the second number are
      // in 10th numbering system
      if ord(Num_2[j]) <= 57 then
        RankOfNum := ord(Num_2[j]) - 48
      Else
        RankOfNum := ord(Num_2[j]) - 55;

      // If we need to get a rank from the next one
      If (ArrayOfSub[I] < RankOfNum) and (Z2 = 1) and (Z1 = 1) then
      Begin

        // if the next on is zero  and we again need a rank
        if ArrayOfSub[I-1] = 0 then
        Begin

          // Trying to find the rank, which isn't zero
          while (ArrayOfSub[I-K] <= 0) and
            ((LengthA-I+K+1) <= length(Num_1)) do
          Begin
            K := K + 1;
            ArrayOfSub[I-K] := ArrayOfSub[I-K] - 1;
            ArrayOfSub[I+1-K] := ArrayOfSub[I+1-K] + N;
          End;
        End
        Else
        Begin

          // Getting a rank from th next one and
          // substracting it
          ArrayOfSub[I-1] := ArrayOfSub[I-1] - 1;
          ArrayOfSub[I] := ArrayOfSub[I] + N;
        End;
      End;

      ArrayOfSub[I] := Z1*ArrayOfSub[I] - Z2*RankOfNum;

      // If the digit is negative to deleting the sign
      if (I = (LengthA - length(Num_2))) and (ArrayOfSub[I] < 0) then
        Check := '-';

      j := j - 1;
    end;

    I := I - 1;
  End;

  // Recreating the sign of the numbers
  if Z1 = -1 then
    Insert('-', Num_1, 1);
  if Z2 = -1 then
    Insert('-', Num_2, 1);
  If Check = '.' then
  Begin
    Insert('-', Num_1, 1);
    Insert('-', Num_2, 1);
    Check := '';
  End;

  Write('�������� ����� ', Num_1, ' � ', Num_2, ' ����� ', Check);

  // Finding a border of length of the sub
  If length(Num_2) > length(Num_1) then
    j := (LengthA - length(Num_2))
  Else
    j := (LengthA - length(Num_1));

  if ArrayOfSub[j] = 0 then
    While (ArrayOfSub[j] = 0) and (J < (LengthA - 1)) do
      j := j + 1;

  // Outputting the sub in the required numbering system
  for I := j to (LengthA - 1) do
    if abs(ArrayOfSub[I]) <= 9 then
      Write(char((abs(ArrayOfSub[I]) + 48)))
    Else
      Write(char((abs(ArrayOfSub[I]) + 55)));

  readln;
end.
