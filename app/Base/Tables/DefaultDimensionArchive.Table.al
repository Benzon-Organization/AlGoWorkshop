namespace BoSchData.sisMAN.Base;

using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.HumanResources.Employee;
using Microsoft.Purchases.Vendor;
using Microsoft.Sales.Customer;
using System.Reflection;
using System.Globalization;
using Microsoft.Finance.Dimension;

table 71458591 "BSD Default Dimension Archive"
{
    Caption = 'Default Dimension Archive';
    LookupPageID = "BSD Default Dimensions Archive";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Table));
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            NotBlank = true;
            TableRelation = Dimension;
        }
        field(4; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Dimension Code"),
                                                         Blocked = const(false));
        }
        field(5; "Value Posting"; Enum "Default Dimension Value Posting Type")
        {
            Caption = 'Value Posting';
        }
        field(6; "Table Caption"; Text[250])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Table),
                                                                           "Object ID" = field("Table ID")));
            Caption = 'Table Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Multi Selection Action"; Option)
        {
            Caption = 'Multi Selection Action';
            OptionCaption = ' ,Change,Delete';
            OptionMembers = " ",Change,Delete;
        }
        field(8; "Parent Type"; Enum "Default Dimension Parent Type")
        {
            Caption = 'Parent Type';
        }
        field(10; "Allowed Values Filter"; Text[250])
        {
            Caption = 'Allowed Values Filter';
        }
        field(20; "Dimension Value Name"; Text[50])
        {
            CalcFormula = lookup("Dimension Value".Name where("Dimension Code" = field("Dimension Code"), Code = field("Dimension Value Code")));
            Caption = 'Dimension Value Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8000; ParentId; Guid)
        {
            Caption = 'ParentId';
            DataClassification = SystemMetadata;
            TableRelation = if ("Table ID" = const(15)) "G/L Account".SystemId
            else
            if ("Table ID" = const(18)) Customer.SystemId
            else
            if ("Table ID" = const(23)) Vendor.SystemId
            else
            if ("Table ID" = const(5200)) Employee.SystemId;
        }
        field(8001; DimensionId; Guid)
        {
            Caption = 'DimensionId';
            DataClassification = SystemMetadata;
            TableRelation = Dimension.SystemId;
        }
        field(8002; DimensionValueId; Guid)
        {
            Caption = 'DimensionValueId';
            DataClassification = SystemMetadata;
            TableRelation = "Dimension Value".SystemId;
        }
        field(999; "Version No."; Integer)
        {
            Caption = 'Version No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Table ID", "No.", "Dimension Code", "Version No.")
        {
            Clustered = true;
        }
        key(Key2; "Dimension Code")
        {
        }
        key(Key3; "Parent Type", ParentID)
        {
        }
    }

    procedure GetCaption() Result: Text[250]
    var
        ObjectTranslation: Record "Object Translation";
        CurrTableID: Integer;
        NewTableID: Integer;
        NewNo: Code[20];
        SourceTableName: Text[250];
    begin
        if not Evaluate(NewTableID, GetFilter("Table ID")) then
            exit('');

        CurrTableID := 0;
        if NewTableID = 0 then
            if GetRangeMin("Table ID") = GetRangeMax("Table ID") then
                NewTableID := GetRangeMin("Table ID")
            else
                NewTableID := 0;

        if NewTableID <> CurrTableID then
            SourceTableName := ObjectTranslation.TranslateObject(ObjectTranslation."Object Type"::Table, NewTableID);
        CurrTableID := NewTableID;

        if GetFilter("No.") <> '' then
            if GetRangeMin("No.") = GetRangeMax("No.") then
                NewNo := GetRangeMin("No.")
            else
                NewNo := '';

        if NewTableID <> 0 then
            exit(CopyStr(StrSubstNo('%1 %2', SourceTableName, NewNo), 1, MaxStrLen(Result)));

        exit('');
    end;
}