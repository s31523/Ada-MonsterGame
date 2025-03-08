

with Grid_Coordinate;


--@summary
-- Root class of abstraction of game pieces.
--
--@description
-- Pieces are used to play the game and reside on the game board.
--
-- This is the high-level class hierarchy:
-- @image pieces_class_hierarchy.png
package Pieces is

   
   type Piece_Public_Attributes is abstract tagged record
     -- Location of this piece within the world.
      Location : Grid_Coordinate.Location_Type;   
   end record;
   
  -- Abstract base class for a piece
  --
  --
  type Piece_Class is abstract new Piece_Public_Attributes with private;
  
  -- Base class pointer for polymorphic variables
  type Piece_Class_Ptr is access all Piece_Class'Class;
  
  -- Draws the piece icon at the current text location.
  --
  -- Provides the length of chars in the piece.
  procedure Draw ( -- Piece instance
                   Object : Piece_Class ; 
                   
                   -- How many characters are in the piece icon.
                   Length : out Natural) is abstract;
  
  -- Provides indicator as to whether this piece precludes another piece from
  -- residing in the same location (board cell)
  function Can_Be_Only_One ( Object : Piece_Class ) return Boolean;
  
private
  
  type Piece_Class is abstract new Piece_Public_Attributes with record
    Can_Share_Same_Location : Boolean;
  end record;
  
end Pieces;
