namespace BoSchData.sisMAN.Base;
using Microsoft.CRM.Contact;
using Microsoft.Purchases.Vendor;
using Microsoft.Sales.Customer;
using Microsoft.CRM.BusinessRelation;
using Microsoft.Inventory.Location;


table 71458585 "BSD Object Contr. Archive"
{

    fields
    {
        field(1; "Object No."; Code[20])
        {
            Caption = 'Object No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Contributor Type"; Enum "BSD Contributor Type")
        {
            Caption = 'Contributor Type';
            DataClassification = CustomerContent;
        }
        field(4; "Contact Type"; Enum "BSD Contact Type")
        {
            Caption = 'Contact Type';
            DataClassification = CustomerContent;
            InitValue = " ";
        }
        field(5; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            TableRelation = if ("Contributor Type" = const("Contributor Type"::Contact)) Contact where(Type = field("Contact Type"))
            else
            if ("Contributor Type" = const("Contributor Type"::Customer)) Customer
            else
            if ("Contributor Type" = const("Contributor Type"::Vendor)) Vendor;
        }
        field(6; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; Address; Text[100])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(9; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(14; "Business Relation"; Code[20])
        {
            Caption = 'Business Relation';
            DataClassification = CustomerContent;
            TableRelation = "Business Relation";
        }
        field(15; "Customer Template"; Code[20])
        {
            Caption = 'Customer Template';
            DataClassification = CustomerContent;
            TableRelation = "Customer Templ.";
        }
        field(16; "Contact Company"; Code[20])
        {
            Caption = 'Contact Company';
            DataClassification = CustomerContent;
        }
        field(17; "Primary Contact No."; Code[20])
        {
            Caption = 'Primary Contact No.';
            DataClassification = CustomerContent;
            TableRelation = Contact;
        }
        field(18; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            ToolTip = 'Specifies the responsibility center.';
            DataClassification = CustomerContent;
            TableRelation = "Responsibility Center";
        }
        field(999; "Version No."; Integer)
        {
            Caption = 'Version No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Object No.", "Line No.", "Version No.")
        {
            Clustered = true;
        }
    }
}