program Бактерии;
// Calculating sum of green and red bacteria after N time cycles

{$APPTYPE CONSOLE}

uses
System.SysUtils;


var Red, Green,SumGreen, SumRed, SumGreenR, SumRedR,
    SumGreenG, SumRedG, SumAll, N, I : integer;
    R1, R2 : real;
    E, P : boolean;
    // Red, Green - amount of red and green bacteria
    // SumGreen, SumRed - sum of green and red bacteria
    // SumGreenR, SumRedR - sum of green and red bacteria (for red branch)
    // SumGreenG, SumRedG - sum of green and red bacteria (for green branch)
    // SumAll - sum of green and red bacteria together
    // N - amount of time cycles
    // I, R1, R2 - auxiliary variables
    // E - checking value

begin
// For case of overflow
Repeat
  // Requesting and obtaining the initial amount of bacteria and time cycles
  Repeat
    Try
      Write('Введите кол-во бактерий красного и зеленого');
      Writeln(' цветов соответственно: ');
      Readln(Red, Green);

      // Rerequesting and reobtaining the initial amount of bacteria
      // if amount isn't right
      While (Red <= -1) or (Green <= -1) do
        Begin
        Write('Введите кол-во бактерий красного и зеленого');
        Writeln(' цветов соответственно: ');
        Readln(Red, Green);
        // Except repeat
        E := True;
       End;

      Writeln('Введите кол-во тактов времени (до 40): ');
      Readln(N);

      // Rerequesting and reobtaining the initial amount of time
      // cycles if amount isn't right
      While (N < 0) do
        Begin
        Writeln('Введите кол-во тактов времени (до 40): ');
        Readln(N);
        // Except repeat
        E := True;
        End;

      // Except repeat
      E := True;
    except
      Writeln('Введены некорректные данные!');
      Writeln('');

      // Go to repeat
      E := False;
    End;

  Until E;

  Writeln('');
  Writeln('Идёт подсчёт числа бактерий... ');
  Writeln('');

  // Calculation of additional values (R1, R2)
  R1 := (1+sqrt(5))/2;
  R2 := (1-sqrt(5))/2;

  // Raising R2 to a power
  for I := 2 to N do
    R2 := R2 * ((1-sqrt(5))/2);

  // Calculation of sum of green and red bacteria and sum
  // of green and red bacteria together
  if Red = 0 then
    Begin
      SumGreen := round((exp((N+1)*ln(R1)) - R2*((1-sqrt(5))/2)) / sqrt(5));
      SumRed := round((exp((N)*ln(R1)) - R2) / sqrt(5));
      SumAll := (SumRed + SumGreen) * Green;
    End
  Else
    If Green = 0 then
      Begin

        SumGreen := round((exp((N)*ln(R1)) - R2) / sqrt(5));
        SumRed := round((exp((N-1)*ln(R1)) - R2/((1-sqrt(5))/2)) / sqrt(5));
        SumAll := (SumRed + SumGreen) * Red;
      End
    Else
      Begin
        // Calculation of sum of green bacteria for
        // green and red branch
        SumGreenG := round((exp((N+1)*ln(R1)) - R2*((1-sqrt(5))/2)) / sqrt(5));
        SumGreenR := round((exp((N)*ln(R1)) - R2) / sqrt(5));
        SumGreen := SumGreenG*Green + SumGreenR*Red;

        // Calculation of sum of red bacteria for
        // green and red branch
        SumRedG := round((exp((N)*ln(R1)) - R2) / sqrt(5));
        SumRedR := round((exp((N-1)*ln(R1)) - R2/((1-sqrt(5))/2)) / sqrt(5));
        SumRed := SumRedG*Green + SumredR*Red;

        // Calculation of sum of green and red bacteria
        // together for all branches
        SumAll := (SumRedR+SumGreenR)*Red + (SumRedG+SumGreenG)*Green;
      End;

  // Values output
  if (SumAll > 0) and (SumGreen > 0) and (SumRed > 0) then
    Begin
      Writeln('Количество зеленых: ', SumGreen);
      Writeln('Количество красных: ', SumRed);
      Writeln('');
      Writeln('Расчёт окончен...');
      Writeln('');
      Write('После ', N, ' тактов времени из ', Red);
      Write(' красных и ', Green, ' зеленых бактерий ');
      Writeln('образовалось ', SumAll, ' бактерий в сумме');

      // The overflow isn't here
      P:= True;
    End
  else
    Begin
    Writeln('Произошло переполнение, попробуйте значения меньше');

    // The overflow is here
    P:= False;
    readln;
    End;
    readln;
Until P;

readln;
end.
