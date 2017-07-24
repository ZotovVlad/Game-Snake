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

procedure move(key : string; var ptriangleColor : tTriangle;modd, delta : integer);

begin

    if(Key='d')then
      begin
        ptriangleColor^.setX1(ptriangleColor^.getX1 + delta);
        ptriangleColor^.setX2(ptriangleColor^.getX2 + delta);
        ptriangleColor^.setX3(ptriangleColor^.getX3 + delta);
      end;
    if(Key='a')then
      begin
        ptriangleColor^.setX1(ptriangleColor^.getX1 - delta);
        ptriangleColor^.setX2(ptriangleColor^.getX2 - delta);
        ptriangleColor^.setX3(ptriangleColor^.getX3 - delta);
      end;
    if(Key='w')then
      begin
        ptriangleColor^.setY1(ptriangleColor^.getY1 - delta);
        ptriangleColor^.setY2(ptriangleColor^.getY2 - delta);
        ptriangleColor^.setY3(ptriangleColor^.getY3 - delta);
      end;
    if(Key='s')then
      begin
        ptriangleColor^.setY1(ptriangleColor^.getY1 + delta);
        ptriangleColor^.setY2(ptriangleColor^.getY2 + delta);
        ptriangleColor^.setY3(ptriangleColor^.getY3 + delta);
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

function greatingUser : string;
var
userChoise : string;
  begin
    writeln('Please, select triangle type from following options : ');
    writeln('1 - acute triangle');
    writeln('2 - right triangle');
    writeln('3 - obtuce triangle');

    readln(userChoise);

    greatingUser := userChoise;
  end;


function create(typeNumber : string) : tTriangle;
begin

  if(typeNumber = '1') then
    begin
      create := new(tTriangle, create(12, 2, 2, 22, 22, 22));
    end
  else if(typeNumber = '2') then
    begin
      create := new(tTriangle, create(2, 2, 22, 2, 2, 22));
    end
  else if(typeNumber = '3') then
    begin
      create := new(tTriangle, create(2, 2, 12, 22, 22, 22));
    end
  else
    begin
      writeln('Error');
      create := create(greatingUser);
    end;

end;

var gd,gm,dx : integer;
    delta : integer;
    userChoise : string;
    FillInfo : FillSettingsType;
    color, borderColor : Word;
    width, hight, sideTriangle, borderWidth, step : integer;
    shiftX, shiftY, modd : integer;
    pMeal, pTriangleColor, pTriangleBlack : tTriangle;
    snakeBody : array[0..10] of tTriangle;
    amountSegments : integer;
begin
  clrscr;
  randomize;

  delta := 20;
  InitGr;
  color := 10;
  width := 640;
  hight := 480;
  sideTriangle := 21;
  borderWidth := 1;
  step := 20;

  borderColor := 10;
  SetColor(borderColor);

  Line(1, 1, width - borderWidth, 1);
  Line(width - borderWidth, 1, width - borderWidth, hight - borderWidth);
  Line(width - borderWidth, hight - borderWidth, 1, hight - borderWidth);
  Line(1, hight - borderWidth, 1, 1);

  userChoise := '1';{greatingUser;}

  pTriangleColor := create(userChoise);

  pTriangleBlack := new(tTriangle, create
     (ptriangleColor^.getx1, ptriangleColor^.gety1,
      ptriangleColor^.getx2, ptriangleColor^.gety2,
      ptriangleColor^.getx3, ptriangleColor^.gety3)
     );


  shiftX := ((random(width - sideTriangle + borderWidth) + sideTriangle) div step) * step + 2;

  shiftY := ((random(hight - sideTriangle - borderWidth) + sideTriangle) div step) * step + 2;

  pMeal := new(tTriangle,
  create(shiftX, shiftY,
         shiftX - 20, shiftY,
         shiftX - 10, shiftY - 20));
  {Check for equality with head}


  snakeBody[0] := pTriangleColor;

  drawTriangle(snakeBody[0], color);

  if(pMeal^.getX1 = snakeBody[0]^.getX1)and
    (pMeal^.getY1 = snakeBody[0]^.getY1)and
    (pMeal^.getX2 = snakeBody[0]^.getX2)and
    (pMeal^.getY2 = snakeBody[0]^.getY2)and
    (pMeal^.getX3 = snakeBody[0]^.getX3)and
    (pMeal^.getY3 = snakeBody[0]^.getY3)
    then
      begin
        pMeal^.setX1((pMeal^.getX1 + ((random(width - sideTriangle + borderWidth) + sideTriangle) div step) * step + 2)
        mod 640);
        pMeal^.setX2((pMeal^.getX2 + ((random(width - sideTriangle + borderWidth) + sideTriangle) div step) * step + 2)
        mod 640);
        pMeal^.setX3((pMeal^.getX3 + ((random(width - sideTriangle + borderWidth) + sideTriangle) div step) * step + 2)
        mod 640);
        pMeal^.setY1((pMeal^.getY1 + ((random(hight - sideTriangle - borderWidth) + sideTriangle) div step) * step + 2)
        mod 480);
        pMeal^.setY2((pMeal^.getY2 + ((random(hight - sideTriangle - borderWidth) + sideTriangle) div step) * step + 2)
        mod 480);
        pMeal^.setY3((pMeal^.getY3 + ((random(hight - sideTriangle - borderWidth) + sideTriangle) div step) * step + 2)
        mod 480);
      end;

  drawTriangle(pMeal, color);


  repeat

    if(pMeal^.getX3 = pTriangleColor^.getX1)and
      (pMeal^.getY3 = pTriangleColor^.getY1)and
      (pMeal^.getX2 = pTriangleColor^.getX2)and
      (pMeal^.getY2 = pTriangleColor^.getY2)and
      (pMeal^.getX1 = pTriangleColor^.getX3)and
      (pMeal^.getY1 = pTriangleColor^.getY3)
    then
      begin
        pMeal^.setX1(( ((random(width - sideTriangle + borderWidth) + sideTriangle) div step) * step + 2));

        pMeal^.setX2(pMeal^.getX1 - 20);
        pMeal^.setX3(pMeal^.getX1 - 10);

        pMeal^.setY1( ((random(hight - sideTriangle - borderWidth) + sideTriangle) div step) * step + 2);

        pMeal^.setY2(pMeal^.getY1);
        pMeal^.setY3(pMeal^.getY1 - 20);

        color := random(15) + 1;

        amountSegments := amountSegments + 1;

        drawTriangle(pMeal, color);
      end;

    userChoise := ReadKey;

    modd := pTriangleColor^.getX1 * pTriangleColor^.getY1;

    changeSound(modd);


    copyTriangle(pTriangleColor, pTriangleBlack);


    move(userChoise, pTriangleColor, modd, delta);


    makeSound(modd, 50);

    changeColor(color, pTriangleColor);


    drawTriangle(pTriangleBlack, 0);

    drawTriangle(pTriangleColor, color);

  until userChoise='q';

  CloseGraph;
end.