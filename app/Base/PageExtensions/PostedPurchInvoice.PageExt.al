namespace BoSchData.sisMAN.Base;
using Microsoft.Purchases.History;

pageextension 71458594 "BSD Posted Purch. Invoice" extends "Posted Purchase Invoice"
{
    layout
    {
        addlast(General)
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