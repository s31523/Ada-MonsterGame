--@summary
-- Players are specific kinds of pawns that represent an active participant.
--
--@description
-- Players move from cell to cell, one cell at a time trying to avoid monsters.
--
package Pieces.Pawn.Player is

  type Player_Class is new Pawn_Class with null record;
  
  type Player_Class_Ptr is access all Player_Class'Class;
  
  overriding procedure Draw ( Object : Player_Class ; Length : out Natural);

  function Make return Player_Class_Ptr;
  
end Pieces.Pawn.Player;
