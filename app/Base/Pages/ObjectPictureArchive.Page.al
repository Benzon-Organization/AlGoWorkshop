namespace BoSchData.sisMAN.Base;

page 71458605 "BSD Object Picture Archive"
{
    Caption = ' ';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "BSD Object Picture Archive";
    Editable = false;

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