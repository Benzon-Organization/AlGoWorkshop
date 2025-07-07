namespace BoSchData.sisMAN.Base;
using Microsoft.Purchases.Payables;

tableextension 71458582 "BSD Vendor Ledger Entry" extends "Vendor Ledger Entry"
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