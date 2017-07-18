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


var key : char; n, b, coord1, coord2, k, x, y, x1, y1, radius, i : integer; color : word;

begin
  InitGr;
  randomize;
  SetColor(10);

  Line(1, 1, 639, 1);
  Line(639, 1, 639, 479);
  Line(639, 479, 1, 479);
  Line(1, 479, 1, 1);

  color := random(16) + 1;

  i := 20;

  x := (random(30) + 2) * 20;
  y := (random(22) + 2) * 20;

  radius := 10;

  coord1 := (random(30) + 2) * 20;
  coord2 := (random(22) + 2) * 20;


  SetFillStyle(color, color);
  SetColor(color);

  FillEllipse(x, y, radius, radius);

  key := ' ';

  n := 1;

  FillEllipse(coord1, coord2, radius, radius);

  repeat

     if ((coord1 = x1) and (coord2 = y1)){ or ((x = x1) and (y = y1))} then
       begin
         coord1 := (random(30) + 2) * 20;
         coord2 := (random(22) + 2) * 20;
         SetFillStyle(color, color);
         SetColor(color);
         FillEllipse(coord1, coord2, radius, radius);
         n := n + 1;
       end;

     x1 := x;
     y1 := y;

     key := readkey;

     if(key = 'w') then
       begin
         y := y - i;
       end;
     if(key = 's') then
       begin
         y := y + i;
       end;
     if(key = 'a') then
       begin
         x := x - i;
       end;
     if(key = 'd') then
       begin
         x := x + i;
       end;

     SetFillStyle(color, color);
     SetColor(color);

     FillEllipse(x, y, radius, radius);

     SetFillStyle(0, 0);
     SetColor(0);

     FillEllipse(x1, y1, radius, radius);


   until key = 'q';

  CloseGraph;
end.