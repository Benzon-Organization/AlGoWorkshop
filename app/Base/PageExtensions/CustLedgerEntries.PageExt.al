namespace BoSchData.sisMAN.Base;
using Microsoft.Sales.Receivables;

pageextension 71458600 "BSD Cust. Ledger Entries" extends "Customer Ledger Entries"
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