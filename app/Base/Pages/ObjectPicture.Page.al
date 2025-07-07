namespace BoSchData.sisMAN.Base;

page 71458583 "BSD Object Picture"
{
    Caption = ' ';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "BSD Object Picture";

    layout
    {
        area(content)
        {
            field(Picture; Rec.Picture)
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Specifies the object picture.';
            }
        }
    }
}