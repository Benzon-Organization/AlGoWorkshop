namespace BoSchData.sisMAN.Base;
using Microsoft.Sales.History;

pageextension 71458587 "BSD Posted Sales Invoice" extends "Posted Sales Invoice"
{
    layout
    {
        addbefore("Work Description")
        {
            field("BSD Object No."; Rec."BSD Object No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the corresponding Object No.';
                Editable = false;
            }
        }
    }
}