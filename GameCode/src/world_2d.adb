with Ada.Text_IO;
with Display;
with Pieces.Obstacle;
with Screen;

use Ada;
package body World_2D is

    -- Dimensions of 'cells' - height
  Row_Height : constant := 2 ;

  -- Dimensions of 'cells' - column width
  Col_Width  : constant := 5 ;


  -- Draws a row edge boundary
  --
  -- Boundary is the top and bottom edges as well as the seperators between cells.
  procedure Draw_Border ;

  -- Draws a row of cells
  --
  -- Cells are the space between borders and the column seperators.
  procedure Draw_Row (Row_Number : Grid_Coordinate.Row_Range);

  -- Draws an empty world which is only drawn once.
  procedure Draw_Initial_World;


  ----------
  -- Draw --
  ----------

  procedure Draw (Object : Class_Type'Class) is
  begin
    null;
  end Draw;

  -----------------
  -- Place_Piece --
  -----------------

  procedure Place_Piece
    (Object : Class_Type'Class; Piece : in Pieces.Piece_Class_Ptr)
  is
  begin
    Object.Cells (Piece.Location.Row , Piece.Location.Col).Add_Piece (Piece);
  end Place_Piece;


  procedure Setup_World (Object: in out Class_Type'class) is

    Obstacles_To_Create : constant := Grid_Coordinate.Total_Cells / 5;

    New_Obstacle : Pieces.Obstacle.Obstacle_Class_Ptr;

  begin
    for Row in Grid_Coordinate.Row_Range loop
      for Col in Grid_Coordinate.Col_Range loop
        Object.Cells(Row,Col) := Grid_Cell.Make;
      end loop;
    end loop;

    for i in 1 .. Obstacles_To_Create loop
      New_Obstacle := Pieces.Obstacle.Make;

      New_Obstacle.Location := Grid_Coordinate.Get_Random_Location;
      Object.Cells (New_Obstacle.Location.Row , New_Obstacle.Location.Col).Add_Piece (Pieces.Piece_Class_Ptr(New_Obstacle));
    end loop;

    Draw_Initial_World;

  end Setup_World;


  procedure Draw_Initial_World is
  begin
    Screen.Clear;
    Screen.Move_Cursor (X => 0,
                        Y => 0);
    for i in Grid_Coordinate.Row_Range loop
      Draw_Border;
      Text_IO.New_Line;

      for Board_Rows in 1 .. Row_Height loop
        Draw_Row (Row_Number => i);
        Text_IO.New_Line;

      end loop;
    end loop;
    Draw_Border;
    Text_IO.New_Line;

  end Draw_Initial_World;

  procedure Draw_Border is
  begin
    for i in Grid_Coordinate.Col_Range loop
      Text_IO.Put ("|");

      for l in 1 .. Col_Width loop
        Text_IO.Put ("-");
      end loop;
    end loop;
    Text_IO.Put ("|");


  end Draw_Border;


  -- Draws a row of cells
  procedure Draw_Row (Row_Number : Grid_Coordinate.Row_Range ) is

  begin
    for i in Grid_Coordinate.Col_Range loop
      Text_IO.Put ("|");

      -- Fill remaining column pieces with white space.
      for l in 1 .. Col_Width loop
        Text_IO.Put (" ");
      end loop;

    end loop;
    Text_IO.Put ("|");
  end Draw_Row;


  -------------
  -- Cell_At --
  -------------

  function Cell_At
    (Object : Class_Type'Class; Coordinate : Grid_Coordinate.Location_Type)
      return Grid_Cell.Cell_Class_Ptr
  is
  begin
    return Object.Cells(Coordinate.Row,Coordinate.Col);
  end Cell_At;

end World_2D;
