
package body Pieces is


  function Can_Be_Only_One ( Object : Piece_Class ) return Boolean is
  begin
   return not Object.Can_Share_Same_Location;
  end Can_Be_Only_One;

end Pieces;
