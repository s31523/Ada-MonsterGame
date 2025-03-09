package Screen is
  

  subtype Display_Axis is Natural;
   
  type Point_Type is 
    record
      X : Display_Axis;
      Y : Display_Axis;
    end record;

  
  procedure Move_Cursor (X : Display_Axis ; Y : Display_Axis );
  --procedure Move_Cursor (X : Natural );
  --procedure Move_Cursor (Y : Natural );
  
  procedure Move_Cursor_Down (Increment : Positive := 1);
  procedure Move_Cursor_Left (Increment : Positive := 1);
  
  procedure Clear;
  
  procedure Clear_From_Cursor;

  procedure Save_Cursor;
  procedure Restore_Cursor;
  
end Screen;
