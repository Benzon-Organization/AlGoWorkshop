namespace BoSchData.sisMAN.Base;
using Microsoft.Sales.Document;

pageextension 71458577 "BSD Sales Quote" extends "Sales Quote"
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