namespace BoSchData.sisMAN.Base;
using Microsoft.Purchases.Document;

pageextension 71458581 "BSD Purchase Invoice" extends "Purchase Invoice"
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