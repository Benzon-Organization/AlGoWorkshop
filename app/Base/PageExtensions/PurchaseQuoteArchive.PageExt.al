namespace BoSchData.sisMAN.Base;
using Microsoft.Purchases.Archive;

pageextension 71458597 "BSD Purchase Quote Archive" extends "Purchase Quote Archive"
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