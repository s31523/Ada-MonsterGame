with Ada.Tags;

package body Grid_Cell is


  ---------------
  -- Add_Piece --
  ---------------

  procedure Add_Piece
    (Object : in out Cell_Class;
     Piece  : Pieces.Piece_Class_Ptr)
  is
  begin
    Object.Piece_List.Append (New_Item => Piece);
  end Add_Piece;

  procedure Remove_Piece (Object : in out Cell_Class ; Piece : Pieces.Piece_Class_Ptr) is

    Search_Piece : Pieces.Piece_Class_Ptr;
    Search_Cursor : Pieces_List_Pkg.Cursor := Object.Piece_List.First;

    Found : Boolean := false;
    PIECE_NOT_FOUND : exception;

    use type Ada.Tags.Tag;
    use type Pieces_List_Pkg.Cursor;

  begin
    Found := False;

    if Object.Piece_List.Length > 0 then

      loop
        Search_Piece := Pieces_List_Pkg.Element ( Search_Cursor );

        if Search_Piece = Piece then
          Found := True;
          Object.Piece_List.Delete ( Position => Search_Cursor );
        end if;
        exit when Found
          or else Object.Piece_List.Last = Search_Cursor;
        Search_Cursor := Pieces_List_Pkg.Next ( Search_Cursor );

      end loop;
    end if;

    if not Found then
      raise PIECE_NOT_FOUND;
    end if;

  end Remove_Piece;


  function Piece_Count (Object : in Cell_Class) return Natural is
  begin
    return Natural (Object.Piece_List.Length);
  end Piece_Count;

  function Piece_Can_Be_Added ( Object : in Cell_Class) return Boolean is
    List_Cursor : Pieces_List_Pkg.Cursor := Object.Piece_List.First;



    -- Local Variable to accumulate chars drawn from each piece draw.
    Piece_Can_Be_Added : Boolean := true;

    -- Visit action for each position in the list.
    procedure Visit_List_Node (Node :  Pieces_List_Pkg.Cursor ) is
      Piece       : Pieces.Piece_Class_Ptr := Pieces.Piece_Class_Ptr (Pieces_List_Pkg.Element ( Node ));

    begin
      if Piece.Can_Be_Only_One then
        Piece_Can_Be_Added := False;
      end if;

    end Visit_List_Node;
  begin
    Object.Piece_List.Iterate (Process => Visit_List_Node'access);

    return Piece_Can_Be_Added;
  end Piece_Can_Be_Added;


  procedure Draw (Object : in Cell_Class) is

    List_Cursor : Pieces_List_Pkg.Cursor := Object.Piece_List.First;



    -- Local Variable to accumulate chars drawn from each piece draw.
    Chars_Drawn_Accumulator : Natural := 0;

    -- Visit action for each position in the list.
    procedure Visit_List_Node (Node :  Pieces_List_Pkg.Cursor ) is
      Piece       : Pieces.Piece_Class_Ptr := Pieces.Piece_Class_Ptr (Pieces_List_Pkg.Element ( Node ));

      Length : Natural;
    begin
      Piece.Draw (Length => Length);
      Chars_Drawn_Accumulator := Chars_Drawn_Accumulator + Length;
    end Visit_List_Node;

  begin
    Object.Piece_List.Iterate (Process => Visit_List_Node'access);

  end Draw;



  -- Get Piece Helper --

  -- Locate cursor position of a piece, if found.
  --
  -- Cursor is provided instead of piece so that caller
  -- can delete the piece from the list if applicable.
  procedure Search_For_Matching_Piece
    ( -- Object this search is based on.
      Object    : in     Cell_Class;
      -- Class-tag to look for
      Piece_Tag : in     Ada.Tags.Tag;
      -- Found indicator
      Found     :    out Boolean;
      -- List location where item found (or no element)
      Cursor    :    out Pieces_List_Pkg.Cursor) is

    Search_Piece : Pieces.Piece_Class_Ptr;

    Search_Cursor : Pieces_List_Pkg.Cursor := Object.Piece_List.First;

    use type Ada.Tags.Tag;
    use type Pieces_List_Pkg.Cursor;

  begin
    Found := False;
    Cursor := Pieces_List_Pkg.No_Element;

    if Object.Piece_List.Length > 0 then

      loop
        Search_Piece := Pieces_List_Pkg.Element ( Search_Cursor );

        if Search_Piece.all'Tag = Piece_Tag then
          Found := True;
          Cursor := Search_Cursor;
        end if;
        exit when Found
          or else Object.Piece_List.Last = Search_Cursor;
        Search_Cursor := Pieces_List_Pkg.Next ( Search_Cursor );

      end loop;

    end if;

  end Search_For_Matching_Piece;


  function Board_Location (Object : Cell_Class) return Location.Location_Class is
  begin
    return Object.My_Location;
  end;



  function Get_Piece
    (
      Object    : in out Cell_Class;
      Piece_Tag : in     Ada.Tags.Tag;
      Remove    : in     Boolean := false;
      Piece     : out    Pieces.Piece_Class_Ptr ) return Boolean is


    Cursor : Pieces_List_Pkg.Cursor ;

    Found_Piece : Boolean;

    use type Ada.Tags.Tag;
    use type Pieces.Piece_Class_Ptr;
    use type Pieces_List_Pkg.Cursor;

  begin
    Piece := null;

    Search_For_Matching_Piece (Object    => Object,
                               Piece_Tag => Piece_Tag,
                               Found     => Found_Piece,
                               Cursor    => Cursor);

    if Found_Piece then
      Piece := Pieces_List_Pkg.Element ( Cursor );
      if Remove then
        Object.Piece_List.Delete (Cursor);
      end if;
    end if;

    return Found_Piece;

  end Get_Piece;


    function Make
    (
     Its_Location : Location.Location_Class;
     Height       : Natural;
     Width        : Natural
    ) return Cell_Class_Ptr is

    New_Obj : Cell_Class_Ptr := new Cell_Class;
  begin
    New_Obj.My_Location := Its_Location;
    New_Obj.Height := Height;
    New_Obj.Width  := Width;

    return New_Obj;
  end Make;

  function Make
    return Cell_Class_Ptr is
    New_Obj : Cell_Class_Ptr := new Cell_Class;
  begin
    return New_Obj;
  end Make;


end Grid_Cell;
