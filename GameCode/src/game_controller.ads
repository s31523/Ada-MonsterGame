with Game_Board;

--@summary
-- Contains the main game logic and actions
--@desctipion
-- Provides all ways to interact with the game and perform automatic game actions
package Game_Controller is

   -- Sets up the game board for new game.
   procedure Setup_Game_Board;
  
   
  -- Get a player move request from the console
  procedure Get_Player_Move  ( Move : out Game_Board.Movement_Direction; Quit : out Boolean );
  
end Game_Controller;
