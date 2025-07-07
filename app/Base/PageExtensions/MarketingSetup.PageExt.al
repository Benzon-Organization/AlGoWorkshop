namespace BoSchData.sisMAN.Base;
using Microsoft.CRM.Setup;

pageextension 71458576 "BSD Marketing Setup" extends "Marketing Setup"
{
    layout
    {
        addafter("Bus. Rel. Code for Employees")
        {
            field("BSD Bus. Rel. Code Objects"; Rec."BSD Bus. Rel. Code Objects")
            {
                ApplicationArea = All;
                Caption = 'Objects';
                ToolTip = 'Specifies the business relation code that identifies that a contact is also an object.';
            }
        }
    }
}