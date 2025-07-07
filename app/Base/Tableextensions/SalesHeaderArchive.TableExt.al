namespace BoSchData.sisMAN.Base;
using Microsoft.Sales.Archive;

tableextension 71458590 "BSD Sales Header Archive" extends "Sales Header Archive"
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