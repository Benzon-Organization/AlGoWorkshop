namespace BoSchData.sisMAN.Base;
using Microsoft.Purchases.History;

tableextension 71458588 "BSD Purch. Cr. Memo. Hdr." extends "Purch. Cr. Memo Hdr."
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