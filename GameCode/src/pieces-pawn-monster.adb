with Ada.Text_IO;
use Ada;

package body Pieces.Pawn.Monster is

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
