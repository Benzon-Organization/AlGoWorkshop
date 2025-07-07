namespace BoSchData.sisMAN.Base;
using Microsoft.Purchases.History;

pageextension 71458595 "BSD Posted Purch. Receipt" extends "Posted Purchase Receipt"
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