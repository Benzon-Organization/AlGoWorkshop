namespace BoSchData.sisMAN.Base;
using Microsoft.Finance.Dimension;
using Microsoft.Sales.Document;
using Microsoft.Purchases.Document;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.CRM.Task;
using Microsoft.CRM.Interaction;
using Microsoft.CRM.Segment;
using Microsoft.Inventory.Posting;
using Microsoft.Inventory.Journal;
using Microsoft.CRM.Contact;
using Microsoft.CRM.BusinessRelation;
using Microsoft.Inventory.Ledger;
using Microsoft.Purchases.Payables;
using Microsoft.Sales.Receivables;
using Microsoft.Finance.GeneralLedger.Ledger;


codeunit 71458577 "BSD Eventsubscriber"
{
    [EventSubscriber(ObjectType::Table, Database::"Contact Business Relation", OnShowRelatedCardPageCaseElse, '', false, false)]
    local procedure ContactBusinessRelation_OnShowRelatedCardPageCaseElse(ContactBusinessRelation: Record "Contact Business Relation")
    var
        Object: Record "BSD Object";
    begin
        if ContactBusinessRelation."Link to Table" = ContactBusinessRelation."Link to Table"::"BSD Object" then begin
            Object.Get(ContactBusinessRelation."No.");
            Page.Run(Page::"BSD Object Card", Object);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CustVendBank-Update", OnRunCustVendBankUpdateCaseElse, '', false, false)]
    local procedure CustVendBankUpdate_OnRunCustVendBankUpdateCaseElse(var Contact: Record Contact; var ContactBusinessRelation: Record "Contact Business Relation")
    begin
        if ContactBusinessRelation."Link to Table" = ContactBusinessRelation."Link to Table"::"BSD Object" then
            UpdateObject(Contact, ContactBusinessRelation);
    end;

    procedure UpdateObject(var Cont: Record Contact; var ContBusRel: Record "Contact Business Relation")
    var
        Object: Record "BSD Object";
    begin
        Object.Get(ContBusRel."No.");
        Object.TransferFields(Cont);
        Object."No." := ContBusRel."No.";
        Object."Last Date Modified" := Today;
        Object.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', false, false)]
    local procedure GenJournalLine_OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."BSD Object No." := SalesHeader."BSD Object No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure CustLedgerEntry_OnAfterCopyCustLedgerEntryFromGenJnlLine(GenJournalLine: Record "Gen. Journal Line"; var CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        CustLedgerEntry."BSD Object No." := GenJournalLine."BSD Object No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromPurchHeader', '', false, false)]
    local procedure GenJournalLine_OnAfterCopyGenJnlLineFromPurchHeader(PurchaseHeader: Record "Purchase Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."BSD Object No." := PurchaseHeader."BSD Object No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure VendorLedgerEntry_OnAfterCopyVendLedgerEntryFromGenJnlLine(GenJournalLine: Record "Gen. Journal Line"; var VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        VendorLedgerEntry."BSD Object No." := GenJournalLine."BSD Object No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', false, false)]
    local procedure GLEntry_OnAfterCopyGLEntryFromGenJnlLine(GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    begin
        GLEntry."BSD Object No." := GenJournalLine."BSD Object No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromSalesHeader', '', false, false)]
    local procedure ItemJournalLine_OnAfterCopyItemJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var ItemJnlLine: Record "Item Journal Line")
    begin
        ItemJnlLine."BSD Object No." := SalesHeader."BSD Object No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromPurchHeader', '', false, false)]
    local procedure ItemJournalLine_OnAfterCopyItemJnlLineFromPurchHeader(PurchHeader: Record "Purchase Header"; var ItemJnlLine: Record "Item Journal Line")
    begin
        ItemJnlLine."BSD Object No." := PurchHeader."BSD Object No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure ItemJnlPostLine_OnAfterInitItemLedgEntry(var ItemJournalLine: Record "Item Journal Line"; var NewItemLedgEntry: Record "Item Ledger Entry")
    begin
        NewItemLedgEntry."BSD Object No." := ItemJournalLine."BSD Object No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Segment Line", 'OnAfterFinishWizard', '', false, false)]
    local procedure SegmentLine_OnAfterFinishWizard(var SegmentLine: Record "Segment Line"; InteractionLogEntry: Record "Interaction Log Entry")
    begin
        if SegmentLine."BSD Object No." <> '' then begin
            InteractionLogEntry."BSD Object No." := SegmentLine."BSD Object No.";
            InteractionLogEntry."BSD Responsibility Center" := SegmentLine."BSD Responsibility Center";
            InteractionLogEntry.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"To-do", 'OnAfterSetFilterFromTask', '', false, false)]
    local procedure Todo_OnAfterSetFilterFromTask(var ToTask: Record "To-do"; var FromTask: Record "To-do")
    var
        Object: Record "BSD Object";
    begin
        if Object.Get(FromTask."BSD Object No.") then begin
            ToTask.Validate("BSD Object No.", Object."No.");
            ToTask."Salesperson Code" := Object."Salesperson Code";
            ToTask.SetRange("BSD Object No.", ToTask."BSD Object No.");
            ToTask.Validate("BSD Responsibility Center", Object."Responsibility Center Filter");
            ToTask.SetRange("BSD Responsibility Center", ToTask."BSD Responsibility Center");
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Segment Line", OnCreateInteractionFromInteractLogEntryOnBeforeStartWizard, '', false, false)]
    local procedure SegmentLine_OnCreateInteractionFromInteractLogEntryOnBeforeStartWizard(var SegmentLine: Record "Segment Line"; var InteractionLogEntry: Record "Interaction Log Entry")
    var
        Object: Record "BSD Object";
    begin
        if Object.Get(InteractionLogEntry."BSD Object No.") then begin
            SegmentLine.Validate("BSD Object No.", Object."No.");
            SegmentLine."Salesperson Code" := Object."Salesperson Code";
            SegmentLine.SetRange("BSD Object No.", SegmentLine."BSD Object No.");
            SegmentLine.Validate("BSD Responsibility Center", Object."Responsibility Center Filter");
            SegmentLine.SetRange("BSD Responsibility Center", SegmentLine."BSD Responsibility Center");
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterInitDefaultDimensionSources, '', false, false)]
    local procedure SalesHeader_OnAfterInitDefaultDimensionSources(var SalesHeader: Record "Sales Header"; var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; FieldNo: Integer)
    var
        DimensionManagement: Codeunit DimensionManagement;
    begin
        DimensionManagement.AddDimSource(DefaultDimSource, Database::"BSD Object", SalesHeader."BSD Object No.", FieldNo = SalesHeader.FieldNo("BSD Object No."));
    end;

    [EventSubscriber(ObjectType::Page, Page::"Task List", OnBeforeCaption, '', false, false)]
    local procedure TaskList_OnAfterGetCaption(var ToDo: Record "To-do"; var CaptionStr: Text; var Handled: Boolean)
    var
        Object: Record "BSD Object";
    begin
        if Object.Get(ToDo.GetFilter("BSD Object No.")) then begin
            CaptionStr := CopyStr(CaptionStr + ' ' + Object."No." + ' ' + Object.Description, 1, MaxStrLen(CaptionStr));
            Handled := true;
        end;
    end;
}