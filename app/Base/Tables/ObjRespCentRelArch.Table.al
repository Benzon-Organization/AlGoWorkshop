namespace BoSchData.sisMAN.Base;

using Microsoft.Inventory.Location;
using Microsoft.CRM.Contact;
using Microsoft.CostAccounting.Account;
using Microsoft.CRM.Opportunity;


table 71458588 "BSD Obj. Resp. Cent. Rel.Arch."
{
    DrillDownPageID = "BSD Obj. Resp. Cent. Rel.Arch.";
    LookupPageID = "BSD Obj. Resp. Cent. Rel.Arch.";

    fields
    {
        field(1; "Object No."; Code[20])
        {
            Caption = 'Object No.';
            ToolTip = 'Specifies the Object No.';
            DataClassification = CustomerContent;
            TableRelation = "BSD Object";
            Editable = false;
        }
        field(2; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            ToolTip = 'Specifies the responsibility center.';
            DataClassification = CustomerContent;
            TableRelation = "Responsibility Center";
            Editable = false;
        }
        field(3; "Object Description"; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the related object.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(4; "Responsibility Center Name"; Text[100])
        {
            Caption = 'Responsibility Center Name';
            ToolTip = 'Specifies the Name of the related Responsibility Center.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            ToolTip = 'Specifies the Contact No.';
            DataClassification = CustomerContent;
            TableRelation = Contact;
            Editable = false;
        }
        field(6; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            ToolTip = 'Specifies the Location Code.';
            DataClassification = CustomerContent;
            TableRelation = Location;
            Editable = false;
        }
        field(7; "Cost Center"; Code[20])
        {
            Caption = 'Cost Center';
            ToolTip = 'Specifies the Cost Center.';
            DataClassification = CustomerContent;
            TableRelation = "Cost Center";
            Editable = false;
        }
        field(8; "Cost Object"; Code[20])
        {
            Caption = 'Cost Object';
            ToolTip = 'Specifies the Cost Object.';
            DataClassification = CustomerContent;
            TableRelation = "Cost Object";
            Editable = false;
        }
        field(9; "Opportunity No."; Code[20])
        {
            Caption = 'Opportunity No.';
            ToolTip = 'Specifies the Opportunity No.';
            DataClassification = CustomerContent;
            TableRelation = Opportunity;
            Editable = false;
        }
        field(10; Attentioncode; Code[20])
        {
            Caption = 'Attentioncode';
            ToolTip = 'Specifies the Attentioncode.';
            DataClassification = CustomerContent;
            TableRelation = "BSD Attention";
            Editable = false;
        }
        field(11; Tender; Code[20])
        {
            Caption = 'Tender';
            ToolTip = 'Specifies the Tender Code.';
            DataClassification = CustomerContent;
            TableRelation = "BSD Tender";
            Editable = false;
        }
        field(12; "Object End Date"; Date)
        {
            Caption = 'Object End Date';
            ToolTip = 'Specifies the Object End Date.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(13; "Sales Cycle Stage"; Integer)
        {
            Caption = 'Sales Cycle Stage';
            ToolTip = 'Specifies the Sales Cycle Stage.';
            DataClassification = CustomerContent;
            TableRelation = "Sales Cycle Stage".Stage;
            Editable = false;
        }
        field(14; "Sales Cycle Stage Description"; Text[100])
        {
            Caption = 'Sales Cycle Stage Description';
            ToolTip = 'Specifies the Sales Cycle Stage Description.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; "Estimated Value (LCY)"; Decimal)
        {
            Caption = 'Estimated Value (LCY)';
            ToolTip = 'Specifies the Estimated Value (LCY).';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; "Calcd. Current Value (LCY)"; Decimal)
        {
            Caption = 'Calcd. Current Value (LCY)';
            ToolTip = 'Specifies the Calculated Current Value (LCY).';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(17; "Chances of Success %"; Decimal)
        {
            Caption = 'Chances of Success %';
            ToolTip = 'Specifies the Chances of Success in %.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(18; "Completed %"; Decimal)
        {
            Caption = 'Completed %';
            ToolTip = 'Specifies the Completed %.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(19; "Probability %"; Decimal)
        {
            Caption = 'Probability %';
            ToolTip = 'Specifies the Probability in %.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(20; "Estimated Close Date"; Date)
        {
            Caption = 'Estimated Close Date';
            ToolTip = 'Specifies the Estimated Close Date.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(21; "Opportunity Status"; Enum "Opportunity Status")
        {
            Caption = 'Opportunity Status';
            ToolTip = 'Specifies the Opportunity Status.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(22; "First Item Shipment"; Date)
        {
            Caption = 'First Item Shipment';
            ToolTip = 'Specifies the date of the first Item Shipment.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(23; "Last Item Shipment"; Date)
        {
            Caption = 'Last Item Shipment';
            ToolTip = 'Specifies the date of the last Item Shipment.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(999; "Version No."; Integer)
        {
            Caption = 'Version No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Object No.", "Responsibility Center", "Version No.")
        {
            Clustered = true;
        }
    }
}