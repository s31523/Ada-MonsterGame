with Pieces.Pawn.Player;
with Game_Board_Cell;

package Game_Board is

  -- Dimensions of game board - Rows
  Num_Rows : constant := 5 ;
  
  -- Dimensions of game board - Columns
  Num_Cols : constant := 5 ;

  -- Index range for Rows on the board.
  subtype Row_Range is Positive range 1 .. Num_Rows;
  
  -- Index range for Columns on the board
  subtype Col_Range is Positive range 1 .. Num_Cols;

  -- Total number of cells on the board.
  Total_Cells : constant := Num_Rows * Num_Cols;

    -- Dimensions of 'cells' - height
  Row_Height : constant := 2 ;

  -- Dimensions of 'cells' - column width
  Col_Width  : constant := 5 ;

  -- Arranges game board into its appropriate configuration. 
  procedure Setup;
  
  
  -- Draws the current state of the board
  procedure Draw;

  -- Request to move is validated by rules.
  --
  -- Enumeration used to provide additional reasons for why move request is invalid.
  --
  -- It is assumed that movement requests are tied to direct user requests which need to 
  -- be validated. So a certain additional degree of robustnesss is expected.
  type Move_Request_Status_Type is
    ( Valid ,
      Invalid );
  
  
  -- Single cell movement direction.
  --
  -- Movement details:
  --  |---|---|---|
  --  | NW| N |NE |
  --  |---|---|---|
  --  | W | + | E |
  --  |---|---|---|
  --  | SW| S |SE |
  --  |---|---|---|
  type Movement_Direction is
  ( N,NE,E,SE,S,SW,W,NW );
  
  -- Request to move The Player (assumes one)
  --
  -- Board knows where the player is. Request is
  -- checked against valid moves.
  --
  -- Valid moves include:
  --  Open spaces and into pieces that can co-locate (two or more pieces that all can co-locate)
  -- Invalid moves include:
  --  Move into a border or obstacle.
  procedure Move_Player
    
    ( Direction : in     Movement_Direction ;
      Status    :    out Move_Request_Status_Type
     );

  
  -- Deploys a movement straetgy 
  procedure Move_Monsters
    ( Monster_Ate_Player : out Boolean );
  
  
  -- Returns the game board cell of a random location
  function Get_Random_Cell 
    ( -- Determines if cell location to get has NO pieces in it.
      Find_Empty_Cell : Boolean := True )
     return Game_Board_Cell.Cell_Class_Ptr;
  

  
end Game_Board;
