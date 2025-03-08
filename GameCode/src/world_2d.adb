
package body World_2D is




  ----------
  -- Draw --
  ----------

  procedure Draw (Object : Class_Type'Class) is
  begin
    null;
  end Draw;

  -----------------
  -- Place_Piece --
  -----------------

  procedure Place_Piece
    (Object : Class_Type'Class; Piece : in Pieces.Piece_Class_Ptr)
  is
  begin
    Object.Cells (Piece.Location.Row , Piece.Location.Col).Add_Piece (Piece);
  end Place_Piece;

  -------------
  -- Cell_At --
  -------------

  function Cell_At
    (Object : Class_Type'Class; Coordinate : Grid_Coordinate.Location_Type)
      return Grid_Cell.Cell_Class_Ptr
  is
  begin
    return Object.Cells(Coordinate.Row,Coordinate.Col);
  end Cell_At;

end World_2D;
