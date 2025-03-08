package Screen is

  procedure Move_Cursor (X : Natural ; Y : Natural );
  --procedure Move_Cursor (X : Natural );
  --procedure Move_Cursor (Y : Natural );
  
  procedure Move_Cursor_Down (Increment : Positive := 1);
  procedure Move_Cursor_Left (Increment : Positive := 1);
  
  procedure Clear;
  
  procedure Clear_From_Cursor;

  procedure Save_Cursor;
  procedure Restore_Cursor;
  
end Screen;
