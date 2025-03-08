
with Ada.Text_IO;
use Ada;

with Pieces.Pawn.Monster;

with Random_Generic;

with Display;

with Screen;

package body Game_Board is


  -- Random number genarator for a Row Index.
  package Random_Row is new Random_Generic (Result_Subtype => Row_Range);

  -- Randow number genarator for a Col Index.
  package Random_Col is new Random_Generic (Result_Subtype => Col_Range);

  -- Random move direction generator
  package Random_Direction is new Random_Generic (Result_Subtype => Movement_Direction);


  -- Game board is 2-D array of cells.
  type Cell_Array is array ( Row_Range , Col_Range ) of aliased Game_Board_Cell.Cell_Class_Ptr;

  -- The Game Board
  Board_Cells : Cell_Array;


  Board_Display : Display.Display_Class;




  -- Private Draw Helpers --
  -- Draw broken up into some steps to enhance readability and maintenance


  -- Draws a row edge boundary
  --
  -- Boundary is the top and bottom edges as well as the seperators between cells.
  procedure Draw_Border ;

  -- Draws a row of cells
  --
  -- Cells are the space between borders and the column seperators.
  procedure Draw_Row (Row_Number : Row_Range);

  -- Draws any pieces that may be in a cell.
  -- Provides the number of characters drawn so that cell alignment can be maintained.
  --  procedure Draw_Pieces
  --    ( Row         : in     Row_Range ;
  --      Col         : in     Col_Range ;
  --      Chars_Drawn : out Natural);



  procedure Setup is

  begin

    Board_Display.X_Pad := 1;
    Board_Display.X_Scale := Col_Width;

    Board_Display.Y_Pad := 1;
    Board_Display.Y_Scale := Row_Height;

    Screen.Move_Cursor (X => 0,
                        Y => 0);
    for i in Row_Range loop
      Draw_Border;
      Text_IO.New_Line;

      for Board_Rows in 1 .. Row_Height loop
        Draw_Row (Row_Number => i);
        Text_IO.New_Line;

      end loop;


      for j in Col_Range loop
        Board_Cells (i, j) := Game_Board_Cell.Make (Its_Location => (Row => i , Col => j),
                                                    Height       => Row_Height,
                                                    Width        => Col_Width);


      end loop;

    end loop;
    Draw_Border;
    Text_IO.New_Line;


  end Setup;

  procedure Clear_Cell ( Cell : Game_Board_Cell.Cell_Class_Ptr );

  ----------
  -- Draw --
  ----------
  procedure Draw is
  begin
    Screen.Save_Cursor;

    for i in Row_Range loop
      for j in Col_Range loop

        Clear_Cell ( Cell => Board_Cells (i, j));

        if Board_Cells (i, j).Piece_Count > 0 then
          Screen.Move_Cursor (X => Board_Display.X (Offset => j),
                              Y => Board_Display.Y (Offset => i));


          Board_Cells(i,j).Draw;
        end if;

      end loop;
    end loop;
    Screen.Restore_Cursor;
  end Draw;

  procedure Clear_Cell ( Cell : Game_Board_Cell.Cell_Class_Ptr ) is
    Cell_Blanks : constant string ( 1 ..Col_Width ) := (others => ' ');
  begin

    for i in 1 .. Row_Height loop
      Screen.Move_Cursor (X => Board_Display.X (Offset => Cell.Board_Location.Col),
                          Y => Board_Display.Y (Offset => Cell.Board_Location.Row) + i - 1);
      Text_IO.Put (Cell_Blanks);
    end loop;



  end Clear_Cell;

  procedure Draw_Border is
  begin
    for i in Col_Range loop
      Text_IO.Put ("|");

      for l in 1 .. Col_Width loop
        Text_IO.Put ("-");
      end loop;
    end loop;
    Text_IO.Put ("|");


  end Draw_Border;


  -- Draws a row of cells
  procedure Draw_Row (Row_Number : Row_Range ) is

  begin
    for i in Col_Range loop
      Text_IO.Put ("|");

      -- Fill remaining column pieces with white space.
      for l in 1 .. Col_Width loop
        Text_IO.Put (" ");
      end loop;

    end loop;
    Text_IO.Put ("|");
  end Draw_Row;


  function Get_Random_Cell
    ( -- Determines if cell location to get has NO pieces in it.
      Find_Empty_Cell : Boolean := True
     ) return Game_Board_Cell.Cell_Class_Ptr is

    R : Row_Range;
    C : Col_Range;

    -- Just in case - need an out for the loop that tries to find empty cell location.
    -- Loop based on random function, which in theory could thrash and repeat indefinitely.
    Attempts     : Natural := 0;
    Max_Attempts : constant := 15;

    -- If we hit attempts to find empty cell, crash the program with this exception.
    Could_Not_Find_Empty_Cell : exception;

    -- Cell chosen through random choices.
    The_Cell : Game_Board_Cell.Cell_Class_Ptr := null ;

    use type Game_Board_Cell.Cell_Class_Ptr;

  begin

    -- Setup a dumb search loop that relies on luck and multiple random attempts to find an empty cell (when flagged to do so).
    while The_Cell = null loop
      Attempts := Attempts + 1;
      R := Random_Row.Random_Value;
      C := Random_Col.Random_Value;
      The_Cell := Board_Cells (R, C);

      -- If cell is empty and flag is set to find one that is empty, start over
      -- by null'ing the cell
      if Find_Empty_Cell and then The_Cell.Piece_Count /= 0 then
        The_Cell := null;

        -- Bail after max tries.
        if Attempts > Max_Attempts then
          raise Could_Not_Find_Empty_Cell;
        end if;

      end if;

    end loop;

    return The_Cell;

  end Get_Random_Cell;


  -- Translate the move direction into the applicable row,col index and fetch the cell (if valid location) at that spot.
  function Get_Cell
    (Current_Row : Row_Range ;
     Current_Col : Col_Range ;
     Direction   : Movement_Direction) return Game_Board_Cell.Cell_Class_Ptr is

    -- Need to use a wider integer range because addition/subtraction
    -- may push index out of bounds...
    Next_Row : Natural := Current_Row;
    Next_Col : Natural := Current_Col;

  begin

    -- Adjust indices based on direction.
    case Direction is
      when N  =>
        Next_Row := Next_Row - 1;
      when NE =>
        Next_Row := Next_Row - 1;
        Next_Col := Next_Col + 1;
      when E  =>
        Next_Col := Next_Col + 1;
      when SE =>
        Next_Row := Next_Row + 1;
        Next_Col := Next_Col + 1;
      when S  =>
        Next_Row := Next_Row + 1;
      when SW =>
        Next_Row := Next_Row + 1;
        Next_Col := Next_Col - 1;
      when W =>
        Next_Col := Next_Col - 1;
      when NW =>
        Next_Row := Next_Row - 1;
        Next_Col := Next_Col - 1;
    end case;

    -- Check proposed R,C values to see if they fit in board dimensions,
    if Next_Row in Row_Range and then Next_Col in Col_Range then
      return Board_Cells (Next_Row, Next_Col);
    else
      return null;
    end if;

  end Get_Cell;



  procedure Move_Piece
    ( From_Rom  : in      Row_Range;
      From_Col  : in      Col_Range;
      Direction : in      Movement_Direction ;
      Piece     : in      Pieces.Piece_Class_Ptr;
      Status    :    out  Move_Request_Status_Type
     ) is

    -- Cell to move player to.
    New_Cell : Game_Board_Cell.Cell_Class_Ptr;

    use type Game_Board_Cell.Cell_Class_Ptr;
    use type Pieces.Piece_Class_Ptr;

  begin
    -- Attempt to get a new cell to move to based on desired direction.
    New_Cell := Get_Cell (Current_Row => From_Rom,
                          Current_Col => From_Col,
                          Direction   => Direction);

    -- If new cell is null, the requested move is not valid.
    if New_Cell = null then
      -- Put the player back onto the starting cell.
      Board_Cells (From_Rom, From_Col).Add_Piece (Piece);
      Status := Invalid;

    else
      -- Move is within the board dimensions, check if the cell can accept a new piece
      if New_Cell.Piece_Can_Be_Added then
        -- Put the player onto the new cell.
        New_Cell.Add_Piece (Piece);
        Status := Valid;

      else
        -- Put the player back onto the starting cell.
        Board_Cells (From_Rom, From_Col).Add_Piece (Piece);
        Status := Invalid;

      end if;
    end if;

  end Move_Piece;




  procedure Move_Player
    ( Direction : in     Movement_Direction ;
      Status    :    out Move_Request_Status_Type
     ) is


    -- Vars for indices of player location
    Player_R : Row_Range;
    Player_C : Col_Range;

    -- Player piece (in generic base class form)
    Piece    : Pieces.Piece_Class_Ptr;

    use type Game_Board_Cell.Cell_Class_Ptr;
    use type Pieces.Piece_Class_Ptr;

  begin


    -- Find Player --
    -- Visit each board cell, looking for a player tag --


    -- Setup start indices
    Player_R := Row_Range'First;
    Player_C := Col_Range'First;

    loop
      -- Assume pre-condition is board has player...
      exit when Board_Cells (Player_R, Player_C).Get_Piece (Piece_Tag => Pieces.Pawn.Player.Player_Class'Tag,
                                                            Remove    => True,
                                                            Piece     => Piece) or else
        (Player_R = Row_Range'Last and Player_C = Col_Range'Last);

      -- Manage row,col indexing...
      if Player_C = Col_Range'Last then
        Player_R := Player_R + 1 ;
        Player_C := Col_Range'First;
      else
        Player_C := Player_C + 1;
      end if;

    end loop;
    -- End Find Player

    -- If piece is null there is no player pawn on the board.
    if Piece = null then
      -- No player piece on the board.
      Status := Invalid;
      Text_IO.Put_Line ("Cannot move a player piece that is not on the board!");
    else
      -- Attempt the move.
      Move_Piece (From_Rom  => Player_R,
                  From_Col  => Player_C,
                  Direction => Direction,
                  Piece     => Piece,
                  Status    => Status);

    end if;

  end Move_Player;



  -- Deploys a movement straetgy
  procedure Move_Monsters
    ( Monster_Ate_Player : out Boolean ) is

    -- Monster piece (in generic base class form)
    Monster_Piece    : Pieces.Piece_Class_Ptr;

    -- Player piece (in generic base class form)
    Player_Piece     : Pieces.Piece_Class_Ptr;

    -- Cell where monster is or may be.
    Cell : Game_Board_Cell.Cell_Class_Ptr;

    Direction : Movement_Direction;

    Status   :  Move_Request_Status_Type;

  begin
    -- This will only move one monster from the cell if more than one are on the cell --

    -- Move over each cell, if a monster is on a cell, pick a random direction and try to move the monster there.
    Monster_Ate_Player := False;
    for R in Row_Range loop
      for C in Col_Range loop
        Cell := Board_Cells (R, C);


        -- Attempt to get a monster from the cell
        if Cell.Get_Piece (Piece_Tag => Pieces.Pawn.Monster.Monster_Class'Tag,
                           Remove    => True,
                           Piece     => Monster_Piece) then

          Direction := Random_Direction.Random_Value;
          Move_Piece (From_Rom  => R,
                      From_Col  => C,
                      Direction => Direction,
                      Piece     => Monster_Piece,
                      Status    => Status);

          -- If move occurred, update the cell where monster is now.
          if Status = Valid then
            Cell := Get_Cell (Current_Row => R,
                              Current_Col => C,
                              Direction   => Direction) ;
          end if;

          -- Attempt to get a player piece from the same cell that the monster is at.
          if Cell.Get_Piece (Piece_Tag => Pieces.Pawn.Player.Player_Class'Tag,
                             Remove    => True,
                             Piece     => Player_Piece) then

            -- "eat" the player.
            -- Need to down-cast the piece to the monster sub-class
            -- We know this is safe because the tag-based search.
            declare
              Monster : Pieces.Pawn.Monster.Monster_Class_Ptr := Pieces.Pawn.Monster.Monster_Class_Ptr (Monster_Piece);

            begin
              Monster.Is_Full := true;
              Monster_Ate_Player := true;
            end;

          end if;


        end if;

      end loop;
    end loop;

  end Move_Monsters;


end Game_Board;
