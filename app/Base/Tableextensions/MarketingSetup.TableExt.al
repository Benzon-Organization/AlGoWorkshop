namespace BoSchData.sisMAN.Base;
using Microsoft.CRM.Setup;
using Microsoft.CRM.BusinessRelation;

tableextension 71458576 "BSD Marketing Setup" extends "Marketing Setup"
{
    fields
    {
        field(71458575; "BSD Bus. Rel. Code Objects"; Code[10])
        {
            Caption = 'Bus. Rel. Code for Objects';
            DataClassification = CustomerContent;
            TableRelation = "Business Relation";
        }
    }
}