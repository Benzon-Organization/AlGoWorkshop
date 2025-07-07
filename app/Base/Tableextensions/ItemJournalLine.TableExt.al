namespace BoSchData.sisMAN.Base;
using Microsoft.Inventory.Journal;

tableextension 71458594 "BSD Item Journal Line" extends "Item Journal Line"
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