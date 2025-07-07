namespace BoSchData.sisMAN.Base;
using Microsoft.Sales.Document;

pageextension 71458578 "BSD Sales Invoice" extends "Sales Invoice"
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