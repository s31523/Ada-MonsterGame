
package body Display is

  -------
  -- X --
  -------
--2, 8, 14, 20
  function X
    (From : in Display_Class ; Offset : Display_Coordinate.Display_Axis)
      return Display_Coordinate.Display_Axis
  is
  begin
    return (From.X_Pad * Offset + 1) + (From.X_Scale * (Offset - 1));

  end X;

  -------
  -- Y --
  -------

  function Y
    (From : in Display_Class; Offset : Display_Coordinate.Display_Axis)
      return Display_Coordinate.Display_Axis
  is
  begin
    return (From.Y_Pad * Offset + 1) + (From.Y_Scale * (Offset - 1));
  end Y;

  -----------
  -- Point --
  -----------

  function Point
    (From : in Display_Class; Offset : Display_Coordinate.Display_Axis)
      return Display_Coordinate.Point_Type
  is
  begin
    return (X => (From.X_Pad + From.X_Scale) * Offset, Y => (From.Y_Pad + From.Y_Scale) * Offset);

  end Point;

end Display;
