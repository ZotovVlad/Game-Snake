unit UCircle;

interface

uses
  UShape, Crt;

type
  TCircle = ^Circle;
  Circle = object
    x : Integer;
    y : Integer;

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
    y := val
  end;

function circle.getX : integer;
  begin
    getX := x;
  end;
function circle.getY : integer;
  begin
    getY := y;
  end;


begin
end.