namespace BoSchData.sisMAN.Base;
using Microsoft.Sales.Receivables;

tableextension 71458581 "BSD Cust. Ledger Entry" extends "Cust. Ledger Entry"
{
    fields
    {
        field(71458575; "BSD Object No."; Code[20])
        {
            Caption = 'Object No.';
            DataClassification = CustomerContent;
            TableRelation = "BSD Object";
        }
    }
}