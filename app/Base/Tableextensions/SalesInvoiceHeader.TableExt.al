namespace BoSchData.sisMAN.Base;
using Microsoft.Sales.History;

tableextension 71458585 "BSD Sales Invoice Header" extends "Sales Invoice Header"
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