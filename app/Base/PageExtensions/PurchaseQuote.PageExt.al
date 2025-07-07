namespace BoSchData.sisMAN.Base;
using Microsoft.Purchases.Document;

pageextension 71458584 "BSD Purchase Quote" extends "Purchase Quote"
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