namespace BoSchData.sisMAN.Base;
using Microsoft.Sales.History;

tableextension 71458584 "BSD Sales Cr.Memo Header" extends "Sales Cr.Memo Header"
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