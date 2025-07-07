namespace BoSchData.sisMAN.Base;
using Microsoft.Sales.Document;

pageextension 71458579 "BSD Sales Order" extends "Sales Order"
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