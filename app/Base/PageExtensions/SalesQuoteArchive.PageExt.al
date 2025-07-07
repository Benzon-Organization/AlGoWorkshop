namespace BoSchData.sisMAN.Base;
using Microsoft.Sales.Archive;

pageextension 71458591 "BSD Sales Quote Archive" extends "Sales Quote Archive"
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