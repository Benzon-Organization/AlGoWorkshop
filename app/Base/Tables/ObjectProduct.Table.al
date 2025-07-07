namespace BoSchData.sisMAN.Base;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Availability;
using Microsoft.Inventory.Item.Substitution;
using Microsoft.Inventory.Location;
using Microsoft.Foundation.UOM;

table 71458581 "BSD Object Product"
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

            trigger OnValidate()
            var
                ItemCategory: Record "Item Category";
            begin
                ClearLine();

                if ItemCategory.Get(Rec."Item Category") then
                    Rec.Description := ItemCategory.Description;
            end;
        }
        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation =
            if ("Item Category" = const('')) Item
            else
            "Item" where("Item Category Code" = field("Item Category"));

            trigger OnValidate()
            begin
                FillLineFromItem(Rec."Item No.");
            end;
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

            trigger OnValidate()
            begin
                "Line Amount" := Quantity * "Unit Price" * ((100 - "Line Discount %") / 100);
            end;
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

            trigger OnValidate()
            var
                DiscountTooHighErr: Label 'The discount cannot be higher than 100.';
                DiscountTooLowErr: Label 'The discount cannot be lower than 0.';
            begin
                if Rec."Line Discount %" > 100 then
                    Error(DiscountTooHighErr);

                if Rec."Line Discount %" < 0 then
                    Error(DiscountTooLowErr);

                "Line Amount" := Quantity * "Unit Price" * ((100 - "Line Discount %") / 100);
            end;
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
            TableRelation = "BSD Object Resp. Center Rel."."Responsibility Center" where("Object No." = field("Object No."));
        }
    }
    keys
    {
        key(PK; "Object No.", "Line No.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var
        Object: Record "BSD Object";
    begin
        if Object.Get(Rec."Object No.") then
            "Responsibility Center" := Object."Responsibility Center Filter";
    end;

    trigger OnDelete()
    begin
        DeleteComments(Rec);
    end;

    local procedure ClearLine()
    begin
        Rec."Item No." := '';
        Rec.Description := '';
        Rec."Unit of Measure Code" := '';
        Rec."Sales Unit of Measure" := '';
        Rec."Purchase Unit of Measure" := '';
        Rec."Net Weight" := 0;
        Rec."Gross Weight" := 0;
        Rec."Unit Price" := 0;
        Rec.Quantity := 0;
        Rec."Line Discount %" := 0;
        Rec."Line Amount" := 0;
    end;

    local procedure FillLineFromItem(ItemNo: Code[20])
    var
        Item: Record Item;
    begin
        if Item.Get(ItemNo) then begin
            Rec."Item No." := ItemNo;
            Rec.Quantity := 0;
            Rec."Line Discount %" := 0;
            Rec."Line Amount" := 0;
            Rec.Description := Item.Description;
            Rec."Unit of Measure Code" := Item."Base Unit of Measure";
            Rec."Sales Unit of Measure" := Item."Sales Unit of Measure";
            Rec."Purchase Unit of Measure" := Item."Purch. Unit of Measure";
            Rec."Net Weight" := Item."Net Weight";
            Rec."Gross Weight" := Item."Gross Weight";
            Rec."Unit Price" := Item."Unit Price";
        end;
    end;

    procedure ShowLineComments()
    var
        ObjectProductComment: Record "BSD Object Product Comment";
        ObjProdCommSheet: Page "BSD Obj. Prod. Comm. Sheet";
    begin
        TestField("Object No.");
        TestField("Line No.");
        ObjectProductComment.SetRange("Object No.", "Object No.");
        ObjectProductComment.SetRange("Product Line No.", "Line No.");
        ObjProdCommSheet.SetTableView(ObjectProductComment);
        ObjProdCommSheet.RunModal();
    end;

    local procedure DeleteComments(ObjectProduct: Record "BSD Object Product")
    var
        ObjectProductComment: Record "BSD Object Product Comment";
    begin
        ObjectProductComment.SetRange("Object No.", ObjectProduct."Object No.");
        ObjectProductComment.SetRange("Product Line No.", ObjectProduct."Line No.");
        if not ObjectProductComment.IsEmpty() then
            ObjectProductComment.DeleteAll();
    end;

    procedure ShowItemSub()
    var
        ItemSubstitution: Record "Item Substitution";
        Object: Record "BSD Object";
        EnterItemErr: Label 'Enter an Item for that line first.';
        NoSubsitutesErr: Label 'No subsitute Items found for this Item.';
    begin
        Object.Get("Object No.");
        Object.TestField(Status, Object.Status::Open);
        if Rec."Item No." = '' then
            Error(EnterItemErr);

        ItemSubstitution.Reset();
        ItemSubstitution.SetRange(Type, ItemSubstitution.Type::Item);
        ItemSubstitution.SetRange("No.", "Item No.");
        ItemSubstitution.SetRange("Variant Code", "Variant Code");
        ItemSubstitution.SetRange("Location Filter", "Location Code");
        if ItemSubstitution.IsEmpty then
            Error(NoSubsitutesErr);

        if PAGE.RunModal(PAGE::"Item Substitution Entries", ItemSubstitution) = ACTION::LookupOK then
            FillLineFromItem(ItemSubstitution."Substitute No.");
    end;

    procedure ShowItemAvailFromObjectProduct(var ObjectProduct: Record "BSD Object Product"; AvailabilityType: Enum "Item Availability Type")
    var
        Item: Record Item;
        ItemAvailabilityFormsMgt: Codeunit "Item Availability Forms Mgt";
        NewDate: Date;
        NewVariantCode: Code[20];
        NewLocationCode: Code[20];
        NewUnitOfMeasureCode: Code[10];
    begin
        ObjectProduct.TestField("Item No.");
        Item.Reset();
        Item.Get(ObjectProduct."Item No.");

        case AvailabilityType of
            AvailabilityType::Period:
                if ItemAvailabilityFormsMgt.ShowItemAvailabilityByPeriod(Item, CopyStr(ObjectProduct.FieldCaption(ObjectProduct."Shipment Date"), 1, 80), ObjectProduct."Shipment Date", NewDate) then
                    ObjectProduct.Validate(ObjectProduct."Shipment Date", NewDate);
            AvailabilityType::Variant:
                if ItemAvailabilityFormsMgt.ShowItemAvailabilityByVariant(Item, CopyStr(ObjectProduct.FieldCaption(ObjectProduct."Variant Code"), 1, 80), ObjectProduct."Variant Code", NewVariantCode) then
                    ObjectProduct.Validate(ObjectProduct."Variant Code", NewVariantCode);
            AvailabilityType::Location:
                if ItemAvailabilityFormsMgt.ShowItemAvailabilityByLocation(Item, CopyStr(ObjectProduct.FieldCaption(ObjectProduct."Location Code"), 1, 80), ObjectProduct."Location Code", NewLocationCode) then
                    ObjectProduct.Validate(ObjectProduct."Location Code", NewLocationCode);
            AvailabilityType::"Event":
                if ItemAvailabilityFormsMgt.ShowItemAvailabilityByEvent(Item, CopyStr(ObjectProduct.FieldCaption(ObjectProduct."Shipment Date"), 1, 80), ObjectProduct."Shipment Date", NewDate, false) then
                    ObjectProduct.Validate(ObjectProduct."Shipment Date", NewDate);
            AvailabilityType::BOM:
                if ItemAvailabilityFormsMgt.ShowItemAvailabilityByBOMLevel(Item, CopyStr(ObjectProduct.FieldCaption(ObjectProduct."Shipment Date"), 1, 80), ObjectProduct."Shipment Date", NewDate) then
                    ObjectProduct.Validate(ObjectProduct."Shipment Date", NewDate);
            AvailabilityType::UOM:
                if ItemAvailabilityFormsMgt.ShowItemAvailabilityByUOM(Item, CopyStr(ObjectProduct.FieldCaption(ObjectProduct."Unit of Measure Code"), 1, 80), ObjectProduct."Unit of Measure Code", NewUnitOfMeasureCode) then
                    ObjectProduct.Validate(ObjectProduct."Unit of Measure Code", NewUnitOfMeasureCode);
        end;
    end;
}