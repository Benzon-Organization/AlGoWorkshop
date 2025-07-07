namespace BoSchData.sisMAN.Base;
using Microsoft.Purchases.History;

pageextension 71458605 "BSD Posted Return Shipment" extends "Posted Return Shipment"
{
    layout
    {
        addlast(General)
        {
            field("BSD Object No."; Rec."BSD Object No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the corresponding Object No.';
            }
        }
    }
}