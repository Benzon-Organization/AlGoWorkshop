namespace BoSchData.sisMAN.Base;
using Microsoft.Finance.GeneralLedger.Ledger;

tableextension 71458580 "BSD G/L Entry" extends "G/L Entry"
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