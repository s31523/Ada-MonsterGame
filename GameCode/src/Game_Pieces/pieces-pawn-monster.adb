with Ada.Text_IO;
use Ada;

with Random_Generic;


package body Pieces.Pawn.Monster is

  -- Random move direction generator
  package Random_Direction is new Random_Generic (Result_Subtype => Grid_Coordinate.Compass_Direction);

  ----------
  -- Draw --
  ----------

  overriding procedure Draw
    (Object : Monster_Class;
     Length : out Natural)
  is

  begin
    if Object.Is_Full then
      Length := 4;
      Text_IO.Put ("M(P)");
    else
      Length := 1;
      Text_IO.Put ("M");
    end if;


  end Draw;

  overriding procedure Get_Location ( Object : in out Monster_Class ; World : in World_2D.Class_Type) is

    Retry_Limit       : constant := 10;
    Attempt           : Natural := 0;
    Direction_Attempt : Grid_Coordinate.Compass_Direction;
    New_Row, New_Col  : Natural;
    Success           : Boolean := False;

    MOVE_ERROR : exception;

  begin


    loop
      exit when Success or else Attempt >= Retry_Limit;
      Direction_Attempt := Random_Direction.Random_Value;
      Grid_Coordinate.Compute_Coordinates (Current   => Object.Location,
                                           Direction => Direction_Attempt,
                                           New_Row   => New_Row,
                                           New_Col   => New_Col);

      if New_Row in Grid_Coordinate.Row_Range and then New_Col in Grid_Coordinate.Col_Range then
        Success := True;
        Object.Location := (Row => New_Row, Col => New_Col);
      end if;

    end loop;

    if not Success then
      raise MOVE_ERROR;
    end if;


  end Get_Location;


  ----------
  -- Make --
  ----------

  function Make return Monster_Class_Ptr is
    New_Obj : Monster_Class_Ptr := new Monster_Class;
  begin
    New_Obj.Can_Share_Same_Location := True;
    New_Obj.Is_Full := False;
    return New_Obj;
  end Make;



end Pieces.Pawn.Monster;
