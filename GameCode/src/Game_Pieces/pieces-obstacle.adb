with Ada.Text_IO;
use Ada;

package body Pieces.Obstacle is

  ----------
  -- Draw --
  ----------

  overriding procedure Draw
    (Object : Obstacle_Class;
     Length : out Natural)
  is

  begin
    Length := 1 ;
    Text_IO.Put ("#");
  end Draw;

  ----------
  -- Make --
  ----------

  function Make return Obstacle_Class_Ptr is
    New_Obj : Obstacle_Class_Ptr := new Obstacle_Class;
  begin
    New_Obj.Can_Share_Same_Location := False;
    return New_Obj;
  end Make;

end Pieces.Obstacle;
