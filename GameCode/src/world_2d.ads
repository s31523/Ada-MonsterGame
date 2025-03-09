with Pieces;
with Grid_Cell;
with Grid_Coordinate;



--@summary
--  2-World where pieces live
--@description
-- 2-D world that creates a grid map of cells
-- each cell can contain n pieces for the game
--
-- Defines the structure and rules of the world
-- where the game entities interact.
package World_2D is

  type Class_Type is tagged private;
  
  -- Draws the current state of the board
  procedure Draw (Object : Class_Type'Class);
  
  -- Builds world and various physical world constructs, e.g. obstacles.
  procedure Setup_World (Object: in out Class_Type'class);
   
   
  -- Puts a piece into the world at its set
  -- coordinates
  procedure Place_Piece (Object: Class_Type'class ; Piece : in Pieces.Piece_Class_Ptr);

  -- Locates the grid cell at the coordinate and returns it.
  function Cell_At (Object: Class_Type'class ; Coordinate : Grid_Coordinate.Location_Type) return Grid_Cell.Cell_Class_Ptr;
    
    
private
  
  
  
    -- World is 2-D array of cells.
  type Cell_Array is array ( Grid_Coordinate.Row_Range , Grid_Coordinate.Col_Range ) of aliased Grid_Cell.Cell_Class_Ptr;

  
  type Class_Type is tagged record
    Cells : Cell_Array;
  end record;
  
    
end World_2D;
