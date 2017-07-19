program Snake_Game;

uses Crt, Graph;

procedure InitGr;
var
  grDriver,grMode,ErrCode:Integer;
begin
  grDriver:=Detect;
  InitGraph(grDriver,grMode,'c:\TP\BGI');
  ErrCode:=GraphResult;
  if(ErrCode=grOk)
   then begin end
   else Writeln('Graphics error:',GraphErrorMsg(ErrCode));
end;


var
   a : array[0..100, 1..2] of integer;
   key : char;
   coord1, coord2, x, y, x1, y1, radius : integer;
   k, i, j : integer;
   b, step : integer;
   color : word;

begin
  InitGr;
  randomize;
  SetColor(10);

  Line(1, 1, 639, 1);
  Line(639, 1, 639, 479);
  Line(639, 479, 1, 479);
  Line(1, 479, 1, 1);

  step := 20;

  radius := 10;

  key := ' ';

  k := 1;

  color := random(16) + 1;

  coord1 := (random(30) + 2) * 20;
  coord2 := (random(22) + 2) * 20;

  a[1, 1] := (random(30) + 2) * 20;
  a[1, 2] := (random(22) + 2) * 20;

  SetFillStyle(color, color);
  SetColor(color);

  FillEllipse(a[1, 1], a[1, 2], radius, radius);

  FillEllipse(coord1, coord2, radius, radius);

  repeat

    if (coord1 = a[k, 1]) and (coord2 = a[k, 2]) then
       begin
         coord1 := (random(30) + 2) * 20;
         coord2 := (random(22) + 2) * 20;
         SetFillStyle(color, color);
         SetColor(color);
         FillEllipse(coord1, coord2, radius, radius);
         k := k + 1;
       end;

    b := k;

    while k > 0 do
    begin
      a[k - 1, 1] := a[k, 1];
      a[k - 1, 2] := a[k, 2];
      k := k - 1;
    end;

    k := b;

    key := readkey;

    b := k;

    while k > 0 do
    begin

    if(key = 'w') then
       begin
         a[k, 2] := a[k, 2] - step;
       end;
    if(key = 's') then
       begin
         a[k, 2] := a[k, 2] + step;
       end;
    if(key = 'a') then
       begin
         a[k, 1] := a[k, 1] - step;
       end;
    if(key = 'd') then
       begin
         a[k, 1] := a[k, 1] + step;
       end;
    k := k - 1;

    end;

    k := b;

    while b > 0 do
      begin
        SetFillStyle(color, color);
        SetColor(color);
        FillEllipse(a[b, 1], a[b, 2], radius, radius);
        b := b - 1;
      end;

    SetFillStyle(0, 0);
    SetColor(1);
    FillEllipse(a[k - 1, 1], a[k - 1, 2], radius, radius);

    b := k;

    while k > 0 do
      begin
        a[k + 1, 1] := a[k, 1];
        a[k + 1, 2] := a[k, 2];
        k := k - 1;
      end;

    k := b;

   until key = 'q';

  CloseGraph;
end.