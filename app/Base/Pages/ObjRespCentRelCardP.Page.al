namespace BoSchData.sisMAN.Base;

page 71458599 "BSD Obj. Resp. Cent.Rel. CardP"
{
    ApplicationArea = All;
    Caption = 'Object Responsibility Center Relation';
    PageType = CardPart;
    SourceTable = "BSD Object Resp. Center Rel.";
    UsageCategory = None;
    DataCaptionFields = "Responsibility Center";

    layout
    {
        area(Content)
        {
            group("Object Status")
            {
                Caption = 'Object Status';

                field("Opportunity No."; Rec."Opportunity No.")
                {
                    Visible = UseSalesOpportunity;
                }
                field(Attentioncode; Rec.Attentioncode)
                {
                }
                field(Tender; Rec.Tender)
                {
                }
                field("Object End Date"; Rec."Object End Date")
                {
                }
                field("First Item Shipment"; Rec."First Item Shipment")
                {
                }
                field("Last Item Shipment"; Rec."Last Item Shipment")
                {
                }
                field("Sales Cycle Stage"; Rec."Sales Cycle Stage")
                {
                    Visible = UseSalesOpportunity;
                }
                field("Sales Cycle Stage Description"; Rec."Sales Cycle Stage Description")
                {
                    Visible = UseSalesOpportunity;
                }
                field("Expected Completion Date"; Rec."Estimated Close Date")
                {
                    Visible = UseSalesOpportunity;
                }
                field("Expected Value (LCY)"; Rec."Estimated Value (LCY)")
                {
                    Visible = UseSalesOpportunity;
                }
                field("Calcd. Current Value (LCY)"; Rec."Calcd. Current Value (LCY)")
                {
                    Visible = UseSalesOpportunity;
                }
                field("Chances of Success %"; Rec."Chances of Success %")
                {
                    Visible = UseSalesOpportunity;
                }
                field("Completed %"; Rec."Completed %")
                {
                    Visible = UseSalesOpportunity;
                }
                field("Probability %"; Rec."Probability %")
                {
                    Visible = UseSalesOpportunity;
                }
                field("Opportunity Status"; Rec."Opportunity Status")
                {
                    Visible = UseSalesOpportunity;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(CreateOpportunity)
            {
                ApplicationArea = All;
                Caption = 'Create Opportunity';
                ToolTip = 'Create an Opportunity for this Responsibility Center Relation.';
                Image = NewOpportunity;

                trigger OnAction()
                var
                    CreateOpportunityQst: Label 'Do you want to create an opportunity for this Responsibility Center Relation?';
                begin
                    if Confirm(CreateOpportunityQst) then
                        Rec.CreateOpportunity(Rec);
                end;
            }
        }
    }

    var
        UseSalesOpportunity: Boolean;

    trigger OnOpenPage()
    var
        sisMANSetup: Record "BSD sisMAN Setup";
    begin
        sisMANSetup.Get();
        UseSalesOpportunity := sisMANSetup."Use Sales Opportunity";
    end;
}
