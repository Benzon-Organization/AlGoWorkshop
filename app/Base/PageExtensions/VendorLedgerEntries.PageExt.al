namespace BoSchData.sisMAN.Base;
using Microsoft.Purchases.Payables;

pageextension 71458602 "BSD Vendor Ledger Entries" extends "Vendor Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field("BSD Object No."; Rec."BSD Object No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the corresponding Object No.';
            }
        }
    }
}