program ��������_��;
{
  Adding two numbers (around 255 digit in each) in different
}

var
  Num_1, Num_2: shortstring;
  N, Z1, Z2, I, j, RankOfNum, Border: smallint;
  L: boolean;
  ArrayOfSum: array [1 .. 257] of smallint;
  // Num_1, Num_2 - numbers, which must be added
  // I, J, Border - auxiliary variables for counting
  // RunkOfNum - intermediate value of n-digit addition of numbers
  // Z1, Z2 - variable of sign of number
  // ArrayOfSum - array to add Num_1 and Num_2
  // L - variable to check for errors
  // N - the numbering system

const
  LengthA = length(ArrayOfSum) + 1;
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

  // Requiring the first number
  Repeat
    Write('������� ������ �����: ');
    readln(Num_1);

    if Num_1[1] = '-' then
    Begin
      Z1 := -1;
      Delete(Num_1, 1, 1)
    End
    Else
      Z1 := 1;

    j := length(Num_1);

    // Trying convert string of the first number to array of it
    // Inicialization from last digit to the first
    // to array element from the end of it
    for I := (LengthA - 1) downto (LengthA - length(Num_1)) do
    Begin

      // Cheking for right symbols
      if (ord(Num_1[j]) < 48) or
        ((ord(Num_1[j]) >= 58) and (ord(Num_1[j]) <= 64)) then
      Begin
        Writeln('�� ����� �������� ������! ���������� ��� ���');

        L := False;
      End
      Else
        L := True;

      // Adding digits of the first number
      // as like they are in 10th numbering system
      if ord(Num_1[j]) <= 57 then
        ArrayOfSum[I] := ord(Num_1[j]) - 48
      Else
        ArrayOfSum[I] := ord(Num_1[j]) - 55;

      j := j - 1;
    End;

  Until L;

  Repeat
    Repeat
      // Requiring the second number
      Write('������� ������ �����: ');
      readln(Num_2);

      if Num_2[1] = '-' then
      Begin
        if Z1 = 1 then
        Begin
          Writeln('����� ������ ���� ������ �����!');
          L := False;
        End
        Else
          L := True;

        Z2 := -1;
        Delete(Num_2, 1, 1);
      End
      Else
      Begin
        if Z1 = -1 then
        Begin
          Writeln('����� ������ ���� ������ �����!');
          L := False;
        End
        Else
          L := True;
        Z2 := 1;
      End;

    Until L;

    j := length(Num_2);

    // Seting the border of adding digits
    Border := LengthA - j;

    I := (LengthA - 1);

    While I >= Border do
    Begin

      // A new rank of the sum
      If ArrayOfSum[I] = N then
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
        // Cheking for right symbols
        if (ord(Num_2[j]) < 48) or
          ((ord(Num_2[j]) > 57) and (ord(Num_2[j]) <= 64)) then
        Begin
          Writeln('�� ����� �������� ������! ���������� ��� ���');
          I := Border;
          L := False;
        End
        Else
          L := True;
        // as like digits of the second number are
        // in 10th numbering system
        if ord(Num_2[j]) <= 57 then
          RankOfNum := ArrayOfSum[I] + (ord(Num_2[j]) - 48)
        Else
          RankOfNum := ArrayOfSum[I] + (ord(Num_2[j]) - 55);

        // A new rank of the sum
        if RankOfNum > (N - 1) then
        Begin
          // Increasing border as we have a new rank of the sum
          if I = Border then
            Border := Border - 1;

          // Changing the rank
          ArrayOfSum[I] := RankOfNum - N;
          ArrayOfSum[I - 1] := ArrayOfSum[I - 1] + 1;
        End
        Else
          ArrayOfSum[I] := RankOfNum;

        j := j - 1;
      end;

      I := I - 1;
    End;

  Until L;

  if (Z1 = -1) and (Z2 = -1) then
  Begin
    Insert('-', Num_1, 1);
    Insert('-', Num_2, 1);
    Write('����� ����� ', Num_1, ' � ', Num_2, ' ����� -')
  End
  Else
    Write('����� ����� ', Num_1, ' � ', Num_2, ' ����� ');

  // Finding a border of length of the sum
  If length(Num_2) > length(Num_1) then
    j := (LengthA - length(Num_2)) - 1
  Else
    j := (LengthA - length(Num_1)) - 1;

  if ArrayOfSum[j] = 0 then
    While ArrayOfSum[j] = 0 do
      j := j + 1;

  // Outputting the sum in the required numbering system
  for I := j to (LengthA - 1) do
    if ArrayOfSum[I] <= 9 then
      Write(char((ArrayOfSum[I] + 48)))
    Else
      Write(char((ArrayOfSum[I] + 55)));

  readln;

end.
