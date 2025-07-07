namespace BoSchData.sisMAN.Base;
using Microsoft.Foundation.Navigate;
using Microsoft.Service.History;
using Microsoft.Assembly.History;
using Microsoft.Bank.Check;
using Microsoft.Inventory.Counting.History;
using Microsoft.Service.Document;
using Microsoft.Sales.Document;
using Microsoft.Sales.History;
using Microsoft.Bank.BankAccount;
using Microsoft.Inventory.History;
using Microsoft.Purchases.Document;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.EServices.EDocument;
using Microsoft.CostAccounting.Ledger;
using Microsoft.Warehouse.Ledger;
using Microsoft.Service.Ledger;
using Microsoft.Manufacturing.Capacity;
using Microsoft.FixedAssets.Insurance;
using Microsoft.FixedAssets.Maintenance;
using Microsoft.FixedAssets.Ledger;
using Microsoft.Bank.Ledger;
using Microsoft.Projects.Project.WIP;
using Microsoft.Projects.Project.Ledger;
using Microsoft.Projects.Resources.Ledger;
using Microsoft.Inventory.Counting.Journal;
using Microsoft.Inventory.Ledger;
using Microsoft.HumanResources.Payables;
using Microsoft.Purchases.Payables;
using Microsoft.Sales.Receivables;
using Microsoft.Finance.VAT.Ledger;
using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Warehouse.History;
using Microsoft.Inventory.Transfer;
using Microsoft.Manufacturing.Document;
using Microsoft.Purchases.History;
using Microsoft.Sales.FinanceCharge;
using Microsoft.Sales.Reminder;
using Microsoft.Purchases.Vendor;
using Microsoft.Sales.Customer;

