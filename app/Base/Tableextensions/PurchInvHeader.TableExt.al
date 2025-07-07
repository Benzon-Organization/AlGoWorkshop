namespace BoSchData.sisMAN.Base;
using Microsoft.Purchases.History;

tableextension 71458586 "BSD Purch. Inv. Header" extends "Purch. Inv. Header"
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