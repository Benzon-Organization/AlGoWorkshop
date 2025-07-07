namespace BoSchData.sisMAN.Base;

page 71458593 "BSD Object Resp. Center Rel."
{
    ApplicationArea = All;
    Caption = 'Object Responsibility Center Relations';
    PageType = List;
    SourceTable = "BSD Object Resp. Center Rel.";
    UsageCategory = None;
    CardPageId = "BSD Obj. Resp. Cent.Rel. Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
            }
        }
    }
}
