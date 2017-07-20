unit UCircle;

interface

uses
    Crt;

type
  TCircle = ^Circle;
  Circle = object
    x : Integer;
    y : Integer;

    constructor create(valX, valY : integer);

    procedure setX(val : integer);
    procedure setY(val : integer);

    function getX : integer;
    function getY : integer;

  end;

implementation

procedure circle.setX(val : integer);
  begin
    x := val;
  end;
procedure circle.setY(val : integer);
  begin
    y := val;
  end;

function circle.getX : integer;
  begin
    getX := x;
  end;
function circle.getY : integer;
  begin
    getY := y;
  end;

constructor circle.create(valX, valY : integer);
  begin
    circle.setX(valX);
    circle.setY(valY);
  end;

begin
end.