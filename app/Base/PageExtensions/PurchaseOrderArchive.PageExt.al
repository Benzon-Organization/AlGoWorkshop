namespace BoSchData.sisMAN.Base;
using Microsoft.Purchases.Archive;

pageextension 71458596 "BSD Purchase Order Archive" extends "Purchase Order Archive"
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