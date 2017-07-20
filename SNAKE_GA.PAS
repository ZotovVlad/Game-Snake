program Snake_Game;

uses Crt, Graph, UCircle;

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
   userChoise : char;

   snakeWidth, mealCircleRadius, snakeHeadCircleRadius : integer;
   snakePatternStyle, mealPatternStyle : word;

   step : integer;

   snakeColor, mealColor : word;

   borderColor : word;
   headCoordX, headCoordY : integer;
   mealCoordX, mealCoordY : integer;
   pHeadCircle, pMealCircle : tCircle;

begin
  InitGr;
  randomize;

  borderColor := 10;
  SetColor(borderColor);

  Line(1, 1, 639, 1);
  Line(639, 1, 639, 479);
  Line(639, 479, 1, 479);
  Line(1, 479, 1, 1);

  step := 20;

  snakeWidth := 20;

  snakeHeadCircleRadius := round(snakeWidth / 2);
  mealCircleRadius := snakeHeadCircleRadius;

  userChoise := ' ';

  snakeColor := random(16) + 1;
  mealColor := random(16) + 1;
  snakePatternStyle := snakeColor;
  mealPatternStyle := mealColor;

  mealCoordX := (random(30) + 2) * 20;
  mealCoordY := (random(22) + 2) * 20;

  headCoordX := (random(30) + 2) * 20;
  headCoordY := (random(22) + 2) * 20;

  pHeadCircle := new(tCircle, create(headCoordX, headCoordY));
  pMealCircle := new(tCircle, create(mealCoordX, mealCoordY));

  SetFillStyle(snakePatternStyle, snakeColor);
  SetColor(snakeColor);

  FillEllipse(pHeadCircle^.getX, pHeadCircle^.getY, snakeHeadCircleRadius, snakeHeadCircleRadius);

  SetFillStyle(mealPatternStyle, mealColor);
  SetColor(mealColor);

  FillEllipse(pMealCircle^.getX, pMealCircle^.getY, mealCircleRadius, mealCircleRadius);

  repeat
   {
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

    userChoise := readkey;

    b := k;

    while k > 0 do
    begin

    if(userChoise = 'w') then
       begin
         a[k, 2] := a[k, 2] - step;
       end;
    if(userChoise = 's') then
       begin
         a[k, 2] := a[k, 2] + step;
       end;
    if(userChoise = 'a') then
       begin
         a[k, 1] := a[k, 1] - step;
       end;
    if(userChoise = 'd') then
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
                     }
   until userChoise = 'q';

  CloseGraph;
end.