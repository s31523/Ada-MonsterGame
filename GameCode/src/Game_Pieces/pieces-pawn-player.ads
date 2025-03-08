with iMovable;
with World_2D;
with Grid_Coordinate;

--@summary
-- Players are specific kinds of pawns that represent an active participant.
--
--@description
-- Players move from cell to cell, one cell at a time trying to avoid monsters.
--
package Pieces.Pawn.Player is

  type Player_Class is new Pawn_Class and iMovable.itfMovable with null record;
  
  type Player_Class_Ptr is access all Player_Class'Class;
  
  overriding procedure Draw ( Object : Player_Class ; Length : out Natural);

  -- Build routine for the object
  function Make return Player_Class_Ptr;

  -- Interfaces --
  overriding procedure Get_Location ( Object : in out Player_Class ; World : in World_2D.Class_Type);

  
  
  
end Pieces.Pawn.Player;
