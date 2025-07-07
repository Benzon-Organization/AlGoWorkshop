namespace BoSchData.sisMAN.Base;
using BoSchData.sisMAN.Base;
using Microsoft.CRM.Contact;
using Microsoft.Purchases.Vendor;
using Microsoft.Sales.Customer;
using Microsoft.CRM.BusinessRelation;
using Microsoft.Inventory.Location;

table 71458580 "BSD Object Contributor"
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

            trigger OnValidate()
            begin
                if Rec."Contributor Type" <> "Contributor Type"::Contact then
                    Rec."Contact Type" := "Contact Type"::" ";

                if Rec."Contributor Type" <> xRec."Contributor Type" then
                    ClearLine();
            end;
        }
        field(4; "Contact Type"; Enum "BSD Contact Type")
        {
            Caption = 'Contact Type';
            DataClassification = CustomerContent;
            InitValue = " ";

            trigger OnValidate()
            begin
                if Rec."Contact Type" <> xRec."Contact Type" then
                    ClearLine();
            end;
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

            trigger OnValidate()
            begin
                FillLine();
            end;
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

    local procedure ClearLine()
    begin
        "No." := '';
        "Business Relation" := '';
        Name := '';
        "Name 2" := '';
        Address := '';
        "Address 2" := '';
        "Post Code" := '';
        City := '';
        "Customer Template" := '';
        "Contact Company" := '';
        "Primary Contact No." := '';
    end;

    local procedure FillLine()
    var
        Contact: Record Contact;
        Customer: Record Customer;
        Vendor: Record Vendor;
    begin
        case "Contributor Type" of
            "Contributor Type"::Contact:
                if Contact.Get(Rec."No.") then
                    FillFrom(Contact);
            "Contributor Type"::Customer:
                if Customer.Get(Rec."No.") then
                    FillFrom(Customer);
            "Contributor Type"::Vendor:
                if Vendor.Get(Rec."No.") then
                    FillFrom(Vendor);
        end;
    end;

    local procedure FillFrom(Contact: Record Contact)
    begin
        if Contact.Type = Contact.Type::Company then
            "Contact Type" := "Contact Type"::Company
        else
            "Contact Type" := "Contact Type"::Person;

        "No." := Contact."No.";
        Name := Contact.Name;
        "Name 2" := Contact."Name 2";
        Address := Contact.Address;
        "Address 2" := Contact."Address 2";
        "Post Code" := Contact."Post Code";
        City := Contact.City;
        "Contact Company" := Contact."Company No.";
    end;

    local procedure FillFrom(Customer: Record Customer)
    begin
        "No." := Customer."No.";
        Name := Customer.Name;
        "Name 2" := Customer."Name 2";
        Address := Customer.Address;
        "Address 2" := Customer."Address 2";
        "Post Code" := Customer."Post Code";
        City := Customer.City;
        "Primary Contact No." := Customer."Primary Contact No.";
    end;

    local procedure FillFrom(Vendor: Record Vendor)
    begin
        "No." := Vendor."No.";
        Name := Vendor.Name;
        "Name 2" := Vendor."Name 2";
        Address := Vendor.Address;
        "Address 2" := Vendor."Address 2";
        "Post Code" := Vendor."Post Code";
        City := Vendor.City;
    end;

    procedure SetAsShipToAddress(CustomerNo: Code[20]; ObjectNo: Code[20])
    var
        ShiptoAddress: Record "Ship-to Address";
        Object: Record "BSD Object";
        Customer: Record Customer;
        ConfirmMsg: Label 'Do you want to set the address of this object as ship-to adress on the customer %1?', comment = '%1 = Customer No.';
        SuccessMsg: Label 'Success! The address has been set as ship-to adress on customer %1.', comment = '%1 Customer No.';
    begin
        if Confirm(StrSubstNo(ConfirmMsg, CustomerNo)) then begin
            if not ShiptoAddress.Get(CustomerNo, CopyStr(ObjectNo, 1, 10)) and Customer.Get(CustomerNo) then
                if Object.Get(ObjectNo) then begin
                    ShiptoAddress.Init();
                    ShiptoAddress."Customer No." := CustomerNo;
                    ShiptoAddress.Code := CopyStr(ObjectNo, 1, 10);
                    ShiptoAddress.Insert();
                    ShiptoAddress.Name := Object.Description;
                    ShiptoAddress."Name 2" := Object."Description 2";
                    ShiptoAddress.Address := Object.Address;
                    ShiptoAddress."Address 2" := Object."Address 2";
                    ShiptoAddress.City := Object.City;
                    ShiptoAddress."Country/Region Code" := Object."Country/Region Code";
                    ShiptoAddress."Location Code" := Object."Location Code";
                    ShiptoAddress."Post Code" := Object."Post Code";
                    ShiptoAddress.Modify();
                end;

            Customer.Validate("Ship-to Code", ShiptoAddress.Code);
            Customer.Modify();

            Message(SuccessMsg, CustomerNo);
        end;
    end;

    procedure AddCustVendAsContributor(ObjectNo: Code[20]; CustVendNo: Code[20]; ContributorType: Enum "BSD Contributor Type"; RespCenterCode: Code[10])
    var
        ObjectContributor: Record "BSD Object Contributor";
        LineNo: Integer;
    begin
        ObjectContributor.SetRange("Object No.", ObjectNo);
        if ObjectContributor.FindLast() then
            LineNo := ObjectContributor."Line No." + 10000
        else
            LineNo := 10000;

        ObjectContributor.Reset();
        ObjectContributor.Init();
        ObjectContributor."Object No." := ObjectNo;
        ObjectContributor."Line No." := LineNo;
        ObjectContributor.Insert();
        ObjectContributor."Contributor Type" := ContributorType;
        ObjectContributor.Validate("No.", CustVendNo);
        ObjectContributor.Validate("Responsibility Center", RespCenterCode);
        ObjectContributor.Modify();
    end;
}