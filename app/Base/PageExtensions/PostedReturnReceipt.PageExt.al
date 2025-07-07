namespace BoSchData.sisMAN.Base;
using Microsoft.Sales.History;

pageextension 71458604 "BSD Posted Return Receipt" extends "Posted Return Receipt"
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