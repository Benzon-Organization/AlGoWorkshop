namespace BoSchData.sisMAN.Base;
using Microsoft.CRM.Contact;
using Microsoft.CRM.Setup;
using Microsoft.CRM.BusinessRelation;

pageextension 71458603 "BSD Contact Card" extends "Contact Card"
{
    layout
    {
        addlast(General)
        {
            field("BSD Responsibility Center"; Rec."BSD Responsibility Center")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(RelatedEmployee_Promoted)
        {
            actionref("BSD Related Object Promoted"; "BSD Related Object")
            {

            }
        }
        addafter(RelatedEmployee)
        {
            action("BSD Related Object")
            {
                ApplicationArea = All;
                Caption = 'Object';
                Image = Customer;
                Enabled = RelatedObjectEnabled;
                ToolTip = 'View information about the customer that is associated with the selected record.';

                trigger OnAction()
                var
                    LinkToTable: Enum "Contact Business Relation Link To Table";
                begin
                    Rec.ShowBusinessRelation(LinkToTable::"BSD Object", false);
                end;
            }
        }
    }

    var
        RelatedObjectEnabled: Boolean;

    trigger OnAfterGetCurrRecord()
    var
        MarketingSetup: Record "Marketing Setup";
    begin
        RelatedObjectEnabled := Rec.HasBusinessRelation(Enum::"Contact Business Relation Link To Table"::"BSD Object", MarketingSetup."BSD Bus. Rel. Code Objects");
    end;
}