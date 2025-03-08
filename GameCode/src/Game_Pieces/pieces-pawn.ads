with iMovable;
with World_2D;
with Grid_Coordinate;

--@summary
-- Pawns are active participants in the game.
--
--@description
--
package Pieces.Pawn is

  -- Pawn base clase
  type Pawn_Class is abstract new Piece_Class and iMovable.itfMovable with null record;

  type Pawn_Class_Ptr is access all Pawn_Class'Class;

  
  -- Interfaces --
  overriding procedure Get_Location ( Object   : in out Pawn_Class ; 
                           World    : in     World_2D.Class_Type; 
                           To       : in     Grid_Coordinate.Compass_Direction ;
                           Valid    :    out Boolean );
  
end Pieces.Pawn;
