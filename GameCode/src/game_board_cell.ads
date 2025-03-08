with Ada.Tags;

with Pieces;
with Location;


-- Ada 2005 
private with Ada.Containers.Doubly_Linked_Lists;

package Game_Board_Cell is

  type Cell_Class is tagged private;

  type Cell_Class_Ptr is access all Cell_Class'class;
  
  procedure Add_Piece (Object : in out Cell_Class ; Piece : Pieces.Piece_Class_Ptr);

  -- Ada 2012 Feature - function with in out / out modes
  
  -- Attempt to get a player piece from the cell.
  --
  -- Returns whether piece was found and returned
  function Get_Piece
    ( -- Object instance
      Object    : in out Cell_Class;
      
      -- Instance tag
      --
      -- Identifies the class tag to look for.
      Piece_Tag : in Ada.Tags.Tag;
      
      -- Controls whether piece should be removed from the cell or left in the cell
      Remove    : in Boolean := false;
      
        -- Piece object to return, or null if not found
      Piece     : out Pieces.Piece_Class_Ptr ) return Boolean;
                          

  -- Number of Pieces in the cell.
  function Piece_Count (Object : in Cell_Class) return Natural;
  
  -- Draws all pieces, next to each other on same line.
  procedure Draw 
    (-- Instance
     Object          : in Cell_Class);
  
  
  -- Is there another piece on this cell that precludes another piece from being placed here?
  -- E.g. an obstacle.
  function Piece_Can_Be_Added ( Object : in Cell_Class ) return Boolean;

  
  function Make 
    (-- Where the cell is on the board
     Its_Location : Location.Location_Class;
     -- Height of the Cell
     Height       : Natural;
     
     -- Width of Cell
     Width        : Natural
    ) return Cell_Class_Ptr;
  
    function Board_Location (Object : Cell_Class) return Location.Location_Class;
private

  use Ada.Containers;
  -- Need to make the pointer operators visible to instantiate list.
  use type Pieces.Piece_Class_Ptr;

  package Pieces_List_Pkg is new Doubly_Linked_Lists (Element_Type => Pieces.Piece_Class_Ptr);
  
  type Cell_Class is tagged record
    
    -- Container for all the pieces that can exist in this cell.
    Piece_List  : Pieces_List_Pkg.List;
    
    -- A cell has a location.
    My_Location : Location.Location_Class;
    
    -- Cell dimensions
    Height : Natural;
    Width  : Natural;
  end record;
  
end Game_Board_Cell;
