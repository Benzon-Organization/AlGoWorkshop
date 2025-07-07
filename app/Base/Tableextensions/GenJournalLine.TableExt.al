namespace BoSchData.sisMAN.Base;
using Microsoft.Finance.GeneralLedger.Journal;

tableextension 71458593 "BSD Gen. Journal Line" extends "Gen. Journal Line"
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