namespace BoSchData.sisMAN.Base;
using Microsoft.Sales.History;

tableextension 71458583 "BSD Sales Shipment Header" extends "Sales Shipment Header"
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