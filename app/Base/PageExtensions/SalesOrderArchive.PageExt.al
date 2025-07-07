namespace BoSchData.sisMAN.Base;
using Microsoft.Sales.Archive;

pageextension 71458590 "BSD Sales Order Archive" extends "Sales Order Archive"
{
    layout
    {
        addafter(Status)
        {
            field("BSD Object No."; Rec."BSD Object No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the corresponding Object No.';
            }
        }
    }
}