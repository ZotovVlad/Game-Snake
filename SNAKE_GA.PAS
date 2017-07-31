program Snake_Game;

uses Crt, Graph, uTriangle;



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




procedure drawTriangle(pTriangle : tTriangle; col : word);
begin
  SetColor(col);
  Line(ptriangle^.getx1,ptriangle^.gety1,ptriangle^.getx2,ptriangle^.gety2);
  Line(ptriangle^.getx2,ptriangle^.gety2,ptriangle^.getx3,ptriangle^.gety3);
  Line(ptriangle^.getx3,ptriangle^.gety3,ptriangle^.getx1,ptriangle^.gety1);
end;




procedure move(key : string; var ptriangle : tTriangle;modd, delta : integer);
begin
    if(Key='d')then
      begin
        ptriangle^.setX1(ptriangle^.getX1 + delta);
        ptriangle^.setX2(ptriangle^.getX2 + delta);
        ptriangle^.setX3(ptriangle^.getX3 + delta);
      end;
    if(Key='a')then
      begin
        ptriangle^.setX1(ptriangle^.getX1 - delta);
        ptriangle^.setX2(ptriangle^.getX2 - delta);
        ptriangle^.setX3(ptriangle^.getX3 - delta);
      end;
    if(Key='w')then
      begin
        ptriangle^.setY1(ptriangle^.getY1 - delta);
        ptriangle^.setY2(ptriangle^.getY2 - delta);
        ptriangle^.setY3(ptriangle^.getY3 - delta);
      end;
    if(Key='s')then
      begin
        ptriangle^.setY1(ptriangle^.getY1 + delta);
        ptriangle^.setY2(ptriangle^.getY2 + delta);
        ptriangle^.setY3(ptriangle^.getY3 + delta);
      end;
end;



procedure changeColor(var col : word; ptriangle : ttriangle);
begin

  col := ptriangle^.getx1
         + ptriangle^.getx2
         + ptriangle^.getx3
         + ptriangle^.gety1
         + ptriangle^.gety2
         + ptriangle^.gety3;

    if (col mod 16 = 0) then
       begin
            col := col + 4;
       end;
end;



procedure changeSound(var modd : integer);
begin
  if (modd > 350) then
    begin
      modd := modd mod 350;
    end;
    if (modd < 200) then
    begin
      modd := 284;
    end;
end;



procedure copyTriangle(var pTriangleDonor, pTriangleDestenation : ttriangle);
begin
  pTriangleDestenation^.setX1(pTriangleDonor^.getX1);
  pTriangleDestenation^.setX2(pTriangleDonor^.getX2);
  pTriangleDestenation^.setX3(pTriangleDonor^.getX3);
  pTriangleDestenation^.setY1(pTriangleDonor^.getY1);
  pTriangleDestenation^.setY2(pTriangleDonor^.getY2);
  pTriangleDestenation^.setY3(pTriangleDonor^.getY3);
end;



procedure makeSound(modd : Integer; millisec : Word);
begin
  sound(modd);
  delay(millisec);
  nosound;
end;



function greetingUser : string;
var
  userChoise : string;
begin
  writeln('Please, select triangle type from following options : ');
  writeln('1 - acute triangle');
  writeln('2 - right triangle');
  writeln('3 - obtuce triangle');

  readln(userChoise);

  greetingUser := userChoise;
end;



function create(typeNumber : string;
                shiftX, shiftY : integer
                step : integer) : tTriangle;
begin

  if(typeNumber = '1') then
    begin
      create := new(tTriangle, create(shiftX, shiftY,
                                      shiftX - step, shiftY,
                                      shiftX - (step / 2) , shiftY - step));
    end
  else if(typeNumber = '2') then
    begin
      create := new(tTriangle, create(shiftX, shiftY,
                                      shiftX - step, shiftY,
                                      shiftX, shiftY - step));
    end
  else if(typeNumber = '3') then
    begin
      create := new(tTriangle, create(shiftX, shiftY,
                                      shiftX - (step / 2), shiftY,
                                      shiftX - step, shiftY - step));
    end
  else
    begin
      writeln('Error');
      create := create(typeNumber);
    end;

end;



procedure drawBorder(width, high, borderWidth : integer)
begin
  Line(1, 1, width - borderWidth, 1);
  Line(width - borderWidth, 1, width - borderWidth, hight - borderWidth);
  Line(width - borderWidth, hight - borderWidth, 1, hight - borderWidth);
  Line(1, hight - borderWidth, 1, 1);
end;



