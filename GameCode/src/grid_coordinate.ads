--@summary
--  Defines coordiate system for the world grid
--@description
--  Establishes a 2-D set of coordinates for
--  Row,Col access.
package Grid_Coordinate is

  -- Dimensions of game board - Rows
  Num_Rows : constant := 5 ;
  
  -- Dimensions of game board - Columns
  Num_Cols : constant := 5 ;

  -- Index range for Rows on the board.
  subtype Row_Range is Positive range 1 .. Num_Rows;
  
  -- Index range for Columns on the board
  subtype Col_Range is Positive range 1 .. Num_Cols;

  -- Total number of cells on the board.
  Total_Cells : constant := Num_Rows * Num_Cols;

   -- Static class
   -- No need for tagged type.
   type Location_Type is record
      Row : Row_Range;
      Col : Col_Range;
   end record;
   
   
  -- Grid Compass Direction
  --
  -- Within a grid, compass direction of adjacent cells
  --  |---|---|---|
  --  | NW| N |NE |
  --  |---|---|---|
  --  | W | + | E |
  --  |---|---|---|
  --  | SW| S |SE |
  --  |---|---|---|
  type Compass_Direction is
  ( N,NE,E,SE,S,SW,W,NW );
   
  procedure Compute_Coordinates
    ( Current   : in      Location_Type ;
      Direction : in      Compass_Direction;
      New_Row   :    out  Natural;
      New_Col   :    out  Natural);
  
  function Get_Random_Location return Location_Type;
  

end Grid_Coordinate;
