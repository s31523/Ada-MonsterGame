package body Pieces.Pawn is

   ------------------
   -- Get_Location --
   ------------------

    procedure Get_Location ( Object   : in out Pawn_Class ;
                             World    : in     World_2D.Class_Type;
                             To       : in     Grid_Coordinate.Compass_Direction ;
                             Valid    :    out Boolean ) is

    New_Row, New_Col : Natural;

  begin
    Grid_Coordinate.Compute_Coordinates
      (Current => Object.Location, Direction => To,  New_Row => New_Row, New_Col => New_Col);

    if New_Col in Grid_Coordinate.Row_Range and then New_Col in Grid_Coordinate.Col_Range then
      Valid := true;
      Object.Location := (Row => New_Row,  Col => New_Col);
    else
      Valid := false;
    end if;

  end Get_Location;

end Pieces.Pawn;
