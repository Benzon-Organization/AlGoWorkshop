namespace BoSchData.sisMAN.Base;
using Microsoft.Purchases.History;

pageextension 71458593 "BSD Posted Purch. Cr. Memo" extends "Posted Purchase Credit Memo"
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