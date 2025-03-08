with Ada.Text_IO;
use Ada;

with World_2D;
with Game_Board;
with Grid_Cell;
with Grid_Coordinate;

package body Pieces.Pawn.Player is

  ----------
  -- Draw --
  ----------

  overriding procedure Draw (Object : Player_Class ; Length : out Natural) is
  begin
    Length := 1;
    Text_IO.Put ("P");
  end Draw;

  function Make return Player_Class_Ptr is
    New_Obj : Player_Class_Ptr := new Player_Class;
  begin
    New_Obj.Can_Share_Same_Location := True;
    return New_Obj;
  end Make;




  overriding procedure Get_Location ( Object : in out Player_Class ; World : in World_2D.Class_Type) is

    INVALID_MOVE : exception;

  begin
    -- Player pieces do not move on their own
    raise INVALID_MOVE;

  end Get_Location;



end Pieces.Pawn.Player;
