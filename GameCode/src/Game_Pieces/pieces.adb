-- Spec only has a limited view of Game_Board_Cell
-- Since we need full definition, we need full view.
with Game_Board_Cell;

package body Pieces is


  type Private_Data_Type is
   record
     My_Cell : Game_Board_Cell.Cell_Class_Ptr;
   end record;

  procedure Place_Piece_On (Object : in out Piece_Class ; The_Cell : Game_Board_Cell.Cell_Class_Ptr) is
  begin
    Object.Private_Data.My_Cell := The_Cell;
  end Place_Piece_On;

  function Can_Be_Only_One ( Object : Piece_Class ) return Boolean is
  begin
   return not Object.Can_Share_Same_Location;
  end Can_Be_Only_One;


  function Lives_On (Object : Piece_Class) return Game_Board_Cell.Cell_Class_Ptr is
  begin
    return Object.Private_Data.My_Cell;
  end Lives_On;
end Pieces;
