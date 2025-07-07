namespace BoSchData.sisMAN.Base;
using Microsoft.Purchases.Document;
using Microsoft.Purchases.Archive;

page 71458591 "BSD Obj. Purch. History FB"
{
    Caption = 'Purchase History';
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
                field("No. of Quotes"; Rec."No. of Purchase Quotes")
                {
                    ApplicationArea = Suite;
                    Caption = 'Quotes';
                    DrillDownPageID = "Purchase Quotes";
                    ToolTip = 'Specifies the number of purchase quotes that exist for the object.';
                }
                field("No. of Blanket Orders"; Rec."No. of Purch. Blanket Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Blanket Orders';
                    DrillDownPageID = "Blanket Purchase Orders";
                    ToolTip = 'Specifies the number of purchase blanket orders that exist for the object.';
                }
                field("No. of Orders"; Rec."No. of Purchase Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Orders';
                    DrillDownPageID = "Purchase Order List";
                    ToolTip = 'Specifies the number of purchase orders that exist for the object.';
                }
                field("No. of Invoices"; Rec."No. of Purchase Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoices';
                    DrillDownPageID = "Purchase Invoices";
                    ToolTip = 'Specifies the number of unposted purchase invoices that exist for the object.';
                }
                field("No. of Return Orders"; Rec."No. of Purchase Return Orders")
                {
                    ApplicationArea = PurchReturnOrder;
                    Caption = 'Return Orders';
                    DrillDownPageID = "Purchase Return Order List";
                    ToolTip = 'Specifies the number of purchase return orders that exist for the object.';
                }
                field("No. of Credit Memos"; Rec."No. of Purchase Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Credit Memos';
                    DrillDownPageID = "Purchase Credit Memos";
                    ToolTip = 'Specifies the number of unposted purchase credit memos that exist for the object.';
                }
                field("No. of Pstd. Return Shipments"; Rec."No. of Pstd. Purch. Ret. Ship.")
                {
                    ApplicationArea = PurchReturnOrder;
                    Caption = 'Pstd. Return Shipments';
                    ToolTip = 'Specifies the number of posted return shipments that exist for the object.';
                }
                field("No. of Pstd. Receipts"; Rec."No. of Pstd. Purchase Receipts")
                {
                    ApplicationArea = Suite;
                    Caption = 'Pstd. Receipts';
                    ToolTip = 'Specifies the number of posted purchase receipts that exist for the object.';
                }
                field("No. of Pstd. Invoices"; Rec."No. of Pstd. Purchase Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pstd. Invoices';
                    ToolTip = 'Specifies the number of posted purchase invoices that exist for the object.';
                }
                field("No. of Pstd. Credit Memos"; Rec."No. of Pstd. Purch. Cr. Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pstd. Credit Memos';
                    ToolTip = 'Specifies the number of posted purchase credit memos that exist for the object.';
                }
                field("No. of Archived Quotes"; Rec."No. of Archived Purch. Quotes")
                {
                    ApplicationArea = Suite;
                    Caption = 'Archived Quotes';
                    DrillDownPageID = "Purchase Quote Archive";
                    ToolTip = 'Specifies the number of archived purchase quotes that exist for the object.';
                }
                field("No. of Archived Orders"; Rec."No. of Archived Purch. Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Archived Orders';
                    DrillDownPageID = "Purchase Order Archives";
                    ToolTip = 'Specifies the number of archived purchase orders that exist for the object.';
                }
            }
            cuegroup(Control1)
            {
                ShowCaption = false;
                field(CueQuotes; Rec."No. of Purchase Quotes")
                {
                    ApplicationArea = Suite;
                    Caption = 'Quotes';
                    DrillDownPageID = "Purchase Quotes";
                    ToolTip = 'Specifies the number of purchase quotes that exist for the object.';
                }
                field(CueBlanketOrders; Rec."No. of Purch. Blanket Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Blanket Orders';
                    DrillDownPageID = "Blanket Purchase Orders";
                    ToolTip = 'Specifies the number of purchase blanket orders that exist for the object.';
                }
                field(CueOrders; Rec."No. of Purchase Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Orders';
                    DrillDownPageID = "Purchase Order List";
                    ToolTip = 'Specifies the number of purchase orders that exist for the object.';
                }
                field(CueInvoices; Rec."No. of Purchase Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoices';
                    DrillDownPageID = "Purchase Invoices";
                    ToolTip = 'Specifies the number of unposted purchase invoices that exist for the object.';
                }
                field(CueReturnOrders; Rec."No. of Purchase Return Orders")
                {
                    ApplicationArea = PurchReturnOrder;
                    Caption = 'Return Orders';
                    DrillDownPageID = "Purchase Return Order List";
                    ToolTip = 'Specifies the number of purchase return orders that exist for the object.';
                }
                field(CueCreditMemos; Rec."No. of Purchase Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Credit Memos';
                    DrillDownPageID = "Purchase Credit Memos";
                    ToolTip = 'Specifies the number of unposted purchase credit memos that exist for the object.';
                }
                field(CuePostedRetShip; Rec."No. of Pstd. Purch. Ret. Ship.")
                {
                    ApplicationArea = PurchReturnOrder;
                    Caption = 'Pstd. Return Shipments';
                    ToolTip = 'Specifies the number of posted return shipments that exist for the object.';
                }
                field(CuePostedReceipts; Rec."No. of Pstd. Purchase Receipts")
                {
                    ApplicationArea = Suite;
                    Caption = 'Pstd. Receipts';
                    ToolTip = 'Specifies the number of posted purchase receipts that exist for the object.';
                }
                field(CuePostedInvoices; Rec."No. of Pstd. Purchase Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pstd. Invoices';
                    ToolTip = 'Specifies the number of posted purchase invoices that exist for the object.';
                }
                field(CuePostedCreditMemos; Rec."No. of Pstd. Purch. Cr. Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pstd. Credit Memos';
                    ToolTip = 'Specifies the number of posted purchase credit memos that exist for the object.';
                }
                field("Cue No. of Archived Quotes"; Rec."No. of Archived Purch. Quotes")
                {
                    ApplicationArea = Suite;
                    Caption = 'Archived Quotes';
                    DrillDownPageID = "Purchase Quote Archive";
                    ToolTip = 'Specifies the number of archived purchase quotes that exist for the object.';
                }
                field("Cue No. of Archived Orders"; Rec."No. of Archived Purch. Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Archived Orders';
                    DrillDownPageID = "Purchase Order Archives";
                    ToolTip = 'Specifies the number of archived purchase orders that exist for the object.';
                }
            }
        }
    }
}

