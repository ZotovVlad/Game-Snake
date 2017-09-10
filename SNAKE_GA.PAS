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



procedure changeColor(var color : word; pTriangle : tTriangle);
begin
  color := random(14) + 1;
end;



procedure copyTriangle(var pTriangleDonor, pTriangleDestenation : ttriangle);
begin
  if (pTriangleDestenation = nil) then
  begin
     pTriangleDestenation := new(tTriangle, createEmpty);
  end;
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
                shiftX, shiftY : integer;
                step : integer;
                color : word) : tTriangle;
begin

   create := new(tTriangle, create(shiftX, shiftY,
                                   shiftX - step, shiftY,
                                   shiftX - round(step / 2),
                                   shiftY - step,
                                   color));
end;



procedure drawBorder(width, hight, borderWidth : integer);
begin
  Line(1, 1, width - borderWidth, 1);
  Line(width - borderWidth, 1, width - borderWidth, hight - borderWidth);
  Line(width - borderWidth, hight - borderWidth, 1, hight - borderWidth);
  Line(1, hight - borderWidth, 1, 1);
end;



function checkForHeadMealEquality(pMeal, pSnakeSegment :tTriangle) : boolean;
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


function snakeBodySize(snakeBody : array of tTriangle) : integer;
begin
  snakeBodySize := high(snakeBody) - low(snakeBody) + 1;
end;


procedure crawl(snake : array of tTriangle;
                key : string; modd, delta : integer);
var
  j, i, n, k: integer;
  bufTriangle, bufTriangle2 : tTriangle;
begin
  n := snakeBodySize(snake);
  i := n;
  bufTriangle := nil;
  bufTriangle2 := nil;

  while ((i <> 0) and (snake[i - 1] = nil)) do
  begin
    i := i - 1;
  end;


  if (i <> n) then { is snake full? }
  begin
    j := i - 1;
    for k := j downto 0 do
    begin
      if (bufTriangle = nil) then
      begin
        copyTriangle(snake[k], bufTriangle);
        move(key, snake[k], modd, delta);
      end
      else begin
        copyTriangle(snake[k], bufTriangle2);

        copyTriangle(bufTriangle, snake[k]);

        copyTriangle(bufTriangle2, bufTriangle);

      end;
    end;
  end;

end;



procedure generateShift(var shiftX, shiftY : integer;
                        width, hight, sideTriangle,
                        borderWidth, step : integer);
begin
  shiftX := ((random(width - sideTriangle + borderWidth) + sideTriangle)
             div step) * step + 2;

  shiftY := ((random(hight - sideTriangle - borderWidth) + sideTriangle)
             div step) * step + 2;
end;



procedure eatMeal(pMeal : tTriangle;
                  var snake : array of tTriangle;
                  var amountSegments : integer);
begin
  amountSegments := amountSegments + 1;
  snake[amountSegments] := pMeal;
end;



procedure drawSnake(snakeBody : array of tTriangle);
var
  j, buf, i, n : integer;

begin
  n := snakeBodySize(snakeBody);
  i := n;

  while snakeBody[i - 1] = nil do
  begin
    i := i - 1;
  end;

  while (i - 1 >= 0) do
  begin
    drawTriangle(snakeBody[i - 1], snakeBody[i - 1]^.getColor);
    i := i - 1;
  end;
end;



var gd,gm,dx : integer;
    delta : integer;
    millisec : integer;
    userChoise : string;
    FillInfo : FillSettingsType;
    color, borderColor, blackColor : Word;
    width, hight, sideTriangle, borderWidth, step : integer;
    shiftX, shiftY, modd : integer;
    pMeal, pColorTriangle, pBlackTriangle : tTriangle;
    snakeBody : array[0..100] of tTriangle;
    amountSegments, k : integer;
    minNormalSound, maxNormalSound : integer;

begin
  clrscr;
  randomize;
  InitGr;

  delta := 20;
  color := 10;
  blackColor := 0;
  width := 640;
  hight := 480;
  sideTriangle := 21;
  borderWidth := 1;
  step := 20;
  amountSegments := 0;
  borderColor := 10;
  minNormalSound := 200;
  maxNormalSound := 400;
  millisec := 50;

  SetColor(borderColor);

  drawBorder(width, hight, borderWidth);
  userChoise := '1';

  {greatingUser;}


  generateShift(shiftX, shiftY,
                width, hight, sideTriangle, borderWidth, step);

  pColorTriangle := create(userChoise, shiftX, shiftY, step, color);

  pBlackTriangle := new(tTriangle, create
     (pColorTriangle^.getx1, pColorTriangle^.gety1,
      pColorTriangle^.getx2, pColorTriangle^.gety2,
      pColorTriangle^.getx3, pColorTriangle^.gety3,
      blackColor)
     );

  pMeal := create(userChoise, shiftX, shiftY, step, color);

  {todo. first run always equals. fix that!!}
  while (checkForHeadMealEquality(pMeal, pColorTriangle))do
    begin
      generateShift(shiftX, shiftY,
                  width, hight, sideTriangle, borderWidth, step);
      pMeal := create(userChoise, shiftX, shiftY, step, color);
    end;

  snakeBody[amountSegments] := pBlackTriangle;
  amountSegments := amountSegments + 1;
  snakeBody[amountSegments] := pColorTriangle;

  drawTriangle(snakeBody[amountSegments], color); {todo think about}

  drawTriangle(pMeal, color);


  repeat

    userChoise := ReadKey;

    modd := random(maxNormalSound - minNormalSound) + minNormalSound;

    crawl(snakeBody, userChoise, modd, delta);


    if (checkForHeadMealEquality(pMeal, pColorTriangle))
      then
        begin
          eatMeal(pMeal, snakeBody, amountSegments);

          generateShift(shiftX, shiftY,
                width, hight, sideTriangle, borderWidth, step);

          pMeal := create(userChoise, shiftX, shiftY, step, color);
          drawTriangle(pMeal, color);
        end;

    makeSound(modd, millisec);

    changeColor(color, snakeBody[amountSegments]);

    drawSnake(snakeBody);

  until userChoise='q';

  CloseGraph;
end.