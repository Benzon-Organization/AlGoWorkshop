namespace BoSchData.sisMAN.Base;
using Microsoft.Purchases.History;

tableextension 71458587 "BSD Purch. Rcpt. Header" extends "Purch. Rcpt. Header"
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