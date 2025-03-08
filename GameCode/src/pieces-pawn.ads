--@summary
-- Pawns are active participants in the game.
--
--@description
--
package Pieces.Pawn is

  -- Pawn base clase
  type Pawn_Class is abstract new Piece_Class with null record;

  type Pawn_Class_Ptr is access all Pawn_Class'Class;
  
end Pieces.Pawn;
