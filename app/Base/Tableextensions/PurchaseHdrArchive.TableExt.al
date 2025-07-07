namespace BoSchData.sisMAN.Base;
using Microsoft.Purchases.Archive;

tableextension 71458589 "BSD Purchase Hdr. Archive" extends "Purchase Header Archive"
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