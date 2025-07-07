namespace BoSchData.sisMAN.Base;
using Microsoft.CRM.Contact;
using Microsoft.Inventory.Location;

tableextension 71458600 "BSD Contact" extends Contact
{
    fields
    {
        field(71458575; "BSD Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            ToolTip = 'Specifies the responsibility center.';
            DataClassification = CustomerContent;
            TableRelation = "Responsibility Center";
        }
    }
}