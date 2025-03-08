-- View only types in Game_Board_Cell, and, view them as _incomplete_ types.
-- This will require a _full_ with in the packahe body.
limited with Game_Board_Cell;

--@summary
-- Root class of abstraction of game pieces.
--
--@description
-- Pieces are used to play the game and reside on the game board.
--
-- This is the high-level class hierarchy:
-- @image pieces_class_hierarchy.png
package Pieces is

  -- Abstract base class for a piece
  --
  --
  type Piece_Class is abstract tagged private;
  
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
  
  function Lives_On (Object : Piece_Class) return Game_Board_Cell.Cell_Class_Ptr;

  procedure Place_Piece_On (Object : in out Piece_Class ; The_Cell : Game_Board_Cell.Cell_Class_Ptr);
  
private
  
  -- To implement bi-directional relationship with Game_Board_Cell
  -- we need to store the pointer to cell this piece lives on privately.
  type Private_Data_Type;
  type Private_Data_Ptr is access all Private_Data_Type;
  
  type Piece_Class is abstract tagged record
    Private_Data : Private_Data_Ptr;
    Can_Share_Same_Location : Boolean;
  end record;
  
  
  
end Pieces;
