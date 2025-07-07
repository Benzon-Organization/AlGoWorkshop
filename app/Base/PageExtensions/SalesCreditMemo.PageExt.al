namespace BoSchData.sisMAN.Base;
using Microsoft.Sales.Document;

pageextension 71458580 "BSD Sales Credit Memo" extends "Sales Credit Memo"
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