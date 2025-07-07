namespace BoSchData.sisMAN.Base;
using Microsoft.Purchases.Document;

pageextension 71458583 "BSD Purchase Order" extends "Purchase Order"
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