namespace BoSchData.sisMAN.Base;
using Microsoft.Finance.Dimension;
using Microsoft.Foundation.Attachment;
using Microsoft.CRM.Task;
using Microsoft.CRM.Interaction;
using Microsoft.Foundation.Comment;

page 71458580 "BSD Object List"
{
    ApplicationArea = All;
    Caption = 'Objects';
    PageType = List;
    SourceTable = "BSD Object";
    UsageCategory = Lists;
    CardPageId = "BSD Object Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                    Style = Attention;
                    StyleExpr = ResubmissionDateExpired;
                }
                field("No. 2"; Rec."No. 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. 2 field.';
                    Visible = false;
                    Style = Attention;
                    StyleExpr = ResubmissionDateExpired;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                    Style = Attention;
                    StyleExpr = ResubmissionDateExpired;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description 2 field.';
                    Visible = false;
                    Style = Attention;
                    StyleExpr = ResubmissionDateExpired;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
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
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the County field.';
                }
                field(District; Rec.District)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the District field.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipment Method Code field.';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipping Agent Code field.';
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipping Agent Service Code field.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Salesperson Code field.';
                }
                field("Salesperson Code 2"; Rec."Salesperson Code 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Salesperson Code 2 field.';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Assigned User ID field.';
                }
                field("Service Zone Code"; Rec."Service Zone Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service Zone Code field.';
                }
                field("Submission Date"; Rec."Submission Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Submission Date field.';
                }
                field("Planned Duration from"; Rec."Planned Duration from")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Planned Duration from field.';
                }
                field("Planned Duration to"; Rec."Planned Duration to")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Planned Duration to field.';
                }
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents List"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Documents';
                UpdatePropagation = Both;
                SubPageLink = "Table ID" = const(Database::"BSD Object"),
                              "No." = field("No.");
            }
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
            part("BSD Comment FactBox"; "BSD Comment FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Table Name" = const("BSD Object"), "No." = field("No.");
            }
            part(ObjectPicture; "BSD Object Picture")
            {
                ApplicationArea = All;
                Provider = ObjectPictureLines;
                SubPageLink = "Object No." = field("Object No."), "Entry No." = field("Entry No.");
            }
            part(ObjectPictureLines; "BSD Object Picture Lines Fb")
            {
                ApplicationArea = All;
                SubPageLink = "Object No." = field("No.");
            }
            part("BSD Opp. Resp. Cent. Rel. FB"; "BSD Opp. Resp. Cent. Rel. FB")
            {
                ApplicationArea = All;
                SubPageLink = "Object No." = field("No.");
                Visible = UseSalesOpportunity;
            }
            part("BSD Obj. Sales History FB"; "BSD Obj. Sales History FB")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
            part("BSD Obj. Purch. History FB"; "BSD Obj. Purch. History FB")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group(Start)
            {
                group(ReleaseGroup_Promoted)
                {
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    actionref(Release_Promoted; Release)
                    {

                    }
                    actionref(Reopen_Promoted; Reopen)
                    {

                    }
                }
                actionref(ShowContact_Promoted; ShowContact)
                {

                }
                actionref(CopyObject_Promoted; CopyObject)
                {

                }
                actionref(ArchiveObject_Promoted; "Archive Object")
                {

                }
            }
            group(Object)
            {
                Caption = 'Object';
                actionref(Dimensions_Promoted; Dimensions)
                {

                }
                actionref(Comments_Promoted; Comments)
                {

                }
                actionref(DocAttach_Promoted; DocAttach)
                {

                }
                actionref("Interaction Log Entries_Promoted"; "Interaction Log Entries")
                {

                }
                actionref(CreateInteraction_Promoted; "Create Interaction")
                {

                }
                actionref(Tasks_Promoted; Tasks)
                {

                }
                actionref(ObjectPictures_Promoted; ObjectPictures)
                {

                }
                actionref(Navigate_Promoted; Navigate)
                {

                }
            }
        }
        area(Processing)
        {
            group(ReleaseGroup)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    ApplicationArea = Suite;
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Release the document to the next stage of processing. You must reopen the document before you can make changes to it.';

                    trigger OnAction()
                    var
                        ReleaseQst: Label 'Do you want to release this object?';
                    begin
                        if Confirm(ReleaseQst) then
                            Rec.Status := Rec.Status::Released;
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reopen';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    var
                        ReopenQst: Label 'Do you want to reopen this object?';
                    begin
                        if Confirm(ReopenQst) then
                            Rec.Status := Rec.Status::Open;
                    end;
                }
            }
            action(ShowContact)
            {
                ApplicationArea = All;
                Caption = 'Contact';
                Image = ContactPerson;
                ToolTip = 'View or edit detailed information about the contact person at the object.';

                trigger OnAction()
                begin
                    Rec.ShowContact();
                end;
            }
            action(CopyObject)
            {
                ApplicationArea = All;
                Caption = 'Copy Object';
                Image = Copy;
                ToolTip = 'Copy the content of another object.';

                trigger OnAction()
                var
                    CopyObject: Report "BSD Copy Object";
                begin
                    CopyObject.SetObject(Rec);
                    CopyObject.RunModal();
                    CurrPage.Update();
                end;
            }
            action("Archive Object")
            {
                ApplicationArea = All;
                Caption = 'Archive Object';
                Image = Archive;
                ToolTip = 'Send the document to the archive.';

                trigger OnAction()
                var
                    ConfirmMsg: Label 'Archive Object %1?', comment = '%1 = Object No.';
                begin
                    if Confirm(StrSubstNo(ConfirmMsg, Rec."No.")) then begin
                        Rec.SendToArchive(Rec);
                        CurrPage.Update(false);
                    end;
                end;
            }
            action(Dimensions)
            {
                ApplicationArea = All;
                Caption = 'Dimensions';
                Image = Dimensions;
                RunObject = Page "Default Dimensions";
                RunPageLink = "Table ID" = const(Database::"BSD Object"),
                                  "No." = field("No.");
                ShortCutKey = 'Alt+D';
                ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
            }
            action(Comments)
            {
                ApplicationArea = All;
                Caption = 'Comments';
                Image = ViewComments;
                RunObject = Page "Comment Sheet";
                RunPageLink = "Table Name" = const("BSD Object"),
                                  "No." = field("No.");
                ToolTip = 'View or add comments for the record.';
            }
            action(DocAttach)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
            action("Interaction Log Entries")
            {
                ApplicationArea = All;
                Caption = 'Interaction Log Entries';
                Image = InteractionLog;
                RunObject = Page "Interaction Log Entries";
                RunPageLink = "BSD Object No." = field("No.");
                RunPageView = sorting(Date);
                ShortCutKey = 'Ctrl+F7';
                ToolTip = 'View a list of the interactions that you have logged, for example, when you create an interaction, print a cover sheet, a sales order, and so on.';
            }
            action(Tasks)
            {
                ApplicationArea = All;
                Caption = 'Tasks';
                Image = TaskList;
                RunObject = Page "Task List";
                RunPageLink = "BSD Object No." = field("No."),
                                  "System To-do Type" = filter(Organizer);
                RunPageView = sorting("Opportunity No.");
                ToolTip = 'View all marketing tasks that involve the opportunity.';
            }
            action("Create Interaction")
            {
                ApplicationArea = All;
                Caption = 'Create Interaction';
                Image = CreateInteraction;
                ToolTip = 'Create an interaction with a specified opportunity.';

                trigger OnAction()
                begin
                    Rec.CreateInteractionFromObject(Rec);
                end;
            }
            action(ObjectPictures)
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Object Pictures';
                Image = Picture;
                RunObject = Page "BSD Object Pictures";
                RunPageLink = "Object No." = field("No.");
                ToolTip = 'View all corresponding Object Pictures.';
            }
            action(Navigate)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Find entries...';
                Image = Navigate;
                ShortCutKey = 'Ctrl+Alt+Q';
                AboutTitle = 'Get detailed posting details';
                AboutText = 'Here, you can look up the ledger entries that are related to this object, as well as any related documents.';
                ToolTip = 'Find entries and documents that exist for this object.';

                trigger OnAction()
                begin
                    Rec.Navigate();
                end;
            }
        }
    }
    var
        ResubmissionDateExpired: Boolean;
        UseSalesOpportunity: Boolean;

    trigger OnAfterGetRecord()
    var
        sisMANSetup: Record "BSD sisMAN Setup";
    begin
        sisMANSetup.Get();
        UseSalesOpportunity := sisMANSetup."Use Sales Opportunity";
        if Rec."Resubmission Date" <> 0D then
            ResubmissionDateExpired := WorkDate() > Rec."Resubmission Date"
        else
            ResubmissionDateExpired := false;
    end;
}
