namespace BoSchData.sisMAN.Base;

page 71458606 "BSD Object Pictures Archive"
{
    ApplicationArea = All;
    Caption = 'Object Pictures';
    PageType = List;
    SourceTable = "BSD Object Picture Archive";
    UsageCategory = None;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Picture; Rec.Picture)
                {
                    ToolTip = 'Specifies the value of the Picture field.';
                }
                field(Filename; Rec.Filename)
                {
                    ToolTip = 'Specifies the value of the Filename field.';
                }
            }
        }
    }
}
