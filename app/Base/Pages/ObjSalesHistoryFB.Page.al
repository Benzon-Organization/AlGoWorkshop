namespace BoSchData.sisMAN.Base;
using Microsoft.Sales.Document;
using Microsoft.Sales.Archive;
using Microsoft.Sales.History;

page 71458590 "BSD Obj. Sales History FB"
{
    Caption = 'Sales History';
    PageType = CardPart;
    SourceTable = "BSD Object";

    layout
    {
        area(content)
        {
            group(Control23)
            {
                ShowCaption = false;
                Visible = false;
                field("No. of Quotes"; Rec."No. of Sales Quotes")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ongoing Sales Quotes';
                    DrillDownPageID = "Sales Quote";
                    ToolTip = 'Specifies the number of sales quotes that have been registered for the object.';
                }
                field("No. of Blanket Orders"; Rec."No. of Sales Blanket Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Ongoing Sales Blanket Orders';
                    DrillDownPageID = "Blanket Sales Orders";
                    ToolTip = 'Specifies the number of sales blanket orders that have been registered for the object.';
                }
                field("No. of Orders"; Rec."No. of Sales Orders")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ongoing Sales Orders';
                    DrillDownPageID = "Sales Order List";
                    ToolTip = 'Specifies the number of sales orders that have been registered for the object.';
                }
                field("No. of Invoices"; Rec."No. of Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ongoing Sales Invoices';
                    DrillDownPageID = "Sales Invoice List";
                    ToolTip = 'Specifies the number of unposted sales invoices that have been registered for the object.';
                }
                field("No. of Return Orders"; Rec."No. of Sales Return Orders")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Ongoing Sales Return Orders';
                    DrillDownPageID = "Sales Return Order List";
                    ToolTip = 'Specifies the number of sales return orders that have been registered for the object.';
                }
                field("No. of Credit Memos"; Rec."No. of Sales Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ongoing Sales Credit Memos';
                    DrillDownPageID = "Sales Credit Memos";
                    ToolTip = 'Specifies the number of unposted sales credit memos that have been registered for the object.';
                }
                field("No. of Pstd. Shipments"; Rec."No. of Pstd. Sales Shipments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Shipments';
                    DrillDownPageID = "Posted Sales Shipment";
                    ToolTip = 'Specifies the number of posted sales shipments that have been registered for the object.';
                }
                field("No. of Pstd. Invoices"; Rec."No. of Pstd. Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    DrillDownPageID = "Posted Sales Invoices";
                    ToolTip = 'Specifies the number of posted sales invoices that have been registered for the object.';
                }
                field("No. of Pstd. Return Receipts"; Rec."No. of Pstd. Sales Ret. Rcpts.")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Posted Sales Return Receipts';
                    DrillDownPageID = "Posted Return Receipts";
                    ToolTip = 'Specifies the number of posted sales return receipts that have been registered for the object.';
                }
                field("No. of Pstd. Credit Memos"; Rec."No. of Pstd. Sales Cr. Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    DrillDownPageID = "Posted Sales Credit Memos";
                    ToolTip = 'Specifies the number of posted sales credit memos that have been registered for the object.';
                }
                field("No. of Archived Quotes"; Rec."No. of Archived Sales Quotes")
                {
                    ApplicationArea = Suite;
                    Caption = 'Archived Sales Quotes';
                    DrillDownPageID = "Sales Quote Archive";
                    ToolTip = 'Specifies the number of archived sales quotes that exist for the object.';
                }
                field("No. of Archived Orders"; Rec."No. of Archived Sales Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Archived Sales Orders';
                    DrillDownPageID = "Sales Order Archives";
                    ToolTip = 'Specifies the number of archived sales orders that exist for the object.';
                }
            }
            cuegroup(Control2)
            {
                ShowCaption = false;
                field(NoofQuotesTile; Rec."No. of Sales Quotes")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ongoing Sales Quotes';
                    DrillDownPageID = "Sales Quotes";
                    ToolTip = 'Specifies the number of sales quotes that have been registered for the object.';
                }
                field(NoofBlanketOrdersTile; Rec."No. of Sales Blanket Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Ongoing Sales Blanket Orders';
                    DrillDownPageID = "Blanket Sales Orders";
                    ToolTip = 'Specifies the number of sales blanket orders that have been registered for the object.';
                }
                field(NoofOrdersTile; Rec."No. of Sales Orders")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ongoing Sales Orders';
                    DrillDownPageID = "Sales Order List";
                    ToolTip = 'Specifies the number of sales orders that have been registered for the object.';
                }
                field(NoofInvoicesTile; Rec."No. of Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ongoing Sales Invoices';
                    DrillDownPageID = "Sales Invoice List";
                    ToolTip = 'Specifies the number of unposted sales invoices that have been registered for the object.';
                }
                field(NoofReturnOrdersTile; Rec."No. of Sales Return Orders")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Ongoing Sales Return Orders';
                    DrillDownPageID = "Sales Return Order List";
                    ToolTip = 'Specifies the number of sales return orders that have been registered for the object.';
                }
                field(NoofCreditMemosTile; Rec."No. of Sales Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ongoing Sales Credit Memos';
                    DrillDownPageID = "Sales Credit Memos";
                    ToolTip = 'Specifies the number of unposted sales credit memos that have been registered for the object.';
                }
                field(NoofPstdShipmentsTile; Rec."No. of Pstd. Sales Shipments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Shipments';
                    DrillDownPageID = "Posted Sales Shipments";
                    ToolTip = 'Specifies the number of posted sales shipments that have been registered for the object.';
                }
                field(NoofPstdInvoicesTile; Rec."No. of Pstd. Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    DrillDownPageID = "Posted Sales Invoices";
                    ToolTip = 'Specifies the number of posted sales invoices that have been registered for the object.';
                }
                field(NoofPstdReturnReceiptsTile; Rec."No. of Pstd. Sales Ret. Rcpts.")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Posted Sales Return Receipts';
                    DrillDownPageID = "Posted Return Receipts";
                    ToolTip = 'Specifies the number of posted sales return receipts that have been registered for the object.';
                }
                field(NoofPstdCreditMemosTile; Rec."No. of Pstd. Sales Cr. Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    DrillDownPageID = "Posted Sales Credit Memos";
                    ToolTip = 'Specifies the number of posted sales credit memos that have been registered for the object.';
                }
                field("Cue No. of Archived Quotes"; Rec."No. of Archived Sales Quotes")
                {
                    ApplicationArea = Suite;
                    Caption = 'Archived Sales Quotes';
                    DrillDownPageID = "Sales Quote Archive";
                    ToolTip = 'Specifies the number of archived sales quotes that exist for the object.';
                }
                field("Cue No. of Archived Orders"; Rec."No. of Archived Sales Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Archived Sales Orders';
                    DrillDownPageID = "Sales Order Archives";
                    ToolTip = 'Specifies the number of archived sales orders that exist for the object.';
                }
            }
        }
    }
}

