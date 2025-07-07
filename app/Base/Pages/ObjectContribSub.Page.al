namespace BoSchData.sisMAN.Base;
using Microsoft.CRM.Interaction;
using Microsoft.Sales.Document;
using Microsoft.CRM.Contact;
using System.EMail;
using Microsoft.Purchases.Vendor;
using Microsoft.Sales.Customer;
using Microsoft.CRM.Opportunity;
using Microsoft.Purchases.Document;
using Microsoft.Sales.Reminder;

page 71458582 "BSD Object Contrib. Sub."
{
    ApplicationArea = All;
    Caption = 'Contributors';
    PageType = ListPart;
    SourceTable = "BSD Object Contributor";
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Contributor Type"; Rec."Contributor Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contributor Type field.';
                }
                field("Contact Type"; Rec."Contact Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact Type field.';
                    Editable = Rec."Contributor Type" = Rec."Contributor Type"::Contact;
                }
                field("Business Relation"; Rec."Business Relation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Business Relation field.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name 2 field.';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address 2 field.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post Code field.';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the City field.';
                }
                field("Customer Template"; Rec."Customer Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Template field.';
                    Editable = Rec."Contributor Type" = Rec."Contributor Type"::Contact;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(NewDocument)
            {
                Caption = 'New Document';
                action(NewSalesBlanketOrder)
                {
                    ApplicationArea = All;
                    Caption = 'Blanket Sales Order';
                    Image = BlanketOrder;
                    ToolTip = 'Create a blanket sales order for the customer.';
                    Visible = Rec."Contributor Type" = Rec."Contributor Type"::Customer;

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader.Init();
                        SalesHeader."No." := '';
                        SalesHeader."Document Type" := SalesHeader."Document Type"::"Blanket Order";
                        SalesHeader.Validate("Sell-to Customer No.", Rec."No.");
                        SalesHeader.Validate("BSD Object No.", Rec."Object No.");
                        SalesHeader.Insert(true);
                        Page.Run(Page::"Blanket Sales Order", SalesHeader);
                    end;
                }
                action(NewSalesQuote)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Quote';
                    Image = NewSalesQuote;
                    ToolTip = 'Offer items or services to a customer.';
                    Visible = Rec."Contributor Type" = Rec."Contributor Type"::Customer;

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader.Init();
                        SalesHeader."No." := '';
                        SalesHeader."Document Type" := SalesHeader."Document Type"::Quote;
                        SalesHeader.Validate("Sell-to Customer No.", Rec."No.");
                        SalesHeader.Validate("BSD Object No.", Rec."Object No.");
                        SalesHeader.Insert(true);
                        Page.Run(Page::"Sales Quote", SalesHeader);
                    end;
                }
                action(NewSalesOrder)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Order';
                    Image = Document;
                    ToolTip = 'Create a sales order for the customer.';
                    Visible = Rec."Contributor Type" = Rec."Contributor Type"::Customer;

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader.Init();
                        SalesHeader."No." := '';
                        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
                        SalesHeader.Validate("Sell-to Customer No.", Rec."No.");
                        SalesHeader.Validate("BSD Object No.", Rec."Object No.");
                        SalesHeader.Insert(true);
                        Page.Run(Page::"Sales Order", SalesHeader);
                    end;
                }
                action(NewSalesInvoice)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Invoice';
                    Image = NewSalesInvoice;
                    ToolTip = 'Create a sales invoice for the customer.';
                    Visible = Rec."Contributor Type" = Rec."Contributor Type"::Customer;

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader.Init();
                        SalesHeader."No." := '';
                        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
                        SalesHeader.Validate("Sell-to Customer No.", Rec."No.");
                        SalesHeader.Validate("BSD Object No.", Rec."Object No.");
                        SalesHeader.Insert(true);
                        Page.Run(Page::"Sales Invoice", SalesHeader);
                    end;
                }
                action(NewSalesCrMemo)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Credit Memo';
                    Image = CreditMemo;
                    ToolTip = 'Create a new sales credit memo to revert a posted sales invoice.';
                    Visible = Rec."Contributor Type" = Rec."Contributor Type"::Customer;

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader.Init();
                        SalesHeader."No." := '';
                        SalesHeader."Document Type" := SalesHeader."Document Type"::"Credit Memo";
                        SalesHeader.Validate("Sell-to Customer No.", Rec."No.");
                        SalesHeader.Validate("BSD Object No.", Rec."Object No.");
                        SalesHeader.Insert(true);
                        Page.Run(Page::"Sales Credit Memo", SalesHeader);
                    end;
                }
                action(NewReminder)
                {
                    ApplicationArea = All;
                    Caption = 'Reminder';
                    Image = Reminder;
                    RunObject = Page Reminder;
                    RunPageLink = "Customer No." = field("No.");
                    RunPageMode = Create;
                    ToolTip = 'Create a new reminder for the customer.';
                    AboutTitle = 'Create a new document';
                    AboutText = 'Get started on a new reminder, order, or other document for the customer selected in the list.';
                    Visible = Rec."Contributor Type" = Rec."Contributor Type"::Customer;
                }
                action(NewSalesReturnOrder)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Return Order';
                    Image = ReturnOrder;
                    ToolTip = 'Create a new sales return order for items or services.';
                    Visible = Rec."Contributor Type" = Rec."Contributor Type"::Customer;

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader.Init();
                        SalesHeader."No." := '';
                        SalesHeader."Document Type" := SalesHeader."Document Type"::"Return Order";
                        SalesHeader.Validate("Sell-to Customer No.", Rec."No.");
                        SalesHeader.Validate("BSD Object No.", Rec."Object No.");
                        SalesHeader.Insert(true);
                        Page.Run(Page::"Sales Return Order", SalesHeader);
                    end;
                }
                action(NewBlanketPurchaseOrder)
                {
                    ApplicationArea = All;
                    Caption = 'Blanket Purchase Order';
                    Image = BlanketOrder;
                    ToolTip = 'Create a new blanket purchase order for the vendor.';
                    Visible = Rec."Contributor Type" = Rec."Contributor Type"::Vendor;

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        PurchaseHeader.Init();
                        PurchaseHeader."No." := '';
                        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::"Blanket Order";
                        PurchaseHeader.Validate("Buy-from Vendor No.", Rec."No.");
                        PurchaseHeader.Validate("BSD Object No.", Rec."Object No.");
                        PurchaseHeader.Insert(true);
                        Page.Run(Page::"Blanket Purchase Order", PurchaseHeader);
                    end;
                }
                action(NewPurchaseInvoice)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Invoice';
                    Image = NewPurchaseInvoice;
                    ToolTip = 'Create a new purchase invoice for items or services.';
                    Visible = Rec."Contributor Type" = Rec."Contributor Type"::Vendor;

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        PurchaseHeader.Init();
                        PurchaseHeader."No." := '';
                        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Invoice;
                        PurchaseHeader.Validate("Buy-from Vendor No.", Rec."No.");
                        PurchaseHeader.Validate("BSD Object No.", Rec."Object No.");
                        PurchaseHeader.Insert(true);
                        Page.Run(Page::"Purchase Invoice", PurchaseHeader);
                    end;
                }
                action(NewPurchaseOrder)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Order';
                    Image = Document;
                    ToolTip = 'Create a new purchase order.';
                    Visible = Rec."Contributor Type" = Rec."Contributor Type"::Vendor;

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        PurchaseHeader.Init();
                        PurchaseHeader."No." := '';
                        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Order;
                        PurchaseHeader.Validate("Buy-from Vendor No.", Rec."No.");
                        PurchaseHeader.Validate("BSD Object No.", Rec."Object No.");
                        PurchaseHeader.Insert(true);
                        Page.Run(Page::"Purchase Order", PurchaseHeader);
                    end;
                }
                action(NewPurchaseCrMemo)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Credit Memo';
                    Image = CreditMemo;
                    ToolTip = 'Create a new purchase credit memo to revert a posted purchase invoice.';
                    AboutTitle = 'Create a new document';
                    AboutText = 'Get started on a new credit memo, order, or other document for the vendor selected in the list';
                    Visible = Rec."Contributor Type" = Rec."Contributor Type"::Vendor;

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        PurchaseHeader.Init();
                        PurchaseHeader."No." := '';
                        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::"Credit Memo";
                        PurchaseHeader.Validate("Buy-from Vendor No.", Rec."No.");
                        PurchaseHeader.Validate("BSD Object No.", Rec."Object No.");
                        PurchaseHeader.Insert(true);
                        Page.Run(Page::"Purchase Credit Memo", PurchaseHeader);
                    end;
                }
                action(NewPurchaseReturnOrder)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Return Order';
                    Image = ReturnOrder;
                    ToolTip = 'Create a new purchase return order for the vendor.';
                    Visible = Rec."Contributor Type" = Rec."Contributor Type"::Vendor;

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        PurchaseHeader.Init();
                        PurchaseHeader."No." := '';
                        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::"Return Order";
                        PurchaseHeader.Validate("Buy-from Vendor No.", Rec."No.");
                        PurchaseHeader.Validate("BSD Object No.", Rec."Object No.");
                        PurchaseHeader.Insert(true);
                        Page.Run(Page::"Purchase Return Order", PurchaseHeader);
                    end;
                }
            }
            action("Create Opportunity")
            {
                ApplicationArea = All;
                Caption = 'Create Opportunity';
                Image = NewOpportunity;
                RunObject = Page "Opportunity Card";
                RunPageLink = "Contact No." = field("No."),
                            "Contact Company No." = field("Contact Company");
                RunPageMode = Create;
                ToolTip = 'Register a sales opportunity for the contact.';
                Visible = Rec."Contributor Type" = Rec."Contributor Type"::Contact;
            }
            action("Create Opportunity Customer")
            {
                ApplicationArea = All;
                Caption = 'Create Opportunity';
                Image = NewOpportunity;
                RunObject = Page "Opportunity Card";
                RunPageLink = "Contact No." = field("Primary Contact No."),
                            "Contact Company No." = field("Contact Company");
                RunPageMode = Create;
                ToolTip = 'Register a sales opportunity for the customer.';
                Visible = Rec."Contributor Type" = Rec."Contributor Type"::Customer;
            }
            action("Create Interaction")
            {
                AccessByPermission = TableData Attachment = R;
                ApplicationArea = All;
                Caption = 'Create Interaction';
                Image = CreateInteraction;
                ToolTip = 'Create an interaction with a specified contact.';
                Visible = Rec."Contributor Type" = Rec."Contributor Type"::Contact;

                trigger OnAction()
                var
                    Contact: Record Contact;
                begin
                    if Contact.Get(Rec."No.") then
                        Contact.CreateInteraction();
                end;
            }
            action(NewSalesQuoteContact)
            {
                ApplicationArea = All;
                Caption = 'Create Sales Quote';
                Image = NewSalesQuote;
                ToolTip = 'Offer items or services to a customer.';
                Visible = Rec."Contributor Type" = Rec."Contributor Type"::Contact;

                trigger OnAction()
                var
                    Contact: Record Contact;
                begin
                    if Contact.Get(Rec."No.") then
                        Contact.CreateSalesQuoteFromContact();
                end;
            }
            action(MakePhoneCallContact)
            {
                ApplicationArea = All;
                Caption = 'Make &Phone Call';
                Image = Calls;
                Scope = Repeater;
                ToolTip = 'Call the selected contact.';
                Visible = Rec."Contributor Type" = Rec."Contributor Type"::Contact;

                trigger OnAction()
                var
                    Contact: Record Contact;
                    TAPIManagement: Codeunit TAPIManagement;
                begin
                    if Contact.Get(Rec."No.") then
                        TAPIManagement.DialContCustVendBank(DATABASE::Contact, Contact."No.", Contact.GetDefaultPhoneNo(), '');
                end;
            }
            action(MakePhoneCallCustomer)
            {
                ApplicationArea = All;
                Caption = 'Make &Phone Call';
                Image = Calls;
                Scope = Repeater;
                ToolTip = 'Call the selected contact.';
                Visible = Rec."Contributor Type" = Rec."Contributor Type"::Customer;

                trigger OnAction()
                var
                    Customer: Record Customer;
                    TAPIManagement: Codeunit TAPIManagement;
                begin
                    if Customer.Get(Rec."No.") then
                        TAPIManagement.DialContCustVendBank(DATABASE::Customer, Customer."No.", Customer."BSD GetPhoneNo"(), '');
                end;
            }
            action(MakePhoneCallVendor)
            {
                ApplicationArea = All;
                Caption = 'Make &Phone Call';
                Image = Calls;
                Scope = Repeater;
                ToolTip = 'Call the selected contact.';
                Visible = Rec."Contributor Type" = Rec."Contributor Type"::Vendor;

                trigger OnAction()
                var
                    Vendor: Record Vendor;
                    TAPIManagement: Codeunit TAPIManagement;
                begin
                    if Vendor.Get(Rec."No.") then
                        TAPIManagement.DialContCustVendBank(DATABASE::Vendor, Vendor."No.", Vendor."BSD GetPhoneNo"(), '');
                end;
            }
            action(EmailContact)
            {
                ApplicationArea = All;
                Caption = 'Send Email';
                Image = Email;
                ToolTip = 'Send an email to this contact.';
                Visible = Rec."Contributor Type" = Rec."Contributor Type"::Contact;

                trigger OnAction()
                var
                    Contact: Record Contact;
                    TempEmailItem: Record "Email Item" temporary;
                    EmailScenario: Enum "Email Scenario";
                begin
                    if Contact.Get(Rec."No.") then begin
                        TempEmailItem.AddSourceDocument(Database::Contact, Contact.SystemId);
                        TempEmailitem."Send to" := Contact."E-Mail";
                        TempEmailItem.Send(false, EmailScenario::Default);
                    end;
                end;
            }
            action(EmailCustomer)
            {
                ApplicationArea = All;
                Caption = 'Send Email';
                Image = Email;
                ToolTip = 'Send an email to this customer.';
                Visible = Rec."Contributor Type" = Rec."Contributor Type"::Customer;

                trigger OnAction()
                var
                    Customer: Record Customer;
                    TempEmailItem: Record "Email Item" temporary;
                    EmailScenario: Enum "Email Scenario";
                begin
                    if Customer.Get(Rec."No.") then begin
                        TempEmailItem.AddSourceDocument(Database::Customer, Customer.SystemId);
                        TempEmailitem."Send to" := Customer."E-Mail";
                        TempEmailItem.Send(false, EmailScenario::Default);
                    end;
                end;
            }
            action(EmailVendor)
            {
                ApplicationArea = All;
                Caption = 'Send Email';
                Image = Email;
                ToolTip = 'Send an email to this vendor.';
                Visible = Rec."Contributor Type" = Rec."Contributor Type"::Vendor;

                trigger OnAction()
                var
                    Vendor: Record Vendor;
                    TempEmailItem: Record "Email Item" temporary;
                    EmailScenario: Enum "Email Scenario";
                begin
                    if Vendor.Get(Rec."No.") then begin
                        TempEmailItem.AddSourceDocument(Database::Vendor, Vendor.SystemId);
                        TempEmailitem."Send to" := Vendor."E-Mail";
                        TempEmailItem.Send(false, EmailScenario::Default);
                    end;
                end;
            }
            action("Export Contact")
            {
                ApplicationArea = All;
                Caption = 'Export Contact';
                Image = Export;
                ToolTip = 'Export Contact';
                Visible = Rec."Contributor Type" = Rec."Contributor Type"::Contact;

                trigger OnAction()
                var
                    Contact: Record Contact;
                    ExportContact: XMLport "Export Contact";
                    ContactList: Page "Contact List";
                begin
                    if Contact.Get(Rec."No.") then begin
                        ContactList.SetSelectionFilter(Contact);
                        ExportContact.SetTableView(Contact);
                        ExportContact.Run();
                    end;
                end;
            }
            action("Set as Shipment Adress")
            {
                ApplicationArea = All;
                Caption = 'Set as Shipment Adress';
                Image = ShipAddress;
                ToolTip = 'Sets the information of this object as ship-to adress on the customer.';
                Visible = Rec."Contributor Type" = Rec."Contributor Type"::Customer;

                trigger OnAction()
                begin
                    Rec.SetAsShipToAddress(Rec."No.", Rec."Object No.");
                end;
            }
        }
    }
}
