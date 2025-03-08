with World_2D;
with Grid_Coordinate;

package iMovable is

  type itfMovable is interface;
  
  -- Determine a new location to move using your own logic to determine where in the world to move
  procedure Get_Location ( Object : in out itfMovable ; World : in World_2D.Class_Type) is abstract;
  
  
  -- Determine a new location to move using a specified direction to determine where in the world to move
  procedure Get_Location ( Object   : in out itfMovable ; 
                           World    : in     World_2D.Class_Type; 
                           To       : in     Grid_Coordinate.Compass_Direction ;
                           Valid    :    out Boolean ) is abstract;

end iMovable;
