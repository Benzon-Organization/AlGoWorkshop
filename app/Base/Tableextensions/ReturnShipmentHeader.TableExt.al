namespace BoSchData.sisMAN.Base;
using Microsoft.Purchases.History;

tableextension 71458599 "BSD Return Shipment Header" extends "Return Shipment Header"
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