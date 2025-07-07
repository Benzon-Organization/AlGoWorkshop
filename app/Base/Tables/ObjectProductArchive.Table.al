namespace BoSchData.sisMAN.Base;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Location;
using Microsoft.Foundation.UOM;

table 71458586 "BSD Object Product Archive"
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
        field(3; "Item Category"; Code[20])
        {
            Caption = 'Item Category';
            DataClassification = CustomerContent;
            TableRelation = "Item Category";
        }
        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation =
            if ("Item Category" = const('')) Item
            else
            "Item" where("Item Category Code" = field("Item Category"));
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 :;
        }
        field(7; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = CustomerContent;
            TableRelation = "Unit of Measure";
        }
        field(8; "Sales Unit of Measure"; Code[10])
        {
            Caption = 'Sales Unit of Measure';
            DataClassification = CustomerContent;
            TableRelation = "Unit of Measure";
        }
        field(9; "Purchase Unit of Measure"; Code[10])
        {
            Caption = 'Purchase Unit of Measure';
            DataClassification = CustomerContent;
            TableRelation = "Unit of Measure";
        }
        field(10; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DataClassification = CustomerContent;
        }
        field(11; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                "Line Amount" := Quantity * "Unit Price" * ((100 - "Line Discount %") / 100);
            end;
        }
        field(13; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(14; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                "Line Discount %" := (1 - "Line Amount" / "Unit Price" / Quantity) * 100;
            end;
        }
        field(15; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            TableRelation = Location where("Use As In-Transit" = const(false));
        }
        field(16; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            DataClassification = CustomerContent;
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."), Blocked = const(false));
        }
        field(17; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
            DataClassification = CustomerContent;
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

    procedure ShowLineComments()
    var
        ObjectProdCommentArch: Record "BSD Object Prod. Comment Arch.";
        ObjProdCommArch: Page "BSD Obj. Prod. Comm. Arch.";
    begin
        TestField("Object No.");
        TestField("Line No.");
        ObjectProdCommentArch.SetRange("Object No.", "Object No.");
        ObjectProdCommentArch.SetRange("Product Line No.", "Line No.");
        ObjProdCommArch.SetTableView(ObjectProdCommentArch);
        ObjProdCommArch.RunModal();
    end;
}