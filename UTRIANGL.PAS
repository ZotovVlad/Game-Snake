unit UTriangle;

interface
uses Crt;

type
  tTriangle = ^Triangle;
  Triangle = object
  private x1, x2, x3 : integer;
  private y1, y2, y3 : integer;
  private color : word;

  public

  constructor createEmpty;
  constructor create(valX1,valY1,valX2,valY2,valX3,valY3 : integer;
                     valColor : word);

  function getX1 : integer;
  function getY1 : integer;
  function getX2 : integer;
  function getY2 : integer;
  function getX3 : integer;
  function getY3 : integer;
  function getColor : word;

  procedure setX1(val : integer);
  procedure setY1(val : integer);
  procedure setX2(val : integer);
  procedure setY2(val : integer);
  procedure setX3(val : integer);
  procedure setY3(val : integer);
  procedure setColor(val : word);

end;

implementation

constructor triangle.createEmpty;
begin

end;

constructor triangle.create(valX1,valY1,
                            valX2,valY2,
                            valX3,valY3 : integer;
                            valColor : word);
begin
  triangle.setX1(valX1);
  triangle.setY1(valY1);
  triangle.setX2(valX2);
  triangle.setY2(valY2);
  triangle.setX3(valX3);
  triangle.setY3(valY3);
  triangle.setColor(valColor);
end;

procedure triangle.setX1(val : integer);
begin
  x1 := val;
end;

procedure triangle.setY1(val : integer);
begin
  y1 := val;
end;

procedure triangle.setX2(val : integer);
begin
  x2 := val;
end;

procedure triangle.setY2(val : integer);
begin
  y2 := val;
end;

procedure triangle.setX3(val : integer);
begin
  x3 := val;
end;

procedure triangle.setY3(val : integer);
begin
  y3 := val;
end;

procedure triangle.setColor(val : word);
begin
  color := val;
end;


function triangle.getX1 : integer;
begin
  getX1 := x1;
end;

function triangle.getY1 : integer;
begin
  getY1 := y1;
end;

function triangle.getX2 : integer;
begin
  getX2 := x2;
end;

function triangle.getY2 : integer;
begin
  getY2 := y2;
end;

function triangle.getX3 : integer;
begin
  getX3 := x3;
end;

function triangle.getY3 : integer;
begin
  getY3 := y3;
end;

function triangle.getColor : word;
begin
  getColor := color;
end;

begin
end.