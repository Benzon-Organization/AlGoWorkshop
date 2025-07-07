namespace BoSchData.sisMAN.Base;
using Microsoft.Inventory.Ledger;

pageextension 71458601 "BSD Item Ledger Entries" extends "Item Ledger Entries"
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