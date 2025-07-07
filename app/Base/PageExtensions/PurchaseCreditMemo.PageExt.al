namespace BoSchData.sisMAN.Base;
using Microsoft.Purchases.Document;

pageextension 71458582 "BSD Purchase Credit Memo" extends "Purchase Credit Memo"
{
    layout
    {
        addafter("Assigned User ID")
        {
            field("BSD Object No."; Rec."BSD Object No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the corresponding Object No.';
            }
        }
    }
}