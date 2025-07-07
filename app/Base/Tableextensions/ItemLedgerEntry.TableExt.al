namespace BoSchData.sisMAN.Base;
using Microsoft.Inventory.Ledger;

tableextension 71458579 "BSD Item Ledger Entry" extends "Item Ledger Entry"
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