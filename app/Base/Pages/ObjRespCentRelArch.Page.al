namespace BoSchData.sisMAN.Base;

page 71458601 "BSD Obj. Resp. Cent. Rel.Arch."
{
    ApplicationArea = All;
    Caption = 'Object Responsibility Center Relations Archive';
    PageType = List;
    SourceTable = "BSD Obj. Resp. Cent. Rel.Arch.";
    UsageCategory = History;
    CardPageId = "BSD Obj.Resp.C.Rel. Card Arch.";
    Editable = false;

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
