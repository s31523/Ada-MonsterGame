--@summary
-- Obstacles are pieces that don't move and block pawns.
--
--@description
--
package Pieces.Obstacle is

  type Obstacle_Class is new Piece_Class with null record;
  
  type Obstacle_Class_Ptr is access all Obstacle_Class'Class;
  
  overriding procedure Draw ( Object : Obstacle_Class ; Length : out Natural);
  
  function Make return Obstacle_Class_Ptr;
   

end Pieces.Obstacle;
