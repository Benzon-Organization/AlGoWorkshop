namespace BoSchData.sisMAN.Base;


page 71458604 "BSD Opp. Resp.C. Rel. Arch. FB"
{
    Caption = 'Opportunity per Responsibility Center Reference';
    PageType = ListPart;
    SourceTable = "BSD Obj. Resp. Cent. Rel.Arch.";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                ShowCaption = false;
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                field(Attentioncode; Rec.Attentioncode)
                {
                }
                field("Sales Cycle Stage Description"; Rec."Sales Cycle Stage Description")
                {
                    Caption = 'Sales Cycle Stage';
                }
            }
        }
    }
}