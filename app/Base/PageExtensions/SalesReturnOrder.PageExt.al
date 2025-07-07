namespace BoSchData.sisMAN.Base;
using Microsoft.Sales.Document;

pageextension 71458586 "BSD Sales Return Order" extends "Sales Return Order"
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