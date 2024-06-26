program Ccruchki;
// Find all word which consist � and � based on amount of line in word

{$APPTYPE CONSOLE}

Type
  Tarr = array of 0 .. 2;

  // Recursive procedure for counting string
  // Based on left number we add symbol and start new recursion
procedure FindAndCreatePermut(Amount: Integer; VarString: String;
  Var AmountOfAnswers: Integer);
// Amount - amount of last lines
// Ans - String at this time
Begin
  if (Amount = 0) then
  Begin
    Inc(AmountOfAnswers);
    Writeln(VarString);
  End
  else
  Begin
    // Adding � if it possible
    if (Amount - 2 <> 1) then
      FindAndCreatePermut(Amount - 2, VarString + '� ', AmountOfAnswers);
    // Adding � � it possible
    if (Amount - 3 > 1) or (Amount - 3 = 0) then
      FindAndCreatePermut(Amount - 3, VarString + '� ', AmountOfAnswers);
  End;
End;

// Procedure of inputting real or int Number
procedure GettingAmount(var Number: Integer);
Var
  Answer: String;
  Error: Integer;
Begin
  Repeat
    Readln(Answer);
    // using val to convert
    Val(Answer, Number, Error);
    // Checking for correct input
    if (Error <> 0) or (Number <= 1) then
      Writeln('����� ������� �������! ���������� ��� ���');

  Until (Error = 0) and (Number > 1);
End;

// Procedure of outputting mas
Procedure OutputPermut(const VarArray: Tarr);
Var
  i: Integer;
Begin
  // output � or � depend on a[i]
  for i := Low(VarArray) to High(VarArray) do
    case VarArray[i] of
      1:
        Write('� ');
      2:
        Write('� ');
    end;

  Writeln;
End;

// Procedure of sorting part of array for correct order of answers
procedure Sort(Var Arr: Tarr; const l, SizeArr: Integer);
var
  i, j: Integer;
begin
  // This procecure is simple buble sort with flag
  i := l;
  j := SizeArr;
  // Swaping element before reaching end
  while (i < j) do
  begin
    Arr[i] := Arr[i] + Arr[j];
    Arr[j] := Arr[i] - Arr[j];
    Arr[i] := Arr[i] - Arr[j];
    Inc(i);
    Dec(j);
  end;

end;

// Main procedure of reshuffling
Procedure CreatePermutation(Size: Integer; var Output: Tarr;
  Var Amount: Integer);
Var
  j: Integer;
  stop: Boolean;
Begin
  // Main idea is to find � and � near from end
  // Then swap them and sort right part of this array
  // Thats allows to get answers in alphabet order
  Repeat
    // Ouput this version of array
    OutputPermut(Output);
    Inc(Amount);
    stop := true;
    j := Size;
    // Searching for � and �
    While (j > Low(Output)) and (Output[j] <= Output[j - 1]) do
      Dec(j);

    // If it exists then swap and reshuffle
    if (j <> Low(Output)) then
      stop := false;
    if (j > Low(Output)) and (Output[j] > Output[j - 1]) then
    Begin
      Output[j] := 1;
      Output[j - 1] := 2;
      if j + 1 < Size then
        Sort(Output, j + 1, Size);
    End;

  Until stop;

  for j := Low(Output) to High(Output) do
    Output[j] := 0;
End;

Var
  Answer: Integer;
  i, j, k: Integer;
  VarOfLetters: Tarr;
  NumberOfCr: Integer;
  Variant: String;

  {
    n - amount of lines
    s - answer
    variants - amount of answers
  }
begin
  Writeln('������� ���������� �������: ');
  GettingAmount(NumberOfCr);
  // Preparetion before cycle
  Variant := '';
  Answer := 0;
  FindAndCreatePermut(NumberOfCr, Variant, Answer);
  Write('���������� ��������� (��������): ');
  Writeln(Answer);
  Writeln;

  // Starting with 0 � and as much � as possible
  j := 0;
  SetLength(VarOfLetters, NumberOfCr div 2);
  i := (NumberOfCr - 3 * j) div 2;
  Answer := 0;
  While (i >= 0) do
  Begin
    // Fullfillng array
    // 1 - �
    // 2 - �
    if not odd(NumberOfCr - 3 * j) then
    Begin
      for k := 0 to i - 1 do
        VarOfLetters[k] := 1;
      for k := 0 to j - 1 do
        VarOfLetters[i + k] := 2;
      // Reshuffle for this combination
      CreatePermutation(i + j - 1, VarOfLetters, Answer);
    End;
    Inc(j);
    i := (NumberOfCr - 3 * j) div 2;
  End;
  Write('���������� ��������� (��������): ');
  Writeln(Answer);

  Readln;

end.