function checkForHeadMealEquality(pMeal, pSnakeSegment :tTriangle;
                                   screenWidth, screenHeight,
                                   sideTriangle,
                                   borderWidth,
                                   step : integer) : boolean;
begin
  if(pMeal^.getX1 = pSnakeSegment^.getX1)and
    (pMeal^.getY1 = pSnakeSegment^.getY1)and
    (pMeal^.getX2 = pSnakeSegment^.getX2)and
    (pMeal^.getY2 = pSnakeSegment^.getY2)and
    (pMeal^.getX3 = pSnakeSegment^.getX3)and
    (pMeal^.getY3 = pSnakeSegment^.getY3)
    then
      begin
        checkForHeadMealEquality := true;
      end
    else
      begin
        checkForHeadMealEquality := false;
      end;

end;



procedure crawl(snake : array of tTriangle;
                key : string; modd, delta : integer)
var
  j, buf : integer;
begin
  int i := n;
  while snake[i] = nil do
  begin
    i := i - 1;
  end;

  move(key, snake[i], modd, delta);

  j := i - 1;
  if (j <> n) then
  begin
    for j := 0 downto j do
    begin
      if (j <> 0)
      begin
        snake[j + 1] := snake[j];
      end;
    end;
  end;

end;



procedure generateShift(var shiftX, shiftY : integer;
                        width, hight, sideTriangle,
                        borderWidth, step : integer)
begin
  shiftX := ((random(width - sideTriangle + borderWidth) + sideTriangle)
             div step) * step + 2;

  shiftY := ((random(hight - sideTriangle - borderWidth) + sideTriangle)
             div step) * step + 2;
end;



procedure eatMeal(pMeal : tTriangle; var amountSegments : integer)
begin
  amountSegments := amountSegments + 1;
  drawTriangle(pMeal, random(14) + 1);
end;



procedure drawSnake(snakeBody : array tTriangle)
begin

end;



var gd,gm,dx : integer;
    delta : integer;
    userChoise : string;
    FillInfo : FillSettingsType;
    color, borderColor : Word;
    width, hight, sideTriangle, borderWidth, step : integer;
    shiftX, shiftY, modd : integer;
    pMeal, pColorTriangle, pBlackTriangle : tTriangle;
    snakeBody : array[0..100] of tTriangle;
    amountSegments, k : integer;

begin
  clrscr;
  randomize;
  InitGr;

  delta := 20;
  color := 10;
  width := 640;
  hight := 480;
  sideTriangle := 21;
  borderWidth := 1;
  step := 20;
  amountSegments := 0;
  borderColor := 10;

  SetColor(borderColor);

  drawBorder(width, high, borderWidth);

  userChoise := '1';

  {greatingUser;}


  generateShift(shiftX, shiftY,
                width, hight, sideTriangle, borderWidth, step);

  pColorTriangle := create(userChoise, shiftX, shiftY);

  pBlackTriangle := new(tTriangle, create
     (pColorTriangle^.getx1, pColorTriangle^.gety1,
      pColorTriangle^.getx2, pColorTriangle^.gety2,
      pColorTriangle^.getx3, pColorTriangle^.gety3)
     );

  pMeal := create(userChoise, shiftX, shiftY);

  while (checkForHeadMealEquality(pMeal, pColorTriangle, width, hight,
                           sideTriangle, borderWidth, step)) do
  begin
    generateShift(shiftX, shiftY,
                width, hight, sideTriangle, borderWidth, step);
    pMeal := create(userChoise, shiftX, shiftY);
  end;

  snakeBody[0] := pColorTriangle;

  drawTriangle(snakeBody[0], color); {todo think about}

  drawTriangle(pMeal, color);


  repeat

    userChoise := ReadKey;

    modd := snakeBody[amountSegments]^.getX1 *
            snakeBody[amountSegments]^.getY1;   {todo random}

    crawl(snakeBody, userChoise, modd, delta);

    drawSnake(snakeBody);

    if (checkForHeadMealEquality(pMeal, snakeBody,
                             width, hight,
                             sideTriangle,
                             borderWidth,
                             step))
    then
      begin
        eatMeal(pMeal, amountSegments);
      end;

    k := amountSegments;



    changeSound(modd);
    makeSound(modd, 50);

    changeColor(color, snakeBody[amountSegments]);

    drawTriangle(snakeBody[-1], 0);

    k := amountSegments;
    while amountSegments > -1 do
      begin
        drawTriangle(snakeBody[amountSegments], color);
        amountSegments := amountSegments - 1;
      end;
    amountSegments := k;

  until userChoise='q';

  CloseGraph;
end.