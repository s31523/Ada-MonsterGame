with Ada.Text_IO;
use Ada;

with Game_Board;
with Game_Controller;

with World_2D;

procedure Monster_Game is

  Move_Status : Game_Board.Move_Request_Status_Type;
  The_Move    : Game_Board.Movement_Direction;
  Quit_Game   : Boolean;

  Player_Is_Dead : Boolean;

  Game_World : World_2D.Class_Type;

begin
  Game_World.Setup_World;

  -- Setup the game board with set of pieces.
  --  Game_Controller.Setup_Game_Board;
  --
  --
  --  Game_Board.Draw;

  -- Game Play
  --   Player moves
  --   Monsters move
  --   Monsters eat player if they are on same spot as player
  --  loop
  --    Game_Controller.Get_Player_Move  (Move => The_Move,
  --                                      Quit => Quit_Game);
  --    exit when Quit_Game;
  --    Game_Board.Move_Player (Direction => The_Move,
  --                             Status   => Move_Status);
  --
  --    Text_IO.Put_Line ("Move Status:" & Move_Status'img);
  --
  --    Game_Board.Move_Monsters (Monster_Ate_Player => Player_Is_Dead);
  --
  --
  --    Game_Board.Draw;
  --
  --    if Player_Is_Dead then
  --      Text_IO.Put_Line (" Oh no!!!! You died!");
  --    end if;
  --
  --  end loop;



end Monster_Game;
