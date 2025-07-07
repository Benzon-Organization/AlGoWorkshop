namespace BoSchData.sisMAN.Base;
using Microsoft.Sales.History;

pageextension 71458589 "BSD Posted Sales Shipment" extends "Posted Sales Shipment"
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