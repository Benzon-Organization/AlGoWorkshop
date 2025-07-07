namespace BoSchData.sisMAN.Base;

page 71458607 "BSD Object Pic. Lines Arch. Fb"
{
    Caption = 'Object Pictures';
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "BSD Object Picture Archive";
    Editable = false;


    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field(Filename; Rec.Filename)
                {
                    ApplicationArea = All;
                    Caption = 'Filename';
                    ToolTip = 'Filename of attached file.';
                }
            }
        }
    }
}