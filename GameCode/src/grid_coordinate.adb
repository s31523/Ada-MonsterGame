pragma Ada_2012;
package body Grid_Coordinate is

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

end Grid_Coordinate;
