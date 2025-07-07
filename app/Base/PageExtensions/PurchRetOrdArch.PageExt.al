namespace BoSchData.sisMAN.Base;
using Microsoft.Purchases.Archive;

pageextension 71458598 "BSD Purch. Ret. Ord. Arch." extends "Purchase Return Order Archive"
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