--@summary
-- Defines "where" a spot on a game board cell is
--
--@description
-- Game board cells have locations which are used to control drawing.
package Location is

   -- Abstract the the grid dimensions
   subtype Grid_Axis is Positive;
   
   -- Location will represent a grid location
   type Location_Class is tagged record
      Row : Grid_Axis;
      Col : Grid_Axis;
      
   end record;
   
   type Location_Class_Ptr is access all Location_Class'Class;
   
   

end Location;
