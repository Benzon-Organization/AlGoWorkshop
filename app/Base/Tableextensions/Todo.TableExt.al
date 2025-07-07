namespace BoSchData.sisMAN.Base;
using Microsoft.CRM.Task;
using Microsoft.Inventory.Location;

tableextension 71458597 "BSD To-do" extends "To-do"
{
    fields
    {
        field(71458575; "BSD Object No."; Code[20])
        {
            Caption = 'Object No.';
            DataClassification = CustomerContent;
            TableRelation = "BSD Object";
        }
        field(71458576; "BSD Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            ToolTip = 'Specifies the responsibility center.';
            DataClassification = CustomerContent;
            TableRelation = "Responsibility Center";
        }
    }
}