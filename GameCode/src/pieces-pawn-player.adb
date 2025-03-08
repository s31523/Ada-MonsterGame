with Ada.Text_IO;
use Ada;

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

end Pieces.Pawn.Player;
