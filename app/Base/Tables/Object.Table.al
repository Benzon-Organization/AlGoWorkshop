namespace BoSchData.sisMAN.Base;

using BoSchData.sisMAN.Base;
using Microsoft.CRM.Interaction;
using Microsoft.Purchases.Payables;
using Microsoft.Sales.Receivables;
using Microsoft.CRM.Task;
using Microsoft.Foundation.NoSeries;
using Microsoft.Foundation.Address;
using Microsoft.Foundation.Shipping;
using Microsoft.CRM.Segment;
using Microsoft.Foundation.Comment;
using System.Utilities;
using Microsoft.CRM.Outlook;
using Microsoft.CRM.Contact;
using Microsoft.Purchases.Archive;
using Microsoft.Sales.Archive;
using Microsoft.Purchases.History;
using Microsoft.Purchases.Document;
using Microsoft.Sales.History;
using Microsoft.Sales.Document;
using Microsoft.CRM.BusinessRelation;
using Microsoft.Inventory.Ledger;
using Microsoft.Service.Setup;
using System.Security.User;
using Microsoft.CRM.Team;
using Microsoft.Inventory.Location;
using Microsoft.Finance.Dimension;
using Microsoft.CRM.Opportunity;

table 71458579 "BSD Object"
{
    Caption = 'Object';
    DrillDownPageID = "BSD Object List";
    LookupPageID = "BSD Object List";
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Object: Record "BSD Object";
                sisMANSetup: Record "BSD sisMAN Setup";
                NoSeries: Codeunit "No. Series";
            begin
                if "No." <> xRec."No." then
                    if not Object.Get(Rec."No.") then begin
                        sisMANSetup.Get();
                        NoSeries.TestManual(sisMANSetup."Object Nos.");
                        "No. Series" := '';
                    end;
            end;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                sisMANSetup: Record "BSD sisMAN Setup";
                Opportunity: Record Opportunity;
                DimensionValue: Record "Dimension Value";
            begin
                if Opportunity.Get(Rec."No.") then
                    if Opportunity.Description = '' then begin
                        Opportunity.Description := Description;
                        Opportunity.Modify();
                    end;

                sisMANSetup.Get();
                if DimensionValue.Get(sisMANSetup."Object Type Dimension", Rec."No.") then begin
                    DimensionValue.Name := CopyStr(Description, 1, MaxStrLen(DimensionValue.Name));
                    DimensionValue.Modify();
                end;
            end;
        }
        field(3; "Search Name"; Code[100])
        {
            Caption = 'Search Name';
            DataClassification = CustomerContent;
        }
        field(4; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
        field(5; Address; Text[100])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(6; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = CustomerContent;
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
            TableRelation = if ("Country/Region Code" = const('')) "Post Code".City
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("Country/Region Code"));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                PostCode: Record "Post Code";
            begin
                if Rec."Country/Region Code" <> '' then
                    PostCode.SetRange("Country/Region Code", Rec."Country/Region Code");
                if Page.RunModal(Page::"Post Codes", PostCode) = ACTION::LookupOK then begin
                    Rec.City := PostCode.City;
                    Rec."Post Code" := PostCode.Code;
                    Rec.County := PostCode."BSD County";
                    Rec.District := PostCode."BSD District";
                    Rec."Country/Region Code" := PostCode."Country/Region Code";
                end;
            end;
        }
        field(8; County; Code[10])
        {
            Caption = 'County';
            DataClassification = CustomerContent;
            TableRelation = "BSD County/District"."Area";

            trigger OnLookup()
            var
                CountyDistrict: Record "BSD County/District";
            begin
                if Page.RunModal(Page::"BSD Counties/Districts", CountyDistrict) = ACTION::LookupOK then begin
                    County := CountyDistrict."Area";
                    District := CountyDistrict.Code;
                end;
            end;
        }
        field(9; District; Code[10])
        {
            Caption = 'District';
            DataClassification = CustomerContent;
            TableRelation = "BSD County/District".Code where("Area" = field("County"));

            trigger OnLookup()
            var
                CountyDistrict: Record "BSD County/District";
            begin
                if Rec.County <> '' then
                    CountyDistrict.SetRange("Area", County);
                if Page.RunModal(Page::"BSD Counties/Districts", CountyDistrict) = ACTION::LookupOK then begin
                    County := CountyDistrict."Area";
                    District := CountyDistrict.Code;
                end;
            end;
        }
        field(10; "No. 2"; Code[20])
        {
            Caption = 'No. 2';
            DataClassification = CustomerContent;
        }
        field(12; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));
            DataClassification = CustomerContent;
        }
        field(13; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
            DataClassification = CustomerContent;
        }
        field(14; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
            DataClassification = CustomerContent;
        }
        field(15; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code where("Shipping Agent Code" = field("Shipping Agent Code"));
            DataClassification = CustomerContent;
        }
        field(16; "Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser" where(Blocked = const(false));
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                Opportunity: Record Opportunity;
            begin
                if Opportunity.Get(Rec."No.") then
                    if Opportunity."Salesperson Code" = '' then begin
                        Opportunity.Validate("Salesperson Code", Rec."Salesperson Code");
                        Opportunity.Modify();
                    end;
            end;
        }
        field(17; "Salesperson Code 2"; Code[20])
        {
            Caption = 'Salesperson Code 2';
            TableRelation = "Salesperson/Purchaser" where(Blocked = const(false));
            DataClassification = CustomerContent;
        }
        field(18; "Assigned User ID"; Code[50])
        {
            Caption = 'Assigned User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = "User Setup";
        }
        field(19; "Service Zone Code"; Code[10])
        {
            Caption = 'Service Zone Code';
            TableRelation = "Service Zone";
            DataClassification = CustomerContent;
        }
        field(20; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                sisMANSetup: Record "BSD sisMAN Setup";
            begin
                sisMANSetup.Get();
                Rec."Resubmission Date" := CalcDate(sisMANSetup."Resubmission date formula", Rec."Creation Date");
            end;
        }
        field(21; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(22; "Your Reference"; Text[35])
        {
            Caption = 'Your Reference';
            DataClassification = CustomerContent;
        }
        field(23; "Submission Date"; Date)
        {
            Caption = 'Submission Date';
            DataClassification = CustomerContent;
        }
        field(24; "Planned Duration from"; Date)
        {
            Caption = 'Planned Duration from';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                DurationErr: Label 'The date should be earlier than the planned duration to date.';
            begin
                if "Planned Duration from" > "Planned Duration to" then
                    Error(DurationErr);
            end;
        }
        field(25; "Planned Duration to"; Date)
        {
            Caption = 'Planned Duration to';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                DurationErr: Label 'The date should be later than the planned duration from date.';
            begin
                if "Planned Duration to" < "Planned Duration from" then
                    Error(DurationErr);
            end;
        }
        field(26; "Resubmission Date"; Date)
        {
            Caption = 'Resubmission Date';
            DataClassification = CustomerContent;
        }
        field(27; Status; Enum "BSD Object Status")
        {
            Caption = 'Status';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(28; "Work Description"; Text[500])
        {
            Caption = 'Work Description';
            DataClassification = CustomerContent;
        }
        field(29; "Opportunity No."; Code[20])
        {
            Caption = 'Opportunity No.';
            DataClassification = CustomerContent;
            TableRelation = Opportunity;

            trigger OnValidate()
            begin
                FillStatusFields();
            end;
        }
        field(30; Attentioncode; Code[20])
        {
            Caption = 'Attentioncode';
            DataClassification = CustomerContent;
            TableRelation = "BSD Attention";
        }
        field(31; Tender; Code[20])
        {
            Caption = 'Tender';
            DataClassification = CustomerContent;
            TableRelation = "BSD Tender";
        }
        field(32; "Object End Date"; Date)
        {
            Caption = 'Object End Date';
            DataClassification = CustomerContent;
        }
        field(33; "Sales Cycle Stage"; Integer)
        {
            Caption = 'Sales Cycle Stage';
            DataClassification = CustomerContent;
            TableRelation = "Sales Cycle Stage".Stage;
            Editable = false;
        }
        field(34; "Sales Cycle Stage Description"; Text[100])
        {
            Caption = 'Sales Cycle Stage Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(35; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                PostCode: Record "Post Code";
                CountyTxt: Text[30];
            begin
                PostCode.ValidateCountryCode(Rec.City, Rec."Post Code", CountyTxt, Rec."Country/Region Code");
            end;
        }
        field(36; "Estimated Value (LCY)"; Decimal)
        {
            Caption = 'Estimated Value (LCY)';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(37; "Calcd. Current Value (LCY)"; Decimal)
        {
            Caption = 'Calcd. Current Value (LCY)';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(38; "Chances of Success %"; Decimal)
        {
            Caption = 'Chances of Success %';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(39; "Completed %"; Decimal)
        {
            Caption = 'Completed %';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(40; "Probability %"; Decimal)
        {
            Caption = 'Probalility %';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(42; "First Item Shipment"; Date)
        {
            Caption = 'First Item Shipment';
            FieldClass = FlowField;
            CalcFormula = min("Item Ledger Entry"."Posting Date" where("BSD Object No." = field("No.")));
            Editable = false;
        }
        field(43; "Last Item Shipment"; Date)
        {
            Caption = 'Last Item Shipment';
            FieldClass = FlowField;
            CalcFormula = max("Item Ledger Entry"."Posting Date" where("BSD Object No." = field("No.")));
            Editable = false;
        }
        field(44; "Estimated Close Date"; Date)
        {
            Caption = 'Estimated Close Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(45; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Contact Business Relation"."Contact No." where("No." = field("No."), "Link to Table" = const("Contact Business Relation Link To Table"::"BSD Object")));
            Editable = false;
        }
        field(46; "Opportunity Status"; Enum "Opportunity Status")
        {
            Caption = 'Opportunity Status';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(48; "No. of Archived Versions"; Integer)
        {
            CalcFormula = max("BSD Object Archive"."Version No." where("No." = field("No.")));
            Caption = 'No. of Archived Versions';
            Editable = false;
            FieldClass = FlowField;
        }
        field(91; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = CustomerContent;
            TableRelation = if ("Country/Region Code" = const('')) "Post Code"
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("Country/Region Code"));
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                PostCode: Record "Post Code";
            begin
                if Rec."Country/Region Code" <> '' then
                    PostCode.SetRange("Country/Region Code", Rec."Country/Region Code");
                if Page.RunModal(Page::"Post Codes", PostCode) = ACTION::LookupOK then begin
                    Rec.City := PostCode.City;
                    Rec."Post Code" := PostCode.Code;
                    Rec.County := PostCode."BSD County";
                    Rec.District := PostCode."BSD District";
                    Rec."Country/Region Code" := PostCode."Country/Region Code";
                end;
            end;
        }
        field(49; "No. of Sales Quotes"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Quote),
                                                      "BSD Object No." = field("No.")));
            Caption = 'No. of Quotes';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; "No. of Sales Blanket Orders"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = count("Sales Header" where("Document Type" = const("Blanket Order"),
                                                      "BSD Object No." = field("No.")));
            Caption = 'No. of Blanket Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51; "No. of Sales Orders"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = count("Sales Header" where("Document Type" = const(Order),
                                                      "BSD Object No." = field("No.")));
            Caption = 'No. of Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52; "No. of Sales Invoices"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Invoice),
                                                      "BSD Object No." = field("No.")));
            Caption = 'No. of Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(53; "No. of Sales Return Orders"; Integer)
        {
            AccessByPermission = TableData "Return Receipt Header" = R;
            CalcFormula = count("Sales Header" where("Document Type" = const("Return Order"),
                                                      "BSD Object No." = field("No.")));
            Caption = 'No. of Return Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(54; "No. of Sales Credit Memos"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const("Credit Memo"),
                                                      "BSD Object No." = field("No.")));
            Caption = 'No. of Credit Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55; "No. of Pstd. Sales Shipments"; Integer)
        {
            CalcFormula = count("Sales Shipment Header" where("BSD Object No." = field("No.")));
            Caption = 'No. of Pstd. Shipments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(56; "No. of Pstd. Sales Invoices"; Integer)
        {
            CalcFormula = count("Sales Invoice Header" where("BSD Object No." = field("No.")));
            Caption = 'No. of Pstd. Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; "No. of Pstd. Sales Ret. Rcpts."; Integer)
        {
            CalcFormula = count("Return Receipt Header" where("BSD Object No." = field("No.")));
            Caption = 'No. of Pstd. Return Receipts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(58; "No. of Pstd. Sales Cr. Memos"; Integer)
        {
            CalcFormula = count("Sales Cr.Memo Header" where("BSD Object No." = field("No.")));
            Caption = 'No. of Pstd. Credit Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "No. of Purchase Quotes"; Integer)
        {
            CalcFormula = count("Purchase Header" where("Document Type" = const(Quote),
                                                         "BSD Object No." = field("No.")));
            Caption = 'No. of Quotes';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "No. of Purch. Blanket Orders"; Integer)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = count("Purchase Header" where("Document Type" = const("Blanket Order"),
                                                         "BSD Object No." = field("No.")));
            Caption = 'No. of Blanket Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "No. of Purchase Orders"; Integer)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = count("Purchase Header" where("Document Type" = const(Order),
                                                         "BSD Object No." = field("No.")));
            Caption = 'No. of Orders';
            FieldClass = FlowField;
        }
        field(62; "No. of Purchase Invoices"; Integer)
        {
            CalcFormula = count("Purchase Header" where("Document Type" = const(Invoice),
                                                         "BSD Object No." = field("No.")));
            Caption = 'No. of Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(63; "No. of Purchase Return Orders"; Integer)
        {
            AccessByPermission = TableData "Return Shipment Header" = R;
            CalcFormula = count("Purchase Header" where("Document Type" = const("Return Order"),
                                                         "BSD Object No." = field("No.")));
            Caption = 'No. of Return Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64; "No. of Purchase Credit Memos"; Integer)
        {
            CalcFormula = count("Purchase Header" where("Document Type" = const("Credit Memo"),
                                                         "BSD Object No." = field("No.")));
            Caption = 'No. of Credit Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(69; "No. of Pstd. Purchase Receipts"; Integer)
        {
            CalcFormula = count("Purch. Rcpt. Header" where("BSD Object No." = field("No.")));
            Caption = 'No. of Pstd. Receipts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70; "No. of Pstd. Purchase Invoices"; Integer)
        {
            CalcFormula = count("Purch. Inv. Header" where("BSD Object No." = field("No.")));
            Caption = 'No. of Pstd. Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(71; "No. of Pstd. Purch. Ret. Ship."; Integer)
        {
            CalcFormula = count("Return Shipment Header" where("BSD Object No." = field("No.")));
            Caption = 'No. of Pstd. Return Shipments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(72; "No. of Pstd. Purch. Cr. Memos"; Integer)
        {
            CalcFormula = count("Purch. Cr. Memo Hdr." where("BSD Object No." = field("No.")));
            Caption = 'No. of Pstd. Credit Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(73; "No. of Archived Sales Orders"; Integer)
        {
            CalcFormula = count("Sales Header Archive" where("Document Type" = const(Order),
                                                      "BSD Object No." = field("No.")));
            Caption = 'No. of Archived Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(74; "No. of Archived Sales Quotes"; Integer)
        {
            CalcFormula = count("Sales Header Archive" where("Document Type" = const(Quote),
                                                      "BSD Object No." = field("No.")));
            Caption = 'No. of Archived Quotes';
            Editable = false;
            FieldClass = FlowField;
        }
        field(75; "No. of Archived Purch. Orders"; Integer)
        {
            CalcFormula = count("Purchase Header Archive" where("Document Type" = const(Order),
                                                         "BSD Object No." = field("No.")));
            Caption = 'No. of Archived Orders';
            FieldClass = FlowField;
        }
        field(76; "No. of Archived Purch. Quotes"; Integer)
        {
            CalcFormula = count("Purchase Header Archive" where("Document Type" = const(Quote),
                                                         "BSD Object No." = field("No.")));
            Caption = 'No. of Archived Quotes';
            Editable = false;
            FieldClass = FlowField;
        }
        field(77; "Responsibility Center Filter"; Code[10])
        {
            Caption = 'Responsibility Center Filter';
            ToolTip = 'Filter this page for a responsibility center specified in the Responsibility Center Relations.';
            DataClassification = CustomerContent;
            TableRelation = "BSD Object Resp. Center Rel."."Responsibility Center" where("Object No." = field("No."));
        }
        field(78; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        sisMANSetup: Record "BSD sisMAN Setup";
        NoSeries: Codeunit "No. Series";
        ObjContUpdate: Codeunit "BSD ObjCont-Update";
    begin
        sisMANSetup.Get();
        if "No." = '' then begin
            "No." := NoSeries.GetNextNo(sisMANSetup."Object Nos.");
            "No. Series" := sisMANSetup."Object Nos.";
        end;

        Rec.Validate("Creation Date", WorkDate());
        ObjContUpdate.OnInsert(Rec);

        InitDefaultDimension(Rec."No.");
    end;

    trigger OnModify()
    var
        ObjContUpdate: Codeunit "BSD ObjCont-Update";
    begin
        "Last Date Modified" := WorkDate();
        Modify();
        ObjContUpdate.OnModify(Rec);
    end;

    trigger OnDelete()
    var
        sisMANSetup: Record "BSD sisMAN Setup";
        ObjContUpdate: Codeunit "BSD ObjCont-Update";
        ArchiveQst: Label 'Do you want to archive this object before deletion?';
        DeletionErr: Label 'This object can not be deleted without archiving because it has been used for posting.';
        Archived: Boolean;
    begin
        Archived := false;

        sisMANSetup.Get();
        if sisMANSetup."Archive Objects" = sisMANSetup."Archive Objects"::Always then begin
            SendToArchive(Rec);
            Archived := true;
        end else
            if sisMANSetup."Archive Objects" = sisMANSetup."Archive Objects"::Question then
                if Confirm(ArchiveQst) then begin
                    SendToArchive(Rec);
                    Archived := true;
                end;

        if not Archived and not DeletionRequirementsMet() then
            Error(DeletionErr);

        ObjContUpdate.OnDelete(Rec);
        DeleteRelatedData(Rec);
    end;

    local procedure DeletionRequirementsMet(): Boolean
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        ItemLedgerEntry.SetRange("BSD Object No.", "No.");
        if not ItemLedgerEntry.IsEmpty then
            exit(false);

        CustLedgerEntry.SetRange("BSD Object No.", "No.");
        if not CustLedgerEntry.IsEmpty then
            exit(false);

        VendorLedgerEntry.SetRange("BSD Object No.", "No.");
        if not VendorLedgerEntry.IsEmpty then
            exit(false);

        exit(true);
    end;

    procedure ShowContact()
    var
        ContBusRel: Record "Contact Business Relation";
        Cont: Record Contact;
        OfficeContact: Record Contact;
        OfficeMgt: Codeunit "Office Management";
        ConfirmManagement: Codeunit "Confirm Management";
        ObjContUpdate: Codeunit "BSD ObjCont-Update";
        ContactPageID: Integer;
        CreateContactQst: Label 'Do you wish to create a contact for %1 %2?', comment = '%1 specifies the Table, %2 Specifies the No.';
    begin
        if OfficeMgt.GetContact(OfficeContact, "No.") and (OfficeContact.Count = 1) then begin
            ContactPageID := PAGE::"Contact Card";
            PAGE.Run(ContactPageID, OfficeContact);
        end else begin
            if "No." = '' then
                exit;

            ContBusRel.SetCurrentKey("Link to Table", "No.");
            ContBusRel.SetRange("Link to Table", ContBusRel."Link to Table"::"BSD Object");
            ContBusRel.SetRange("No.", "No.");
            if not ContBusRel.FindFirst() then begin
                if not ConfirmManagement.GetResponseOrDefault(StrSubstNo(CreateContactQst, TableCaption(), "No."), true) then
                    exit;
                ObjContUpdate.InsertNewContact(Rec);
                ContBusRel.FindFirst();
            end;
            Commit();

            Cont.FilterGroup(2);
            Cont.SetRange("Company No.", ContBusRel."Contact No.");
            if Cont.IsEmpty() then begin
                Cont.SetRange("Company No.");
                Cont.SetRange("No.", ContBusRel."Contact No.");
            end;
            ContactPageID := PAGE::"Contact List";
            PAGE.Run(ContactPageID, Cont);
        end;
    end;

    local procedure FillStatusFields()
    var
        Opportunity: Record Opportunity;
        OpportunityEntry: Record "Opportunity Entry";
    begin
        OpportunityEntry.SetRange("Opportunity No.", Rec."Opportunity No.");
        OpportunityEntry.SetRange(Active, true);
        if OpportunityEntry.FindFirst() then begin
            Rec."Sales Cycle Stage" := OpportunityEntry."Sales Cycle Stage";
            Rec."Sales Cycle Stage Description" := OpportunityEntry."Sales Cycle Stage Description";
            Rec."Estimated Close Date" := OpportunityEntry."Estimated Close Date";
            Rec."Estimated Value (LCY)" := OpportunityEntry."Estimated Value (LCY)";
            Rec."Chances of Success %" := OpportunityEntry."Chances of Success %";
            Rec."Completed %" := OpportunityEntry."Completed %";
            Rec."Probability %" := OpportunityEntry."Probability %";

            if Opportunity.Get(OpportunityEntry."Opportunity No.") then
                Rec."Opportunity Status" := Opportunity.Status;
        end;
    end;

    local procedure DeleteRelatedData(Object: Record "BSD Object")
    var
        sisMANSetup: Record "BSD sisMAN Setup";
        CommentLine: Record "Comment Line";
        ObjectProduct: Record "BSD Object Product";
        ObjectContributor: Record "BSD Object Contributor";
        Todo: Record "To-do";
        InteractionLogEntry: Record "Interaction Log Entry";
        ObjectRespCenterRel: Record "BSD Object Resp. Center Rel.";
        ObjectPicture: Record "BSD Object Picture";
        ObjectProductComment: Record "BSD Object Product Comment";
        Opportunity: Record Opportunity;
        DimensionValue: Record "Dimension Value";
        DefaultDimension: Record "Default Dimension";
    begin
        sisMANSetup.Get();

        ObjectRespCenterRel.SetRange("Object No.", Object."No.");
        ObjectRespCenterRel.DeleteAll();

        ObjectProduct.SetRange("Object No.", Object."No.");
        ObjectProduct.DeleteAll();

        ObjectProductComment.SetRange("Object No.", Object."No.");
        ObjectProductComment.DeleteAll();

        ObjectContributor.SetRange("Object No.", Object."No.");
        ObjectContributor.DeleteAll();

        ObjectPicture.SetRange("Object No.", Object."No.");
        ObjectPicture.DeleteAll();

        Todo.SetRange("BSD Object No.", Object."No.");
        Todo.DeleteAll();

        InteractionLogEntry.SetRange("BSD Object No.", Object."No.");
        InteractionLogEntry.DeleteAll();

        CommentLine.SetRange("Table Name", CommentLine."Table Name"::"BSD Object");
        CommentLine.SetRange("No.", Object."No.");
        CommentLine.DeleteAll();

        if DefaultDimension.Get(Database::"BSD Object", Object."No.", sisMANSetup."Object Type Dimension") then
            DefaultDimension.Delete();

        if DimensionValue.Get(sisMANSetup."Object Type Dimension", Object."No.") then
            DimensionValue.Delete();

        if Opportunity.Get(Object."Opportunity No.") then
            Opportunity.Delete();
    end;


    procedure SendToArchive(Object: Record "BSD Object")
    var
        ObjectContributor: Record "BSD Object Contributor";
        ObjectProduct: Record "BSD Object Product";
        ObjectArchive: Record "BSD Object Archive";
        ObjectContrArchive: Record "BSD Object Contr. Archive";
        ObjectProductArchive: Record "BSD Object Product Archive";
        ObjectRespCenterRel: Record "BSD Object Resp. Center Rel.";
        ObjRespCentRelArch: Record "BSD Obj. Resp. Cent. Rel.Arch.";
        ObjectPicture: Record "BSD Object Picture";
        ObjectPictureArchive: Record "BSD Object Picture Archive";
        ObjectProductComment: Record "BSD Object Product Comment";
        ObjectProdCommentArch: Record "BSD Object Prod. Comment Arch.";
        CommentLine: Record "Comment Line";
        CommentLineArchive: Record "Comment Line Archive";
        DefaultDimension: Record "Default Dimension";
        DefaultDimensionArchive: Record "BSD Default Dimension Archive";
        TempBlob: Codeunit "Temp Blob";
        Outstream: OutStream;
        Instream: Instream;
        VersionNo: Integer;
        SuccessMsg: Label 'Object %1 has been archived.', Comment = '%1 = Object No.';
    begin
        ObjectArchive.Reset();
        ObjectArchive.SetRange("No.", Object."No.");
        if ObjectArchive.FindLast() then
            VersionNo := ObjectArchive."Version No." + 1
        else
            VersionNo := 1;

        ObjectArchive.Init();
        ObjectArchive.TransferFields(Object);
        ObjectArchive."Version No." := VersionNo;
        ObjectArchive.Insert();

        ObjectContributor.SetRange("Object No.", Object."No.");
        if ObjectContributor.FindSet() then
            repeat
                ObjectContrArchive.Init();
                ObjectContrArchive.TransferFields(ObjectContributor);
                ObjectContrArchive."Version No." := VersionNo;
                ObjectContrArchive.Insert();
            until ObjectContributor.Next() = 0;

        ObjectProduct.SetRange("Object No.", Object."No.");
        if ObjectProduct.FindSet() then
            repeat
                ObjectProductArchive.Init();
                ObjectProductArchive.TransferFields(ObjectProduct);
                ObjectProductArchive."Version No." := VersionNo;
                ObjectProductArchive.Insert();
            until ObjectProduct.Next() = 0;

        ObjectRespCenterRel.SetRange("Object No.", Object."No.");
        if ObjectRespCenterRel.FindSet() then
            repeat
                ObjRespCentRelArch.Init();
                ObjRespCentRelArch.TransferFields(ObjectRespCenterRel);
                ObjRespCentRelArch."Version No." := VersionNo;
                ObjRespCentRelArch.Insert();
            until ObjectRespCenterRel.Next() = 0;

        CommentLine.SetRange("Table Name", "Comment Line Table Name"::"BSD Object");
        CommentLine.SetRange("No.", Object."No.");
        if CommentLine.FindSet() then
            repeat
                CommentLineArchive.Init();
                CommentLineArchive.TransferFields(CommentLine);
                CommentLineArchive."Version No." := VersionNo;
                CommentLineArchive.Insert();
            until CommentLine.Next() = 0;

        ObjectPicture.SetRange("Object No.", Object."No.");
        if ObjectPicture.FindSet() then
            repeat
                Outstream := TempBlob.CreateOutStream();
                ObjectPicture.Picture.ExportStream(Outstream);
                Instream := TempBlob.CreateInStream();

                ObjectPictureArchive.Init();
                ObjectPictureArchive.TransferFields(ObjectPicture);
                ObjectPictureArchive.Picture.ImportStream(Instream, '');
                ObjectPictureArchive."Version No." := VersionNo;
                ObjectPictureArchive.Insert();
            until ObjectPicture.Next() = 0;

        ObjectProductComment.SetRange("Object No.", Object."No.");
        if ObjectProductComment.FindSet() then
            repeat
                ObjectProdCommentArch.Init();
                ObjectProdCommentArch.TransferFields(ObjectProductComment);
                ObjectProdCommentArch."Version No." := VersionNo;
                ObjectProdCommentArch.Insert();
            until ObjectProductComment.Next() = 0;

        DefaultDimension.SetRange("Table ID", Database::"BSD Object");
        DefaultDimension.SetRange("No.", Object."No.");
        if DefaultDimension.FindSet() then
            repeat
                DefaultDimensionArchive.Init();
                DefaultDimensionArchive.TransferFields(DefaultDimension);
                DefaultDimensionArchive."Version No." := VersionNo;
                DefaultDimensionArchive.Insert();
            until DefaultDimension.Next() = 0;

        Message(SuccessMsg, Object."No.");
    end;

    procedure CreateInteractionFromObject(var Object: Record "BSD Object")
    var
        Contact: Record Contact;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        TempSegmentLine: Record "Segment Line" temporary;
    begin
        TempSegmentLine.Init();
        Object.CalcFields("Contact No.");
        if Contact.Get(Object."Contact No.") then begin
            Contact.CheckIfPrivacyBlockedGeneric();
            TempSegmentLine.Validate("Contact No.", Contact."Company No.");
            TempSegmentLine.SetRange("Contact No.", TempSegmentLine."Contact No.");
        end;
        if SalespersonPurchaser.Get(Object."Salesperson Code") then begin
            TempSegmentLine.Validate("Salesperson Code", SalespersonPurchaser.Code);
            TempSegmentLine.SetRange("Salesperson Code", TempSegmentLine."Salesperson Code");
        end;
        TempSegmentLine.Validate("BSD Object No.", Object."No.");
        TempSegmentLine.SetRange("BSD Object No.", TempSegmentLine."BSD Object No.");
        TempSegmentLine.Validate("BSD Responsibility Center", "Responsibility Center Filter");
        TempSegmentLine.Validate("BSD Responsibility Center", TempSegmentLine."BSD Responsibility Center");

        TempSegmentLine.StartWizard();
    end;

    procedure CreateTaskFromObject(Object: Record "BSD Object")
    var
        TempTodo: Record "To-do" temporary;
    begin
        TempTodo.DeleteAll();
        TempTodo.Init();
        TempTodo.Validate("Contact No.", Object."Contact No.");
        TempTodo.SetRange("Contact No.", Object."Contact No.");
        if Object."Salesperson Code" <> '' then begin
            "Salesperson Code" := Object."Salesperson Code";
            TempTodo.SetRange("Salesperson Code", "Salesperson Code");
        end;
        TempTodo.Validate("BSD Object No.", Object."No.");
        TempTodo.SetRange("BSD Object No.", TempTodo."BSD Object No.");
        TempTodo.Validate("BSD Responsibility Center", "Responsibility Center Filter");
        TempTodo.SetRange("BSD Responsibility Center", TempTodo."BSD Responsibility Center");

        TempTodo.StartWizard();
    end;

    procedure Navigate()
    var
        NavigatePage: Page "BSD Navigate";
    begin
        NavigatePage.SetRec(Rec."No.");
        NavigatePage.Run();
    end;

    procedure CreateOpportunities(var Object: Record "BSD Object")
    var
        ObjectRespCenterRel: Record "BSD Object Resp. Center Rel.";
    begin
        ObjectRespCenterRel.SetRange("Object No.", Rec."No.");
        if ObjectRespCenterRel.FindSet() then
            repeat
                ObjectRespCenterRel.CreateOpportunity(ObjectRespCenterRel);
            until ObjectRespCenterRel.Next() = 0
        else
            CreateOpportunity(Object);
    end;

    local procedure CreateOpportunity(var Object: Record "BSD Object")
    var
        Opportunity: Record Opportunity;
        SalesCycle: Record "Sales Cycle";
    begin
        if not Opportunity.Get(Object."No.") then begin
            Opportunity.Init();
            Opportunity."No." := Object."No.";
            Opportunity.Insert();
            Opportunity.Validate("Contact No.", Object."Contact No.");
            SalesCycle.SetFilter(Code, 'OBJECT|OBJEKT');
            if SalesCycle.FindFirst() then
                Opportunity."Sales Cycle Code" := SalesCycle.Code;
            Opportunity.Modify();
            Opportunity.StartActivateFirstStage();
            Object.Validate("Opportunity No.", Opportunity."No.");
        end else
            Object.Validate("Opportunity No.", Opportunity."No.");
    end;

    local procedure InitDefaultDimension(ObjectNo: Code[20])
    var
        DefaultDimension: Record "Default Dimension";
        DimensionValue: Record "Dimension Value";
        sisMANSetup: Record "BSD sisMAN Setup";
    begin
        sisMANSetup.Get();
        DimensionValue.Init();
        DimensionValue."Dimension Code" := sisMANSetup."Object Type Dimension";
        DimensionValue.Code := ObjectNo;
        DimensionValue.Insert();

        DefaultDimension.Init();
        DefaultDimension."Table ID" := Database::"BSD Object";
        DefaultDimension."Dimension Code" := sisMANSetup."Object Type Dimension";
        DefaultDimension."No." := ObjectNo;
        DefaultDimension."Dimension Value Code" := DimensionValue.Code;
        DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::"Same Code";
        DefaultDimension.Insert();
    end;

    procedure AssistEdit(OldObject: Record "BSD Object"): Boolean
    var
        Object: Record "BSD Object";
        sisMANSetup: Record "BSD sisMAN Setup";
        NoSeries: Codeunit "No. Series";
    begin
        Object := Rec;
        sisMANSetup.Get();
        sisMANSetup.TestField("Object Nos.");
        if NoSeries.LookupRelatedNoSeries(sisMANSetup."Object Nos.", OldObject."No. Series", Object."No. Series") then begin
            Object."No." := NoSeries.GetNextNo(Object."No. Series");
            Rec := Object;
            exit(true);
        end;
    end;
}