program Деление_десятичная;
{
  Dividing two numbers (around 255 digit in each)
}

uses
  System.SysUtils;

var
  Num_1, Num_2, Rez, z1, z2: shortstring;
  I, io, Count: shortint;
  k, ko, l: byte;
  j: smallint;
  Stop, ost: boolean;
  ArrayOfDiv: array [1 .. 256] of shortint;
  // Num_1, Num_2 - numbers, which must be divided
  // J, I, Io, Count, K, Ko - auxiliary variables for counting
  // Rez - result of dividing
  // Z1, z2 - variables of signs of numbers
  // ArrayOfDiv - array to divide Num_1 and Num_2
  // Stop - variable to check for errors

const
  LengthA = length(ArrayOfDiv);
  // LengthA - Length ArrayOfDiv

begin

  // Requiring the numbers and checking them for wrong
  // signs and minus
  Repeat
    Write('Введите первое число: ');
    readln(Num_1);
    if Num_1[1] = '-' then
    Begin
      Delete(Num_1, 1, 1);
      z1 := '-';
    End;

    Write('Введите второе число: ');
    readln(Num_2);

    if Num_2[1] = '-' then
    Begin
      Delete(Num_2, 1, 1);
      z2 := '-';
    End;

    if ((z1 = '-') and (z2 = '')) or ((z2 = '-') and (z1 = '')) then
      Rez := '-';

    Try
      Begin
        // Initialization from first digit to the last
        // to array element from the start of it
        for I := 1 to length(Num_1) do
          ArrayOfDiv[I] := StrToInt(Num_1[I]);

        // Checking for the wrong signs
        for I := 1 to length(Num_2) do
          StrToInt(Num_2[I]);

        Stop := true;
      End;
    except
      on e: EConvertError do
      begin
        Writeln('Вы ввели не число! Повторите попытку!');

        Stop := False;
      end;

    End;
  Until Stop;

  // Initializing the 'boarders' of substracting
  j := length(Num_2);
  io := j;

  // Increasing them, if it needs
  k := 0;
  repeat
    k := k + 1;
    if ArrayOfDiv[k] > StrToInt(Num_2[k]) then
      Stop := False;
  until not Stop or (k = j);

  if k = j then
    io := io + 1;

  k := 0;

  // Looking for the needing way of calculating
  if (length(Num_1) > length(Num_2)) or
    ((length(Num_1) = length(Num_2)) and (io = j)) then
  Begin
    I := io;

    Repeat
      Stop := False;
      // Subtraction
      repeat
        repeat
          // If we need to get a rank from the next one
          If (ArrayOfDiv[I] < StrToInt(Num_2[j])) and (I > 1) then

            // if the next on is zero and we again
            // need a rank
            if ArrayOfDiv[I - 1] = 0 then
            Begin
              ko := 1;

              While (ArrayOfDiv[I - ko] = 0) and ((I - ko) > 0) do
                ko := ko + 1;

              if I - ko > 0 then
                // Trying to find the rank, which isn't zero
                while k < ko do
                Begin
                  k := k + 1;
                  ArrayOfDiv[I - k] := ArrayOfDiv[I - k] - 1;
                  ArrayOfDiv[I + 1 - k] := ArrayOfDiv[I + 1 - k] + 10;
                End;
            End
            Else
            Begin

              // Getting a rank from the next one and
              // substracting it
              ArrayOfDiv[I - 1] := ArrayOfDiv[I - 1] - 1;
              ArrayOfDiv[I] := ArrayOfDiv[I] + 10;

            End;

          // If isn’t possible to substracting one time more
          if (ArrayOfDiv[I] < StrToInt(Num_2[j])) or
            ((ArrayOfDiv[I - j + 1] < StrToInt(Num_2[1])) and
            (ArrayOfDiv[I - j] = 0)) then
            Stop := true
          Else
          Begin
            ArrayOfDiv[I] := ArrayOfDiv[I] - StrToInt(Num_2[j]);

            // if the whole divider was subtracted
            if j = 1 then
              Count := Count + 1;
          End;

          // Going to new rank
          j := j - 1;
          I := I - 1;

          k := 0;

        until (j = 0) or Stop;

        // starting again
        j := length(Num_2);
        I := io;

      Until Stop;

      if not((Rez = '') and (Count = 0)) then
      begin
        insert(IntToStr(Count), Rez, length(Rez) + 1);
        Count := 0;
      end;

      // Updating 'borders'
      j := length(Num_2);
      io := io + 1;
      I := io;

    Until I > length(Num_1);

    Write('Частное чисел ', z1, Num_1, ' и ', z2, Num_2);
    // Finding a remainder
    j := 1;
    While (ArrayOfDiv[j] = 0) and (j < LengthA) do
      j := j + 1;

    if (j <= LengthA) and (ArrayOfDiv[j] = 0) then
      Writeln(' равно ', Rez)
    Else
    Begin
      Writeln(' (неполное) равно ', Rez);
      write('Остаток равен ');
      // Outputting the sum
      k := 1;
      io := 0;
      for I := j to length(Num_1) do
      begin
        Write(ArrayOfDiv[I]);
        ArrayOfDiv[k] := ArrayOfDiv[I];
        ArrayOfDiv[I] := 0;
        io := io + 1;
        k := k + 1;
      end;
      Writeln('');
      ost := true
    End;
  End;

  If ost or (io > j) then
  Begin
    // the pattern of dividing a smaller
    // figure by a smaller figure
    if ost then
    begin
      insert('.', Rez, length(Rez) + 1);
      io := io + 1;
      j := length(Num_2);
    end
    Else
    begin
      Rez := '0.';
      io := length(Num_1) + 1;
    end;

    Repeat
      Stop := False;
      // Subtraction
      repeat
        I := io;

        // If isn’t possible to substracting one time more
        if ArrayOfDiv[I] <= StrToInt(Num_2[j]) then
        begin

          ko := 1;
          While (ArrayOfDiv[ko] = 0) and (ko <= io) do
            ko := ko + 1;

          if (I - ko + 1 <= j) or (ArrayOfDiv[io - j] < 1) then
          begin
            Stop := true;
            ko := io - j + 1;
            k := 1;
            l := 1;
            Repeat
              If ArrayOfDiv[ko] > StrToInt(Num_2[k]) then
                Stop := False
              else if ArrayOfDiv[ko] = StrToInt(Num_2[k]) then
                l := l + 1
              else
                l := l - 1;

              ko := ko + 1;
              k := k + 1;
            Until not Stop or (k >= j);

            if l = j then
              stop := false;
          end;

        end;

        if not Stop then

          repeat

            // If we need to get a rank from the next one
            if ArrayOfDiv[I] < StrToInt(Num_2[j]) then
              // if the next on is zero and we
              // again need a rank
              if ArrayOfDiv[I - 1] = 0 then
              Begin
                ko := 0;
                k := 0;

                While (ArrayOfDiv[I - ko] = 0) and ((I - ko) > 0) do
                  ko := ko + 1;

                if I - ko > 0 then
                  // Trying to find the rank, which isn't zero
                  while k < ko do
                  Begin
                    k := k + 1;
                    ArrayOfDiv[I - k] := ArrayOfDiv[I - k] - 1;
                    ArrayOfDiv[I + 1 - k] := ArrayOfDiv[I + 1 - k] + 10;
                  End;
              End
              Else
              Begin

                // Getting a rank from the next one and
                // substracting it
                ArrayOfDiv[I - 1] := ArrayOfDiv[I - 1] - 1;
                ArrayOfDiv[I] := ArrayOfDiv[I] + 10;
              End;

            if ArrayOfDiv[I] >= StrToInt(Num_2[j]) then
            Begin
              ArrayOfDiv[I] := ArrayOfDiv[I] - StrToInt(Num_2[j]);

              // if the whole divider was subtracted
              if j = 1 then
                Count := Count + 1;
            End;

            // Going to new rank
            j := j - 1;
            I := I - 1;

          until (j = 0) or Stop;

        // starting again
        j := length(Num_2);

      Until Stop;

      insert(IntToStr(Count), Rez, length(Rez) + 1);
      Count := 0;

      // Updating 'borders'
      j := length(Num_2);
      io := io + 1

    Until length(Rez) > (length(Num_2) + 5);

    Write(z1, Num_1, ' / ', z1, Num_2, ' = ', Rez);
  End;

  readln;

end.
