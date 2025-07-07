namespace BoSchData.sisMAN.Base;
using Microsoft.Finance.GeneralLedger.Ledger;

pageextension 71458599 "BSD General Ledger Entries" extends "General Ledger Entries"
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