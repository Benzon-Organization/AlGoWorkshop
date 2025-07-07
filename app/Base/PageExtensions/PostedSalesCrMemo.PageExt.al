namespace BoSchData.sisMAN.Base;
using Microsoft.Sales.History;

pageextension 71458588 "BSD Posted Sales Cr. Memo" extends "Posted Sales Credit Memo"
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