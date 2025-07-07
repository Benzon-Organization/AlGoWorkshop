namespace BoSchData.sisMAN.Base;
using Microsoft.Purchases.Document;

pageextension 71458585 "BSD Purchase Return Order" extends "Purchase Return Order"
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