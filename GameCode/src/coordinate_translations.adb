
package body Coordinate_Translations is

  ---------------
  -- Transform --
  ---------------

  procedure Transform
    (Location   : in     Grid_Coordinate.Location_Type;
     Coordinate :    out Coordinate_Type)
  is

  begin

    -- Determine Y from Row
    Coordinate.Initial_Translation.Y
      := Location.Row * Row_Height - 1;

    Coordinate.Initial_Translation.X
      := (Location.Col - 1 ) * Col_Width + 1;
  end Transform;

  ------------
  -- Adjust --
  ------------

  procedure Adjust
    (Coordinate  : in out Coordinate_Type; Offset : in Offset_Range;
     Use_Current : in     Boolean := false)
  is
  begin
    pragma Compile_Time_Warning (Standard.True, "Adjust unimplemented");
    raise Program_Error with "Unimplemented procedure Adjust";
  end Adjust;

  ------------
  -- Adjust --
  ------------

  procedure Adjust
    (Coordinate : in out Coordinate_Type; Offset : in Offset_Range;
     Length     : in     Offset_Range; Use_Current : in Boolean := false)
  is
  begin
    pragma Compile_Time_Warning (Standard.True, "Adjust unimplemented");
    raise Program_Error with "Unimplemented procedure Adjust";
  end Adjust;

  -------------------
  -- Current_Point --
  -------------------

  function Current_Point
    (Coordinate : Coordinate_Type) return Screen.Point_Type
  is
  begin
    pragma Compile_Time_Warning
      (Standard.True, "Current_Point unimplemented");
    return raise Program_Error with "Unimplemented function Current_Point";
  end Current_Point;

end Coordinate_Translations;
