namespace BoSchData.sisMAN.Base;

using Microsoft.Inventory.Location;
using Microsoft.Inventory.Ledger;
using Microsoft.CRM.Contact;
using Microsoft.CostAccounting.Account;
using Microsoft.CRM.Interaction;
using Microsoft.CRM.Opportunity;
using Microsoft.Foundation.Comment;
using Microsoft.CRM.Task;

table 71458587 "BSD Object Resp. Center Rel."
{
    DrillDownPageID = "BSD Object Resp. Center Rel.";
    LookupPageID = "BSD Object Resp. Center Rel.";
    fields
    {
        field(1; "Object No."; Code[20])
        {
            Caption = 'Object No.';
            ToolTip = 'Specifies the Object No.';
            DataClassification = CustomerContent;
            TableRelation = "BSD Object";
        }
        field(2; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            ToolTip = 'Specifies the responsibility center.';
            DataClassification = CustomerContent;
            TableRelation = "Responsibility Center";
        }
        field(3; "Object Description"; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the related object.';
            FieldClass = FlowField;
            CalcFormula = lookup("BSD Object".Description where("No." = field("Object No.")));
        }
        field(4; "Responsibility Center Name"; Text[100])
        {
            Caption = 'Responsibility Center Name';
            ToolTip = 'Specifies the Name of the related Responsibility Center.';
            FieldClass = FlowField;
            CalcFormula = lookup("Responsibility Center".Name where(Code = field("Responsibility Center")));
        }
        field(5; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            ToolTip = 'Specifies the Contact No.';
            DataClassification = CustomerContent;
            TableRelation = Contact;
        }
        field(6; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            ToolTip = 'Specifies the Location Code.';
            DataClassification = CustomerContent;
            TableRelation = Location;
        }
        field(7; "Cost Center"; Code[20])
        {
            Caption = 'Cost Center';
            ToolTip = 'Specifies the Cost Center.';
            DataClassification = CustomerContent;
            TableRelation = "Cost Center";
        }
        field(8; "Cost Object"; Code[20])
        {
            Caption = 'Cost Object';
            ToolTip = 'Specifies the Cost Object.';
            DataClassification = CustomerContent;
            TableRelation = "Cost Object";
        }
        field(9; "Opportunity No."; Code[20])
        {
            Caption = 'Opportunity No.';
            ToolTip = 'Specifies the Opportunity No.';
            DataClassification = CustomerContent;
            TableRelation = Opportunity;

            trigger OnValidate()
            begin
                FillStatusFields();
            end;
        }
        field(10; Attentioncode; Code[20])
        {
            Caption = 'Attentioncode';
            ToolTip = 'Specifies the Attentioncode.';
            DataClassification = CustomerContent;
            TableRelation = "BSD Attention";
        }
        field(11; Tender; Code[20])
        {
            Caption = 'Tender';
            ToolTip = 'Specifies the Tender Code.';
            DataClassification = CustomerContent;
            TableRelation = "BSD Tender";
        }
        field(12; "Object End Date"; Date)
        {
            Caption = 'Object End Date';
            ToolTip = 'Specifies the Object End Date.';
            DataClassification = CustomerContent;
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
            FieldClass = FlowField;
            CalcFormula = min("Item Ledger Entry"."Posting Date" where("BSD Object No." = field("Object No.")));
            Editable = false;
        }
        field(23; "Last Item Shipment"; Date)
        {
            Caption = 'Last Item Shipment';
            ToolTip = 'Specifies the date of the last Item Shipment.';
            FieldClass = FlowField;
            CalcFormula = max("Item Ledger Entry"."Posting Date" where("BSD Object No." = field("Object No.")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Object No.", "Responsibility Center")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        Object: Record "BSD Object";
    begin
        if Object.Get(Rec."Object No.") then begin
            Object.CalcFields("Contact No.");
            Rec."Contact No." := Object."Contact No.";
        end;
    end;

    trigger OnDelete()
    begin
        DeleteRelatedData(Rec);
    end;

    local procedure DeleteRelatedData(ObjectRespCenterRel: Record "BSD Object Resp. Center Rel.")
    var
        CommentLine: Record "Comment Line";
        ObjectProduct: Record "BSD Object Product";
        ObjectContributor: Record "BSD Object Contributor";
        Todo: Record "To-do";
        InteractionLogEntry: Record "Interaction Log Entry";
        ObjectProductComment: Record "BSD Object Product Comment";
        Opportunity: Record Opportunity;
    begin
        ObjectProduct.SetRange("Object No.", ObjectRespCenterRel."Object No.");
        ObjectProduct.SetRange("Responsibility Center", ObjectRespCenterRel."Responsibility Center");
        if ObjectProduct.FindSet() then
            repeat
                ObjectProductComment.SetRange("Object No.", ObjectRespCenterRel."Object No.");
                ObjectProductComment.SetRange("Product Line No.", ObjectProduct."Line No.");
                ObjectProductComment.DeleteAll();

                ObjectProduct.Delete();
            until ObjectProduct.Next() = 0;

        ObjectContributor.SetRange("Object No.", ObjectRespCenterRel."Object No.");
        ObjectContributor.SetRange("Responsibility Center", ObjectRespCenterRel."Responsibility Center");
        ObjectContributor.DeleteAll();

        Todo.SetRange("BSD Object No.", ObjectRespCenterRel."Object No.");
        Todo.SetRange("BSD Responsibility Center", ObjectRespCenterRel."Responsibility Center");
        Todo.DeleteAll();

        InteractionLogEntry.SetRange("BSD Object No.", ObjectRespCenterRel."Object No.");
        InteractionLogEntry.SetRange("BSD Responsibility Center", ObjectRespCenterRel."Responsibility Center");
        InteractionLogEntry.DeleteAll();

        CommentLine.SetRange("Table Name", CommentLine."Table Name"::"BSD Object");
        CommentLine.SetRange("No.", ObjectRespCenterRel."Object No.");
        CommentLine.DeleteAll();

        if Opportunity.Get(ObjectRespCenterRel."Opportunity No.") then
            Opportunity.Delete();
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

    procedure CreateOpportunity(var ObjectRespCenterRel: Record "BSD Object Resp. Center Rel.")
    var
        Opportunity: Record Opportunity;
        SalesCycle: Record "Sales Cycle";
    begin
        if not Opportunity.Get(CopyStr(ObjectRespCenterRel."Object No." + '|' + ObjectRespCenterRel."Responsibility Center", 1, MaxStrLen(Opportunity."No."))) then begin
            Opportunity.Init();
            Opportunity."No." := CopyStr(ObjectRespCenterRel."Object No." + '|' + ObjectRespCenterRel."Responsibility Center", 1, MaxStrLen(Opportunity."No."));
            Opportunity.Insert();
            Opportunity.Validate("Contact No.", ObjectRespCenterRel."Contact No.");
            SalesCycle.SetFilter(Code, 'OBJECT|OBJEKT');
            if SalesCycle.FindFirst() then
                Opportunity."Sales Cycle Code" := SalesCycle.Code;
            Opportunity.Modify();
            Opportunity.StartActivateFirstStage();
            ObjectRespCenterRel.Validate("Opportunity No.", Opportunity."No.");
        end else
            ObjectRespCenterRel.Validate("Opportunity No.", Opportunity."No.");

        ObjectRespCenterRel.Modify();
    end;
}