page 71458592 "BSD Navigate"
{
    AdditionalSearchTerms = 'find,search,analyze,navigate';
    ApplicationArea = All;
    Caption = 'Find entries for Object';
    DataCaptionExpression = GetCaptionText();
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Document Entry";
    SourceTableTemporary = true;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group("Business Contact")
            {
                Caption = 'Business Contact';
                ShowCaption = false;

                field(ObjectNo; ObjectNo)
                {
                    ApplicationArea = All;
                    Caption = 'Object No.';
                    ToolTip = 'Specifies the number of the object that you want to find entries for.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Object: Record "BSD Object";
                    begin
                        if PAGE.RunModal(Page::"BSD Object List", Object) = ACTION::LookupOK then begin
                            Text := Object."No.";
                            exit(true);
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        ContactNoOnAfterValidate();
                        FilterSelectionChanged();
                    end;
                }
                // field(ExtDocNo; ExtDocNo)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'External Document No.';
                //     ToolTip = 'Specifies the document number assigned by the vendor.';

                //     trigger OnValidate()
                //     begin
                //         ExtDocNoOnAfterValidate();
                //         FilterSelectionChanged();
                //     end;
                // }
            }
            group(Notification)
            {
                Caption = 'Notification';
                InstructionalText = 'The filter has been changed. Choose Find to update the list of related entries.';
                Visible = FilterSelectionChangedTxtVisible;
            }
            repeater(Control16)
            {
                Editable = false;
                ShowCaption = false;
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                    Visible = false;
                }
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the table that the entry is stored in.';
                    Visible = false;
                }
                field("Table Name"; Rec."Table Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Related Entries';
                    ToolTip = 'Specifies the name of the table where the Navigate facility has found entries with the selected document number and/or posting date.';

                    trigger OnDrillDown()
                    begin
                        ShowRecords();
                    end;
                }
                field("No. of Records"; Rec."No. of Records")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'No. of Entries';
                    DrillDown = true;
                    ToolTip = 'Specifies the number of documents that the Navigate facility has found in the table with the selected entries.';

                    trigger OnDrillDown()
                    begin
                        ShowRecords();
                    end;
                }
            }
            group(Source)
            {
                Caption = 'Source';
                field(DocTypeFld; DocTypeGlobal)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Document Type';
                    Editable = false;
                    Enabled = DocTypeEnable;
                    ToolTip = 'Specifies the type of the selected document. Leave the Document Type field blank if you want to search by posting date. The entry''s document number is shown in the Document No. field.';
                }
                field(SourceType; SourceType)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Source Type';
                    Editable = false;
                    Enabled = SourceTypeEnable;
                    ToolTip = 'Specifies the source type of the selected document or remains blank if you search by posting date. The entry''s document number is shown in the Document No. field.';
                }
                field(SourceNo; SourceNo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Source No.';
                    Editable = false;
                    Enabled = SourceNoEnable;
                    ToolTip = 'Specifies the source number of the selected document. The entry''s document number is shown in the Document No. field.';
                }
                field(SourceName; SourceName)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Source Name';
                    Editable = false;
                    Enabled = SourceNameEnable;
                    ToolTip = 'Specifies the source name on the selected entry. The entry''s document number is shown in the Document No. field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Process)
            {
                Caption = 'Process';
                action(Show)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Show Related Entries';
                    Enabled = ShowEnable;
                    Image = ViewDocumentLine;
                    ToolTip = 'View the related entries of the type that you have chosen.';

                    trigger OnAction()
                    begin
                        ShowRecords();
                    end;
                }
                action("Find")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Fi&nd';
                    Image = Find;
                    ToolTip = 'Apply a filter to search on this page.';

                    trigger OnAction()
                    var
                        EnterObjectNoErr: Label 'Please enter an Object No. to find entries.';
                    begin
                        if ObjectNo = '' then
                            Error(EnterObjectNoErr);
                        FindRecords();
                        FilterSelectionChangedTxtVisible := false;
                    end;
                }
                action(Print)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Print';
                    Ellipsis = true;
                    Enabled = PrintEnable;
                    Image = Print;
                    ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                    trigger OnAction()
                    var
                        DocumentEntries: Report "Document Entries";
                    begin
                        DocumentEntries.TransferDocEntries(Rec);
                        DocumentEntries.Run();
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                actionref(Show_Promoted; Show)
                {
                }
                actionref(Find_Promoted; Find)
                {
                }
                actionref(Print_Promoted; Print)
                {
                }
            }
            group(Category_Category4)
            {
                Caption = 'Find By', Comment = 'Generated from the PromotedActionCategories property index 3.';
            }
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';
            }
        }
    }

    trigger OnInit()
    begin
        SourceNameEnable := true;
        SourceNoEnable := true;
        SourceTypeEnable := true;
        DocTypeEnable := true;
        PrintEnable := true;
        ShowEnable := true;
    end;

    trigger OnOpenPage()
    begin
        UpdateFindByGroupsVisibility();
        UpdateForm := true;
        ObjectNo := NewObjectNo;
        FindRecords();
    end;

    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        Customer: Record Customer;
        [SecurityFiltering(SecurityFilter::Filtered)]
        Vend: Record Vendor;
        [SecurityFiltering(SecurityFilter::Filtered)]
        ServShptHeader: Record "Service Shipment Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        ServInvHeader: Record "Service Invoice Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        ServCrMemoHeader: Record "Service Cr.Memo Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        IssuedReminderHeader: Record "Issued Reminder Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        IssuedFinChrgMemoHeader: Record "Issued Fin. Charge Memo Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        PurchInvHeader: Record "Purch. Inv. Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        ReturnShptHeader: Record "Return Shipment Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        [SecurityFiltering(SecurityFilter::Filtered)]
        ProductionOrderHeader: Record "Production Order";
        [SecurityFiltering(SecurityFilter::Filtered)]
        PostedAssemblyHeader: Record "Posted Assembly Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        TransShptHeader: Record "Transfer Shipment Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        TransRcptHeader: Record "Transfer Receipt Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        PostedWhseRcptLine: Record "Posted Whse. Receipt Line";
        [SecurityFiltering(SecurityFilter::Filtered)]
        PostedWhseShptLine: Record "Posted Whse. Shipment Line";
        [SecurityFiltering(SecurityFilter::Filtered)]
        GLEntry: Record "G/L Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        VATEntry: Record "VAT Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        CustLedgEntry: Record "Cust. Ledger Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        VendLedgEntry: Record "Vendor Ledger Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        EmplLedgEntry: Record "Employee Ledger Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        DtldEmplLedgEntry: Record "Detailed Employee Ledger Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        ItemLedgEntry: Record "Item Ledger Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        PhysInvtLedgEntry: Record "Phys. Inventory Ledger Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        ResLedgEntry: Record "Res. Ledger Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        JobLedgEntry: Record "Job Ledger Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        JobWIPEntry: Record "Job WIP Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        JobWIPGLEntry: Record "Job WIP G/L Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        ValueEntry: Record "Value Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        CheckLedgEntry: Record "Check Ledger Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        ReminderEntry: Record "Reminder/Fin. Charge Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        FALedgEntry: Record "FA Ledger Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        MaintenanceLedgEntry: Record "Maintenance Ledger Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        InsuranceCovLedgEntry: Record "Ins. Coverage Ledger Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        CapacityLedgEntry: Record "Capacity Ledger Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        ServLedgerEntry: Record "Service Ledger Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        WarrantyLedgerEntry: Record "Warranty Ledger Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        WhseEntry: Record "Warehouse Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        CostEntry: Record "Cost Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        IncomingDocument: Record "Incoming Document";
        [SecurityFiltering(SecurityFilter::Filtered)]
        PostedGenJournalLine: Record "Posted Gen. Journal Line";
        [SecurityFiltering(SecurityFilter::Filtered)]
        IssuedDeliveryReminderHeader: Record "Issued Deliv. Reminder Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        DelivReminLedgerEntries: Record "Delivery Reminder Ledger Entry";
        [SecurityFiltering(SecurityFilter::Filtered)]
        PostedInvtRcptHeader: Record "Invt. Receipt Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        PostedInvtShptHeader: Record "Invt. Shipment Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        BankAccount: Record "Bank Account";
        CountMsg: Label 'Counting records...';
        NoRelatedDataMsg: Label 'There are no entries or documents related to this object.';
        ExtDocMsg: Label 'The search results in too many external documents. Specify a business contact no.';
        ExtDocGlMsg: Label 'The search results in too many external documents. Use Navigate from the relevant ledger entries.';
        PostedSalesInvoiceTxt: Label 'Posted Sales Invoice';
        PostedSalesCreditMemoTxt: Label 'Posted Sales Credit Memo';
        PostedSalesShipmentTxt: Label 'Posted Sales Shipment';
        PostedPurchaseInvoiceTxt: Label 'Posted Purchase Invoice';
        PostedPurchaseCreditMemoTxt: Label 'Posted Purchase Credit Memo';
        PostedPurchaseReceiptTxt: Label 'Posted Purchase Receipt';
        PostedReturnReceiptTxt: Label 'Posted Return Receipt';
        PostedReturnShipmentTxt: Label 'Posted Return Shipment';
        SalesQuoteTxt: Label 'Sales Quote';
        SalesOrderTxt: Label 'Sales Order';
        SalesInvoiceTxt: Label 'Sales Invoice';
        PurchaseQuoteTxt: Label 'Purchase Quote';
        PurchaseOrderTxt: Label 'Purchase Order';
        PurchaseInvoiceTxt: Label 'Purchase Invoice';
        SalesReturnOrderTxt: Label 'Sales Return Order';
        SalesCreditMemoTxt: Label 'Sales Credit Memo';
        Window: Dialog;
        DocTypeGlobal: Text[100];
        SourceType: Text[30];
        SourceNo: Code[20];
        SourceName: Text[100];
        ShowEnable: Boolean;
        PrintEnable: Boolean;
        DocTypeEnable: Boolean;
        SourceTypeEnable: Boolean;
        SourceNoEnable: Boolean;
        SourceNameEnable: Boolean;
        UpdateForm: Boolean;
        FilterSelectionChangedTxtVisible: Boolean;
        PageCaptionTxt: Label 'Selected - %1', comment = '%1 count';

    protected var
        [SecurityFiltering(SecurityFilter::Filtered)]
        SalesShptHeader: Record "Sales Shipment Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        SalesInvHeader: Record "Sales Invoice Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        ReturnRcptHeader: Record "Return Receipt Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        SQSalesHeader: Record "Sales Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        SOSalesHeader: Record "Sales Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        SISalesHeader: Record "Sales Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        SROSalesHeader: Record "Sales Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        SCMSalesHeader: Record "Sales Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        PQPurchaseHeader: Record "Purchase Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        POPurchaseHeader: Record "Purchase Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        PIPurchaseHeader: Record "Purchase Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        GenJnlLine: Record "Gen. Journal Line";
        [SecurityFiltering(SecurityFilter::Filtered)]
        SOServHeader: Record "Service Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        SIServHeader: Record "Service Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        SCMServHeader: Record "Service Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        PstdPhysInvtOrderHdr: Record "Pstd. Phys. Invt. Order Hdr";
        ObjectNo: Code[250];
        NewObjectNo: Code[20];
        DocExists: Boolean;
        ExtDocNo: Code[250];

    procedure SetRec(ObjectNo2: Code[20])
    begin
        NewObjectNo := ObjectNo2;
    end;

    procedure FindRecords()
    var
        IsSourceUpdated: Boolean;
        HideDialog: Boolean;
    begin
        if not HideDialog then
            Window.Open(CountMsg);
        Rec.Reset();
        Rec.DeleteAll();
        Rec."Entry No." := 0;

        FindPostedDocuments();
        FindLedgerEntries();
        FindUnpostedPurchaseDocs(PQPurchaseHeader."Document Type"::Quote, PurchaseQuoteTxt, PQPurchaseHeader);
        FindUnpostedPurchaseDocs(POPurchaseHeader."Document Type"::Order, PurchaseOrderTxt, POPurchaseHeader);
        FindUnpostedPurchaseDocs(PIPurchaseHeader."Document Type"::Invoice, PurchaseInvoiceTxt, PIPurchaseHeader);
        FindUnpostedSalesDocs(SQSalesHeader."Document Type"::Quote, SalesQuoteTxt, SQSalesHeader);
        FindUnpostedSalesDocs(SOSalesHeader."Document Type"::Order, SalesOrderTxt, SOSalesHeader);
        FindUnpostedSalesDocs(SISalesHeader."Document Type"::Invoice, SalesInvoiceTxt, SISalesHeader);
        FindUnpostedSalesDocs(SROSalesHeader."Document Type"::"Return Order", SalesReturnOrderTxt, SROSalesHeader);
        FindUnpostedSalesDocs(SCMSalesHeader."Document Type"::"Credit Memo", SalesCreditMemoTxt, SCMSalesHeader);

        DocExists := Rec.FindFirst();

        SetSource(0D, '', '', 0, '');
        if DocExists then begin
            if not IsSourceUpdated then begin
                SetSourceForService();
                SetSourceForSales();
                SetSourceForPurchase();
                SetSourceForServiceDoc();
            end;

        end else
            Message(NoRelatedDataMsg);

        if UpdateForm then
            UpdateFormAfterFindRecords();

        if not HideDialog then
            Window.Close();
    end;

    local procedure FindLedgerEntries()
    begin
        FindGLEntries();
        FindCustEntries();
        FindVendEntries();
    end;

    local procedure FindCustEntries()
    var
        IsHandled: Boolean;
    begin
        if CustLedgEntry.ReadPermission() and (not IsHandled) then begin
            CustLedgEntry.Reset();
            CustLedgEntry.SetCurrentKey("Document No.");
            CustLedgEntry.SetFilter("BSD Object No.", ObjectNo);
            CustLedgEntry.SetFilter("External Document No.", ExtDocNo);
            Rec.InsertIntoDocEntry(Database::"Cust. Ledger Entry", CustLedgEntry.TableCaption(), CustLedgEntry.Count);
        end;
        // if DtldCustLedgEntry.ReadPermission() then begin
        //     DtldCustLedgEntry.Reset();
        //     DtldCustLedgEntry.SetCurrentKey("Document No.");
        //     InsertIntoDocEntry(Rec, Database::"Detailed Cust. Ledg. Entry", DtldCustLedgEntry.TableCaption(), DtldCustLedgEntry.Count);
        // end;
    end;

    local procedure FindVendEntries()
    var
        IsHandled: Boolean;
    begin
        if VendLedgEntry.ReadPermission() and (not IsHandled) then begin
            VendLedgEntry.Reset();
            VendLedgEntry.SetCurrentKey("Document No.");
            VendLedgEntry.SetFilter("BSD Object No.", ObjectNo);
            VendLedgEntry.SetFilter("External Document No.", ExtDocNo);
            Rec.InsertIntoDocEntry(Database::"Vendor Ledger Entry", VendLedgEntry.TableCaption(), VendLedgEntry.Count);
        end;
        // if DtldVendLedgEntry.ReadPermission() then begin
        //     DtldVendLedgEntry.Reset();
        //     DtldVendLedgEntry.SetCurrentKey("Document No.");
        //     InsertIntoDocEntry(Rec, Database::"Detailed Vendor Ledg. Entry", DtldVendLedgEntry.TableCaption(), DtldVendLedgEntry.Count);
        // end;
    end;

    local procedure FindGLEntries()
    var
        IsHandled: Boolean;
    begin
        if GLEntry.ReadPermission() and (not IsHandled) then begin
            GLEntry.Reset();
            GLEntry.SetCurrentKey("Document No.", "Posting Date");
            GLEntry.SetFilter("BSD Object No.", ObjectNo);
            GLEntry.SetFilter("External Document No.", ExtDocNo);
            Rec.InsertIntoDocEntry(Database::"G/L Entry", GLEntry.TableCaption(), GLEntry.Count);
        end;
    end;

    local procedure FindPostedDocuments()
    begin
        FindSalesShipmentHeader();
        FindSalesInvoiceHeader();
        FindReturnRcptHeader();
        FindSalesCrMemoHeader();
        FindPurchRcptHeader();
        FindPurchInvoiceHeader();
        FindReturnShptHeader();
        FindPurchCrMemoHeader();
    end;

    local procedure FindSalesShipmentHeader()
    begin
        if SalesShptHeader.ReadPermission() then begin
            SalesShptHeader.Reset();
            SalesShptHeader.SetFilter("BSD Object No.", ObjectNo);
            SalesShptHeader.SetFilter("External Document No.", ExtDocNo);
            Rec.InsertIntoDocEntry(Database::"Sales Shipment Header", PostedSalesShipmentTxt, SalesShptHeader.Count);
        end;
    end;

    local procedure FindSalesInvoiceHeader()
    begin
        if SalesInvHeader.ReadPermission() then begin
            SalesInvHeader.Reset();
            SalesInvHeader.SetFilter("BSD Object No.", ObjectNo);
            SalesInvHeader.SetFilter("External Document No.", ExtDocNo);
            Rec.InsertIntoDocEntry(Database::"Sales Invoice Header", PostedSalesInvoiceTxt, SalesInvHeader.Count);
        end;
    end;

    local procedure FindSalesCrMemoHeader()
    begin
        if SalesCrMemoHeader.ReadPermission() then begin
            SalesCrMemoHeader.Reset();
            SalesCrMemoHeader.SetFilter("BSD Object No.", ObjectNo);
            SalesCrMemoHeader.SetFilter("External Document No.", ExtDocNo);
            Rec.InsertIntoDocEntry(Database::"Sales Cr.Memo Header", PostedSalesCreditMemoTxt, SalesCrMemoHeader.Count);
        end;
    end;

    local procedure FindReturnRcptHeader()
    begin
        if ReturnRcptHeader.ReadPermission() then begin
            ReturnRcptHeader.Reset();
            ReturnRcptHeader.SetFilter("BSD Object No.", ObjectNo);
            ReturnRcptHeader.SetFilter("External Document No.", ExtDocNo);
            Rec.InsertIntoDocEntry(Database::"Return Receipt Header", PostedReturnReceiptTxt, ReturnRcptHeader.Count);
        end;
    end;

    local procedure FindPurchRcptHeader()
    begin
        if PurchRcptHeader.ReadPermission() then begin
            PurchRcptHeader.Reset();
            PurchRcptHeader.SetFilter("BSD Object No.", ObjectNo);
            PurchRcptHeader.SetFilter("Vendor Shipment No.", ExtDocNo);
            Rec.InsertIntoDocEntry(Database::"Purch. Rcpt. Header", PostedPurchaseReceiptTxt, PurchRcptHeader.Count);
        end;
    end;

    local procedure FindPurchInvoiceHeader()
    begin
        if PurchInvHeader.ReadPermission() then begin
            PurchInvHeader.Reset();
            PurchInvHeader.SetFilter("BSD Object No.", ObjectNo);
            PurchInvHeader.SetFilter("Vendor Invoice No.", ExtDocNo);
            Rec.InsertIntoDocEntry(Database::"Purch. Inv. Header", PostedPurchaseInvoiceTxt, PurchInvHeader.Count);
        end;
    end;

    local procedure FindPurchCrMemoHeader()
    begin
        if PurchCrMemoHeader.ReadPermission() then begin
            PurchCrMemoHeader.Reset();
            PurchCrMemoHeader.SetFilter("BSD Object No.", ObjectNo);
            Rec.InsertIntoDocEntry(Database::"Purch. Cr. Memo Hdr.", PostedPurchaseCreditMemoTxt, PurchCrMemoHeader.Count);
        end;
    end;

    local procedure FindReturnShptHeader()
    begin
        if ReturnShptHeader.ReadPermission() then begin
            ReturnShptHeader.Reset();
            ReturnShptHeader.SetFilter("BSD Object No.", ObjectNo);
            Rec.InsertIntoDocEntry(Database::"Return Shipment Header", PostedReturnShipmentTxt, ReturnShptHeader.Count);
        end;
    end;

    protected procedure UpdateFormAfterFindRecords()
    begin
        DocExists := Rec.FindFirst();
        ShowEnable := DocExists;
        PrintEnable := DocExists;
        CurrPage.Update(false);
    end;

    protected procedure NoOfRecords(TableID: Integer): Integer
    begin
        Rec.SetRange("Table ID", TableID);
        if not Rec.FindFirst() then
            Rec.Init();
        Rec.SetRange("Table ID");
        exit(Rec."No. of Records");
    end;

    procedure SetSource(PostingDate: Date; DocType2: Text[100]; DocNo: Text[50]; SourceType2: Integer; SourceNo2: Code[20])
    begin
        if SourceType2 = 0 then begin
            DocTypeGlobal := '';
            SourceType := '';
            SourceNo := '';
            SourceName := '';
        end else begin
            DocTypeGlobal := DocType2;
            SourceNo := SourceNo2;
            Rec.SetRange("Document No.", DocNo);
            Rec.SetRange("Posting Date", PostingDate);
            case SourceType2 of
                1:
                    begin
                        SourceType := CopyStr(Customer.TableCaption(), 1, MaxStrLen(SourceType));
                        if not Customer.Get(SourceNo) then
                            Customer.Init();
                        SourceName := Customer.Name;
                    end;
                2:
                    begin
                        SourceType := CopyStr(Vend.TableCaption(), 1, MaxStrLen(SourceType));
                        if not Vend.Get(SourceNo) then
                            Vend.Init();
                        SourceName := Vend.Name;
                    end;
                4:
                    begin
                        SourceType := CopyStr(BankAccount.TableCaption(), 1, MaxStrLen(SourceType));
                        if not BankAccount.Get(SourceNo) then
                            BankAccount.Init();
                        SourceName := BankAccount.Name;
                    end;
            end;
        end;
        DocTypeEnable := SourceType2 <> 0;
        SourceTypeEnable := SourceType2 <> 0;
        SourceNoEnable := SourceType2 <> 0;
        SourceNameEnable := SourceType2 <> 0;
    end;

    local procedure SetSourceForPurchase()
    begin
        if NoOfRecords(Database::"Vendor Ledger Entry") = 1 then begin
            VendLedgEntry.FindFirst();
            SetSource(
              VendLedgEntry."Posting Date", Format(VendLedgEntry."Document Type"), VendLedgEntry."Document No.",
              2, VendLedgEntry."Vendor No.");
        end;
        if NoOfRecords(Database::"Detailed Vendor Ledg. Entry") = 1 then begin
            DtldVendLedgEntry.FindFirst();
            SetSource(
              DtldVendLedgEntry."Posting Date", Format(DtldVendLedgEntry."Document Type"), DtldVendLedgEntry."Document No.",
              2, DtldVendLedgEntry."Vendor No.");
        end;
        if NoOfRecords(Database::"Purch. Inv. Header") = 1 then begin
            PurchInvHeader.FindFirst();
            SetSource(
              PurchInvHeader."Posting Date", Format(Rec."Table Name"), PurchInvHeader."No.",
              2, PurchInvHeader."Pay-to Vendor No.");
        end;
        if NoOfRecords(Database::"Purch. Cr. Memo Hdr.") = 1 then begin
            PurchCrMemoHeader.FindFirst();
            SetSource(
              PurchCrMemoHeader."Posting Date", Format(Rec."Table Name"), PurchCrMemoHeader."No.",
              2, PurchCrMemoHeader."Pay-to Vendor No.");
        end;
        if NoOfRecords(Database::"Return Shipment Header") = 1 then begin
            ReturnShptHeader.FindFirst();
            SetSource(
              ReturnShptHeader."Posting Date", Format(Rec."Table Name"), ReturnShptHeader."No.",
              2, ReturnShptHeader."Buy-from Vendor No.");
        end;
        if NoOfRecords(Database::"Purch. Rcpt. Header") = 1 then begin
            PurchRcptHeader.FindFirst();
            SetSource(
              PurchRcptHeader."Posting Date", Format(Rec."Table Name"), PurchRcptHeader."No.",
              2, PurchRcptHeader."Buy-from Vendor No.");
        end;
        if NoOfRecords(Database::"Posted Whse. Receipt Line") = 1 then begin
            PostedWhseRcptLine.FindFirst();
            SetSource(
              PostedWhseRcptLine."Posting Date", Format(Rec."Table Name"), PostedWhseRcptLine."Posted Source No.",
              2, '');
        end;
        if NoOfRecords(Database::"Pstd. Phys. Invt. Order Hdr") = 1 then begin
            PstdPhysInvtOrderHdr.FindFirst();
            SetSource(
              PstdPhysInvtOrderHdr."Posting Date", Format(Rec."Table Name"), PstdPhysInvtOrderHdr."No.",
              3, '');
        end;
        if NoOfRecords(DATABASE::"Issued Deliv. Reminder Header") = 1 then begin
            IssuedDeliveryReminderHeader.FindFirst();
            SetSource(
                IssuedDeliveryReminderHeader."Posting Date", Format(Rec."Table Name"), IssuedDeliveryReminderHeader."No.",
                2, IssuedDeliveryReminderHeader."Vendor No.");
        end;
    end;

    local procedure SetSourceForSales()
    begin
        if NoOfRecords(Database::"Cust. Ledger Entry") = 1 then begin
            CustLedgEntry.FindFirst();
            SetSource(
              CustLedgEntry."Posting Date", Format(CustLedgEntry."Document Type"), CustLedgEntry."Document No.",
              1, CustLedgEntry."Customer No.");
        end;
        if NoOfRecords(Database::"Detailed Cust. Ledg. Entry") = 1 then begin
            DtldCustLedgEntry.FindFirst();
            SetSource(
              DtldCustLedgEntry."Posting Date", Format(DtldCustLedgEntry."Document Type"), DtldCustLedgEntry."Document No.",
              1, DtldCustLedgEntry."Customer No.");
        end;
        if NoOfRecords(Database::"Sales Invoice Header") = 1 then begin
            SalesInvHeader.FindFirst();
            SetSource(
              SalesInvHeader."Posting Date", Format(Rec."Table Name"), SalesInvHeader."No.",
              1, SalesInvHeader."Bill-to Customer No.");
        end;
        if NoOfRecords(Database::"Sales Cr.Memo Header") = 1 then begin
            SalesCrMemoHeader.FindFirst();
            SetSource(
              SalesCrMemoHeader."Posting Date", Format(Rec."Table Name"), SalesCrMemoHeader."No.",
              1, SalesCrMemoHeader."Bill-to Customer No.");
        end;
        if NoOfRecords(Database::"Return Receipt Header") = 1 then begin
            ReturnRcptHeader.FindFirst();
            SetSource(
              ReturnRcptHeader."Posting Date", Format(Rec."Table Name"), ReturnRcptHeader."No.",
              1, ReturnRcptHeader."Sell-to Customer No.");
        end;
        if NoOfRecords(Database::"Sales Shipment Header") = 1 then begin
            SalesShptHeader.FindFirst();
            SetSource(
              SalesShptHeader."Posting Date", Format(Rec."Table Name"), SalesShptHeader."No.",
              1, SalesShptHeader."Sell-to Customer No.");
        end;
        if NoOfRecords(Database::"Posted Whse. Shipment Line") = 1 then begin
            PostedWhseShptLine.FindFirst();
            SetSource(
              PostedWhseShptLine."Posting Date", Format(Rec."Table Name"), PostedWhseShptLine."Posted Source No.",
              1, PostedWhseShptLine."Destination No.");
        end;
        if NoOfRecords(Database::"Issued Reminder Header") = 1 then begin
            IssuedReminderHeader.FindFirst();
            SetSource(
              IssuedReminderHeader."Posting Date", Format(Rec."Table Name"), IssuedReminderHeader."No.",
              1, IssuedReminderHeader."Customer No.");
        end;
        if NoOfRecords(Database::"Issued Fin. Charge Memo Header") = 1 then begin
            IssuedFinChrgMemoHeader.FindFirst();
            SetSource(
              IssuedFinChrgMemoHeader."Posting Date", Format(Rec."Table Name"), IssuedFinChrgMemoHeader."No.",
              1, IssuedFinChrgMemoHeader."Customer No.");
        end;
    end;

    local procedure SetSourceForService()
    begin
        if NoOfRecords(Database::"Service Ledger Entry") = 1 then begin
            ServLedgerEntry.FindFirst();
            if ServLedgerEntry.Type = ServLedgerEntry.Type::"Service Contract" then
                SetSource(
                  ServLedgerEntry."Posting Date", Format(ServLedgerEntry."Document Type"), ServLedgerEntry."Document No.",
                  2, ServLedgerEntry."Service Contract No.")
            else
                SetSource(
                  ServLedgerEntry."Posting Date", Format(ServLedgerEntry."Document Type"), ServLedgerEntry."Document No.",
                  2, ServLedgerEntry."Service Order No.")
        end;
        if NoOfRecords(Database::"Warranty Ledger Entry") = 1 then begin
            WarrantyLedgerEntry.FindFirst();
            SetSource(
              WarrantyLedgerEntry."Posting Date", '', WarrantyLedgerEntry."Document No.",
              2, WarrantyLedgerEntry."Service Order No.")
        end;
    end;

    local procedure SetSourceForServiceDoc()
    begin
        if NoOfRecords(Database::"Service Invoice Header") = 1 then begin
            ServInvHeader.FindFirst();
            SetSource(
              ServInvHeader."Posting Date", Format(Rec."Table Name"), ServInvHeader."No.",
              1, ServInvHeader."Bill-to Customer No.");
        end;
        if NoOfRecords(Database::"Service Cr.Memo Header") = 1 then begin
            ServCrMemoHeader.FindFirst();
            SetSource(
              ServCrMemoHeader."Posting Date", Format(Rec."Table Name"), ServCrMemoHeader."No.",
              1, ServCrMemoHeader."Bill-to Customer No.");
        end;
        if NoOfRecords(Database::"Service Shipment Header") = 1 then begin
            ServShptHeader.FindFirst();
            SetSource(
              ServShptHeader."Posting Date", Format(Rec."Table Name"), ServShptHeader."No.",
              1, ServShptHeader."Customer No.");
        end;
    end;

    procedure ShowRecords()
    begin
        case Rec."Table ID" of
            Database::"Incoming Document":
                PAGE.Run(PAGE::"Incoming Document", IncomingDocument);
            Database::"Sales Header":
                ShowSalesHeaderRecords();
            Database::"Purchase Header":
                ShowPurchaseHeaderRecords();
            Database::"Gen. Journal Line":
                Page.Run(PAGE::"General Journal", GenJnlLine);
            Database::"Sales Invoice Header":
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Posted Sales Invoice", SalesInvHeader)
                else
                    PAGE.Run(PAGE::"Posted Sales Invoices", SalesInvHeader);
            Database::"Sales Cr.Memo Header":
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Posted Sales Credit Memo", SalesCrMemoHeader)
                else
                    PAGE.Run(PAGE::"Posted Sales Credit Memos", SalesCrMemoHeader);
            Database::"Return Receipt Header":
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Posted Return Receipt", ReturnRcptHeader)
                else
                    PAGE.Run(0, ReturnRcptHeader);
            Database::"Sales Shipment Header":
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Posted Sales Shipment", SalesShptHeader)
                else
                    PAGE.Run(0, SalesShptHeader);
            Database::"Issued Reminder Header":
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Issued Reminder", IssuedReminderHeader)
                else
                    PAGE.Run(0, IssuedReminderHeader);
            Database::"Issued Fin. Charge Memo Header":
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Issued Finance Charge Memo", IssuedFinChrgMemoHeader)
                else
                    PAGE.Run(0, IssuedFinChrgMemoHeader);
            Database::"Purch. Inv. Header":
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Posted Purchase Invoice", PurchInvHeader)
                else
                    PAGE.Run(PAGE::"Posted Purchase Invoices", PurchInvHeader);
            Database::"Purch. Cr. Memo Hdr.":
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Posted Purchase Credit Memo", PurchCrMemoHeader)
                else
                    PAGE.Run(PAGE::"Posted Purchase Credit Memos", PurchCrMemoHeader);
            Database::"Return Shipment Header":
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Posted Return Shipment", ReturnShptHeader)
                else
                    PAGE.Run(0, ReturnShptHeader);
            Database::"Purch. Rcpt. Header":
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Posted Purchase Receipt", PurchRcptHeader)
                else
                    PAGE.Run(0, PurchRcptHeader);
            Database::"Production Order":
                PAGE.Run(0, ProductionOrderHeader);
            Database::"Posted Assembly Header":
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Posted Assembly Order", PostedAssemblyHeader)
                else
                    PAGE.Run(0, PostedAssemblyHeader);
            Database::"Transfer Shipment Header":
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Posted Transfer Shipment", TransShptHeader)
                else
                    PAGE.Run(0, TransShptHeader);
            Database::"Transfer Receipt Header":
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Posted Transfer Receipt", TransRcptHeader)
                else
                    PAGE.Run(0, TransRcptHeader);
            Database::"Posted Whse. Shipment Line":
                PAGE.Run(0, PostedWhseShptLine);
            Database::"Posted Whse. Receipt Line":
                PAGE.Run(0, PostedWhseRcptLine);
            Database::"G/L Entry":
                PAGE.Run(0, GLEntry);
            Database::"VAT Entry":
                PAGE.Run(0, VATEntry);
            Database::"Detailed Cust. Ledg. Entry":
                PAGE.Run(0, DtldCustLedgEntry);
            Database::"Cust. Ledger Entry":
                PAGE.Run(0, CustLedgEntry);
            Database::"Reminder/Fin. Charge Entry":
                PAGE.Run(0, ReminderEntry);
            Database::"Vendor Ledger Entry":
                PAGE.Run(0, VendLedgEntry);
            Database::"Detailed Vendor Ledg. Entry":
                PAGE.Run(0, DtldVendLedgEntry);
            Database::"Employee Ledger Entry":
                ShowEmployeeLedgerEntries();
            Database::"Detailed Employee Ledger Entry":
                ShowDetailedEmployeeLedgerEntries();
            Database::"Item Ledger Entry":
                PAGE.Run(0, ItemLedgEntry);
            Database::"Value Entry":
                PAGE.Run(0, ValueEntry);
            Database::"Phys. Inventory Ledger Entry":
                PAGE.Run(0, PhysInvtLedgEntry);
            Database::"Res. Ledger Entry":
                PAGE.Run(0, ResLedgEntry);
            Database::"Job Ledger Entry":
                PAGE.Run(0, JobLedgEntry);
            Database::"Job WIP Entry":
                PAGE.Run(0, JobWIPEntry);
            Database::"Job WIP G/L Entry":
                PAGE.Run(0, JobWIPGLEntry);
            Database::"Bank Account Ledger Entry":
                PAGE.Run(0, BankAccLedgEntry);
            Database::"Check Ledger Entry":
                PAGE.Run(0, CheckLedgEntry);
            Database::"FA Ledger Entry":
                PAGE.Run(0, FALedgEntry);
            Database::"Maintenance Ledger Entry":
                PAGE.Run(0, MaintenanceLedgEntry);
            Database::"Ins. Coverage Ledger Entry":
                PAGE.Run(0, InsuranceCovLedgEntry);
            Database::"Capacity Ledger Entry":
                PAGE.Run(0, CapacityLedgEntry);
            Database::"Warehouse Entry":
                PAGE.Run(0, WhseEntry);
            Database::"Service Header":
                ShowServiceHeaderRecords();
            Database::"Service Invoice Header":
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Posted Service Invoice", ServInvHeader)
                else
                    PAGE.Run(0, ServInvHeader);
            Database::"Service Cr.Memo Header":
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Posted Service Credit Memo", ServCrMemoHeader)
                else
                    PAGE.Run(0, ServCrMemoHeader);
            Database::"Service Shipment Header":
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Posted Service Shipment", ServShptHeader)
                else
                    PAGE.Run(0, ServShptHeader);
            Database::"Service Ledger Entry":
                PAGE.Run(0, ServLedgerEntry);
            Database::"Warranty Ledger Entry":
                PAGE.Run(0, WarrantyLedgerEntry);
            Database::"Cost Entry":
                PAGE.Run(0, CostEntry);
            Database::"Pstd. Phys. Invt. Order Hdr":
                PAGE.Run(0, PstdPhysInvtOrderHdr);
            Database::"Posted Gen. Journal Line":
                Page.Run(0, PostedGenJournalLine);
            Database::"Invt. Receipt Header":
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Posted Invt. Receipt", PostedInvtRcptHeader)
                else
                    PAGE.Run(0, PostedInvtRcptHeader);
            Database::"Invt. Shipment Header":
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Posted Invt. Shipment", PostedInvtShptHeader)
                else
                    PAGE.Run(0, PostedInvtShptHeader);
            DATABASE::"Issued Deliv. Reminder Header":
                PAGE.Run(0, IssuedDeliveryReminderHeader);
            DATABASE::"Delivery Reminder Ledger Entry":
                PAGE.Run(0, DelivReminLedgerEntries);
        end;
    end;

    local procedure ShowPurchaseHeaderRecords()
    begin
        Rec.TestField("Table ID", Database::"Purchase Header");

        case Rec."Document Type" of
            Rec."Document Type"::Quote:
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Purchase Quote", PQPurchaseHeader)
                else
                    PAGE.Run(0, PQPurchaseHeader);
            Rec."Document Type"::Order:
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Purchase Order", POPurchaseHeader)
                else
                    PAGE.Run(0, POPurchaseHeader);
            Rec."Document Type"::Invoice:
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Purchase Invoice", PIPurchaseHeader)
                else
                    PAGE.Run(0, PIPurchaseHeader);
        end;
    end;

    local procedure ShowSalesHeaderRecords()
    begin
        Rec.TestField("Table ID", Database::"Sales Header");

        case Rec."Document Type" of
            Rec."Document Type"::Quote:
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Sales Quote", SQSalesHeader)
                else
                    PAGE.Run(0, SQSalesHeader);
            Rec."Document Type"::Order:
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Sales Order", SOSalesHeader)
                else
                    PAGE.Run(0, SOSalesHeader);
            Rec."Document Type"::Invoice:
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Sales Invoice", SISalesHeader)
                else
                    PAGE.Run(0, SISalesHeader);
            Rec."Document Type"::"Return Order":
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Sales Return Order", SROSalesHeader)
                else
                    PAGE.Run(0, SROSalesHeader);
            Rec."Document Type"::"Credit Memo":
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Sales Credit Memo", SCMSalesHeader)
                else
                    PAGE.Run(0, SCMSalesHeader);
        end;
    end;

    local procedure ShowServiceHeaderRecords()
    begin
        Rec.TestField("Table ID", Database::"Service Header");

        case Rec."Document Type" of
            Rec."Document Type"::Order:
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Service Order", SOServHeader)
                else
                    PAGE.Run(0, SOServHeader);
            Rec."Document Type"::Invoice:
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Service Invoice", SIServHeader)
                else
                    PAGE.Run(0, SIServHeader);
            Rec."Document Type"::"Credit Memo":
                if Rec."No. of Records" = 1 then
                    PAGE.Run(PAGE::"Service Credit Memo", SCMServHeader)
                else
                    PAGE.Run(0, SCMServHeader);
        end;
    end;

    local procedure ShowEmployeeLedgerEntries()
    begin
        PAGE.Run(PAGE::"Employee Ledger Entries", EmplLedgEntry);
    end;

    local procedure ShowDetailedEmployeeLedgerEntries()
    begin
        PAGE.Run(PAGE::"Detailed Empl. Ledger Entries", DtldEmplLedgEntry);
    end;

    protected procedure ClearSourceInfo()
    begin
        if DocExists then begin
            DocExists := false;
            Rec.DeleteAll();
            PrintEnable := false;
            ShowEnable := false;
            SetSource(0D, '', '', 0, '');
            CurrPage.Update(false);
        end;
    end;

    procedure MakeExtFilter(var DateFilter: Text; AddDate: Date; var DocNoFilter: Text; AddDocNo: Code[20])
    begin
        if DateFilter = '' then
            DateFilter := Format(AddDate)
        else
            if StrPos(DateFilter, Format(AddDate)) = 0 then
                if MaxStrLen(DateFilter) >= StrLen(DateFilter + '|' + Format(AddDate)) then
                    DateFilter := DateFilter + '|' + Format(AddDate)
                else
                    TooLongFilter();

        if DocNoFilter = '' then
            DocNoFilter := AddDocNo
        else
            if StrPos(DocNoFilter, AddDocNo) = 0 then
                if MaxStrLen(DocNoFilter) >= StrLen(DocNoFilter + '|' + AddDocNo) then
                    DocNoFilter := DocNoFilter + '|' + AddDocNo
                else
                    TooLongFilter();
    end;

    local procedure TooLongFilter()
    begin
        if ObjectNo = '' then
            Error(ExtDocMsg);

        Error(ExtDocGlMsg);
    end;

    local procedure FindUnpostedSalesDocs(DocType: Enum "Sales Document Type"; DocTableName: Text[100]; var SalesHeader: Record "Sales Header")
    begin
        SalesHeader."SecurityFiltering"(SECURITYFILTER::Filtered);
        if SalesHeader.ReadPermission() then begin
            SalesHeader.Reset();
            SalesHeader.SetCurrentKey("BSD Object No.", "External Document No.");
            if ObjectNo <> '' then
                SalesHeader.SetFilter("BSD Object No.", ObjectNo);
            if ExtDocNo <> '' then
                SalesHeader.SetFilter("External Document No.", ExtDocNo);
            SalesHeader.SetRange("Document Type", DocType);
            Rec.InsertIntoDocEntry(Database::"Sales Header", DocType, DocTableName, SalesHeader.Count);
        end;
    end;

    local procedure FindUnpostedPurchaseDocs(DocType: Enum "Purchase Document Type"; DocTableName: Text[100]; var PurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeader."SecurityFiltering"(SECURITYFILTER::Filtered);
        if PurchaseHeader.ReadPermission() then begin
            PurchaseHeader.Reset();
            PurchaseHeader.SetCurrentKey("Buy-from Vendor No.", "Vendor Invoice No.");
            if ObjectNo <> '' then
                PurchaseHeader.SetFilter("BSD Object No.", ObjectNo);
            if ExtDocNo <> '' then
                if DocType = DocType::Order then
                    PurchaseHeader.SetFilter("Vendor Order No.", ExtDocNo)
                else
                    PurchaseHeader.SetFilter("Vendor Invoice No.", ExtDocNo);
            PurchaseHeader.SetRange("Document Type", DocType);
            Rec.InsertIntoDocEntry(Database::"Purchase Header", DocType, DocTableName, PurchaseHeader.Count);
        end;
    end;


    procedure ClearInfo()
    begin
        ExtDocNo := '';
    end;

    procedure ClearContactInfo()
    begin
        ObjectNo := '';
    end;

    local procedure ContactNoOnAfterValidate()
    begin
        ClearSourceInfo();
    end;

    procedure UpdateNavigateForm(UpdateFormFrom: Boolean)
    begin
        UpdateForm := UpdateFormFrom;
    end;

    procedure ReturnDocumentEntry(var TempDocumentEntry: Record "Document Entry" temporary)
    begin
        Rec.SetRange("Table ID");  // Clear filter.
        Rec.FindSet();
        repeat
            TempDocumentEntry.Init();
            TempDocumentEntry := Rec;
            TempDocumentEntry.Insert();
        until Rec.Next() = 0;
    end;

    protected procedure UpdateFindByGroupsVisibility()
    begin
        ClearInfo();
    end;

    procedure FilterSelectionChanged()
    begin
        FilterSelectionChangedTxtVisible := not Rec.IsEmpty();
    end;

    local procedure GetCaptionText(): Text
    begin
        if Rec."Table Name" <> '' then
            exit(StrSubstNo(PageCaptionTxt, Rec."Table Name"));

        exit('');
    end;
}
