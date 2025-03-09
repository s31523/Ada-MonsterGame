with Ada.Text_IO;
use Ada;

package body Screen is

  package Int_IO is new Text_IO.Integer_IO (Num => Integer);

   -----------------
   -- Move_Cursor --
   -----------------

   procedure Move_Cursor (X : Display_Axis; Y : Display_Axis) is
   begin
    Text_IO.New_Line;
    Text_IO.Put (Item => ASCII.ESC);
    Text_IO.Put ("[");
    Int_IO.Put (Item => Y, Width => 1);
    Text_IO.Put (Item => ';');
    Int_IO.Put (Item => X, Width => 1);
    Text_IO.Put (Item => 'f');

   end Move_Cursor;

--    procedure Move_Cursor (X : Natural ) is
--    begin
--      Text_IO.New_Line;
--      Text_IO.Put (Item => ASCII.ESC);
--      Text_IO.Put ("[");
--      Int_IO.Put (Item => Y, Width => 1);
--      Text_IO.Put (Item => 'G');
--    end Move_Cursor;
--
--    procedure Move_Cursor (Y : Natural ) is
--    begin
--      null;
--    end Move_Cursor;

   -----------
   -- Clear --
   -----------

   procedure Clear is
   begin
    Text_IO.New_Line;
    Text_IO.Put (Item => ASCII.ESC);
    Text_IO.Put ("[");
    Int_IO.Put (Item => 2, Width => 1);
    Text_IO.Put (Item => 'J');

   end Clear;

  procedure Clear_From_Cursor is
  begin
    Text_IO.New_Line;
    Text_IO.Put (Item => ASCII.ESC);
    Text_IO.Put ("[");
    Int_IO.Put (Item => 0, Width => 1);
    Text_IO.Put (Item => 'J');

  end Clear_From_Cursor;

  procedure Save_Cursor is
  begin
    Text_IO.New_Line;
    Text_IO.Put (Item => ASCII.ESC);
    Text_IO.Put ("[s");

  end Save_Cursor;

  procedure Restore_Cursor is
  begin
    Text_IO.New_Line;
    Text_IO.Put (Item => ASCII.ESC);
    Text_IO.Put ("[u");

  end Restore_Cursor;

  procedure Move_Cursor_Down (Increment : Positive := 1) is
  begin
    Text_IO.New_Line;
    Text_IO.Put (Item => ASCII.ESC);
    Text_IO.Put ("[");
    Int_IO.Put (Item => Increment, Width => 1);
    Text_IO.Put ("B");

  end Move_Cursor_Down;


  procedure Move_Cursor_Left (Increment : Positive := 1) is
  begin
        Text_IO.New_Line;
    Text_IO.Put (Item => ASCII.ESC);
    Text_IO.Put ("[");
    Int_IO.Put (Item => Increment, Width => 1);
    Text_IO.Put ("D");

  end Move_Cursor_Left;

end Screen;
