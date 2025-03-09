with Random_Generic;

package body Grid_Coordinate is
  package Random_Row is new Random_Generic ( Result_Subtype => Row_Range ) ;
  package Random_Col is new Random_Generic ( Result_Subtype => Col_Range ) ;

  -------------------------
  -- Compute_Coordinates --
  -------------------------

  procedure Compute_Coordinates
    (Current   : in     Location_Type;
     Direction : in Compass_Direction;
     New_Row   :    out Natural;
     New_Col   :    out Natural)
  is
  begin
    case Direction is
      when N  =>
        New_Row := Current.Row - 1;
      when NE =>
        New_Row := Current.Row - 1;
        New_Col := Current.Col + 1;
      when E  =>
        New_Col := Current.Col + 1;
      when SE =>
        New_Row := Current.Row + 1;
        New_Col := Current.Col + 1;
      when S  =>
        New_Row := Current.Row + 1;
      when SW =>
        New_Row := Current.Row + 1;
        New_Col := Current.Col - 1;
      when W =>
        New_Col := Current.Col - 1;
      when NW =>
        New_Row := Current.Row - 1;
        New_Col := Current.Col - 1;
    end case;
  end Compute_Coordinates;

  function Get_Random_Location return Location_Type is
  begin
      return (Row => Random_Row.Random_Value , Col => Random_Col.Random_Value);
  End Get_Random_Location;




end Grid_Coordinate;
