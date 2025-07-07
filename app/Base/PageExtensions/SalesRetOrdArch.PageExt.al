namespace BoSchData.sisMAN.Base;
using Microsoft.Sales.Archive;

pageextension 71458592 "BSD Sales Ret. Ord. Arch." extends "Sales Return Order Archive"
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