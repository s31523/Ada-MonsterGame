with iMovable;
with World_2D;
with Grid_Coordinate;

--@summary
-- Monsters are specific kinds of pawns that represent an automatics participant.
--
--@description
-- Monsters move from cell to cell, one cell at a time trying to eat players.
--
package Pieces.Pawn.Monster is

  type Monster_Class is new Pawn_Class and iMovable.itfMovable with record
    
    -- Indicator that monster ate a player 
    Is_Full : Boolean;
    
  end record;
  
  type Monster_Class_Ptr is access all Monster_Class'Class;
  
  overriding procedure Draw ( Object : Monster_Class ; Length : out Natural);

  -- Build routine for the object
  function Make return Monster_Class_Ptr;
   
  -- Interfaces --
  overriding procedure Get_Location ( Object : in out Monster_Class ; World : in World_2D.Class_Type);

  

end Pieces.Pawn.Monster;
