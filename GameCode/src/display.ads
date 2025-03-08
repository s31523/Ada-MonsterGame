with Display_Coordinate;

package Display is

  type Display_Class is new Display_Coordinate.Coordinate_Class with record
    
    -- Number of pad-space to skip from an absolute screen location in the X direction
    X_Pad : Natural;
    
    -- Scale factor for X direction
    X_Scale : Natural;
    
    -- Number of pad-space to skip from an absolute screen location in the X direction
    Y_Pad : Natural;
    
    -- Scale factor for X direction
    Y_Scale : Natural;
  end record;
  
  function X ( From : in Display_Class ; Offset : Display_Coordinate.Display_Axis) return Display_Coordinate.Display_Axis;
  function Y ( From : in Display_Class ; Offset : Display_Coordinate.Display_Axis) return Display_Coordinate.Display_Axis;
  
  function Point ( From : in Display_Class ; Offset : Display_Coordinate.Display_Axis) return Display_Coordinate.Point_Type;

    
end Display;
