with Screen;
with Grid_Coordinate;
  
 
--@summary
--  Maps world grid coordinates to screent coordinates
--@description
--  Utilitize to manage screen coordinates during various
--  draw operations
generic
  Row_Height : in Positive;
  Col_Width  : in Positive;
  
package Coordinate_Translations is

  -- Coordinate offset is based on the screen area defined
  -- by the row height and col height.
  subtype Offset_Range is Natural range 0 .. (Row_Height * Col_Width);
  
  type Coordinate_Type is private;
  
  -- Translates a Row,Col to an X,Y
  --
  -- Locates the first position within a defined screen area
  -- which is constrained by the Row_Height and Col_Width
  --
  procedure Transform
    ( Location   : in    Grid_Coordinate.Location_Type;
      Coordinate :   out Coordinate_Type);

  OFFSET_ERROR : exception;
  
  -- Adjust a screen point's X,Y based on an offset
  -- Computes from either the current X,Y value or
  -- the initially transformed location.
  -- Will raise exception if offset exceeds max
  procedure Adjust ( Coordinate  : in out Coordinate_Type;
                     Offset      : in     Offset_Range;
                     Use_Current : in Boolean := false);

  -- Adjust a screen point's X,Y based on an offset
  -- Computes from either the current X,Y value or
  -- the initially transformed location.
  -- Will raise exception if offset exceeds max
  -- Length used to alter Y coordinate if current X + Length
  -- exceeds Col_Width.
  -- Will raise excpetion if Length cannot be accomdated with any Col_Width
  procedure Adjust ( Coordinate  : in out Coordinate_Type;
                     Offset      : in     Offset_Range;
                     Length      : in     Offset_Range;
                     Use_Current : in Boolean := false);
  
  function Current_Point ( Coordinate : Coordinate_Type ) return Screen.Point_Type;
  
private
  type Coordinate_Type is record
    Initial_Translation : Screen.Point_Type;
    Current_Point       : Screen.Point_Type;
    Valid               : Boolean;
  end record;
  
end Coordinate_Translations;
