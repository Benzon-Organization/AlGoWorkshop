namespace BoSchData.sisMAN.Base;


page 71458597 "BSD Opp. Resp. Cent. Rel. FB"
{
    Caption = 'Opportunity per Responsibility Center Reference';
    PageType = ListPart;
    SourceTable = "BSD Object Resp. Center Rel.";
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