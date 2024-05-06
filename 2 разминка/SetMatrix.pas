unit SetMatrix;

interface
procedure SetMatrixLength(var s: string);
implementation
// Subprogram for setting neccessary length
// for the text to code it
procedure SetMatrixLength(var s: string);
var
  i, n, len: integer;
Begin
  len := Length(s);
  n := round(sqrt(len));
  // The sqrt of a length must be odd as the centre
  // of 'matrix' has to be clear
  While not odd(n) or (n * n < len) do
    inc(n);

  setlength(s, n * n);
  // Fill the added length with a special symbol, which
  // will not be displayed to the user when the output
  for i := len + 1 to n * n do
    s[i] := '#';
End;

end.
