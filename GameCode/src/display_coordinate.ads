with Location;

--@summary
-- Coordinate translation utility to get X,Y screen positions
--
--@description
--
-- Interface definition so classes can implement interface functions
-- to translate a game grid coordinate to a display coordinate.
package Display_Coordinate is

   subtype Display_Axis is Natural;
   
   type Point_Type is 
      record
         X : Display_Axis;
         Y : Display_Axis;
      end record;
   
   type Coordinate_Class is interface;
   
   function X (From : Location.Location_Class) return Display_Axis is abstract;
   function Y (From : Location.Location_Class) return Display_Axis is abstract;
   
   function Point ( From : Location.Location_Class ) return Point_Type is abstract;

end Display_Coordinate;
