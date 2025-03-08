with Ada.Text_IO;
use Ada;

with Game_Board_Cell;
with Pieces.Obstacle;
with Pieces.Pawn.Monster;
with Pieces.Pawn.Player;
with Screen;

package body Game_Controller is

  ----------------------
  -- Setup_Game_Board --
  ----------------------

  procedure Setup_Game_Board is

    New_Piece : Pieces.Piece_Class_Ptr;

    Number_Of_Obstacles_To_Add : Natural;

    Cell_To_Place_Piece : Game_Board_Cell.Cell_Class_Ptr;

  begin

    Screen.Clear;

    Game_Board.Setup;

    Number_Of_Obstacles_To_Add := Game_Board.Total_Cells / 5;
    for i in 1 .. Number_Of_Obstacles_To_Add loop
      New_Piece := Pieces.Piece_Class_Ptr (Pieces.Obstacle.Make);

      Cell_To_Place_Piece := Game_Board.Get_Random_Cell (Find_Empty_Cell => True);

      Cell_To_Place_Piece.Add_Piece (Piece => New_Piece);
    end loop;

    for i in 1 .. 3 loop
      New_Piece := Pieces.Piece_Class_Ptr (Pieces.Pawn.Monster.Make);

      Cell_To_Place_Piece := Game_Board.Get_Random_Cell (Find_Empty_Cell => True);

      Cell_To_Place_Piece.Add_Piece (Piece => New_Piece);

    end loop;
    New_Piece := Pieces.Piece_Class_Ptr (Pieces.Pawn.Player.Make);

    Cell_To_Place_Piece := Game_Board.Get_Random_Cell (Find_Empty_Cell => True);

    Cell_To_Place_Piece.Add_Piece (Piece => New_Piece);


  end Setup_Game_Board;


  Move_Counter : Natural := 0;
  Number_Of_Moves_To_Display : constant := 5;
  procedure Get_Player_Move  ( Move : out Game_Board.Movement_Direction; Quit : out Boolean ) is
    Line : String ( 1 .. 20 ) := (others => ' ' );
    Last : Natural;


    Valid_Move : Boolean := false;
  begin
    if Move_Counter >= Number_Of_Moves_To_Display then
      Screen.Move_Cursor (X => 0,
                          Y => Game_Board.Num_Rows * Game_Board.Row_Height
                            -- Need to account for headers/row separators
                          + (Game_Board.Num_Rows + 1));
      Screen.Clear_From_Cursor;
      Move_Counter := 0;
    end if;


    while not Valid_Move loop
      Text_IO.Put ("Enter Player Movement Direction (N,NE,E,SE,S,SW,W,NW) or Q to quit: ");
      Text_IO.Get_Line (Item => Line , Last => Last );
      declare
      begin
        if Line ( 1 .. 1 ) = "Q" or Line ( 1 .. 1 ) = "q" then
          Quit := True;
          Text_IO.Put_Line ("Thanks for playing! Goodbye!");
        else
          Quit := False;
          Move := Game_Board.Movement_Direction'Value (Line (1 .. Last));
        end if;
        Valid_Move := true;

      exception
        when others =>
          Text_IO.Put_Line ("Bad movement entry. Try again.");
      end;

      Move_Counter := Move_Counter + 1;
    end loop;


  end Get_Player_Move;


end Game_Controller;
