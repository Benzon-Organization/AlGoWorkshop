namespace BoSchData.sisMAN.Base;

using Microsoft.Sales.Archive;
using Microsoft.Foundation.Comment;

page 71458586 "BSD Object Archive Card"
{
    Caption = 'Object Archive Card';
    UsageCategory = None;
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "BSD Object Archive";
    InsertAllowed = false;
    DeleteAllowed = false;
    DataCaptionFields = "No.", "Version No.";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                }
                field("No. 2"; Rec."No. 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. 2 field.';
                    Visible = false;
                    Editable = false;
                }
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Version No. field.';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                    Editable = false;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description 2 field.';
                    Visible = false;
                    Editable = false;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field.';
                    Editable = false;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address 2 field.';
                    Editable = false;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the City field.';
                    Editable = false;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the County field.';
                    Editable = false;
                }
                field(District; Rec.District)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the District field.';
                    Editable = false;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                    Editable = false;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Search Name field.';
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                    Editable = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipment Method Code field.';
                    Editable = false;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipping Agent Code field.';
                    Editable = false;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipping Agent Service Code field.';
                    Editable = false;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Salesperson Code field.';
                    Editable = false;
                }
                field("Salesperson Code 2"; Rec."Salesperson Code 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Salesperson Code 2 field.';
                    Editable = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Assigned User ID field.';
                    Editable = false;
                }
                field("Service Zone Code"; Rec."Service Zone Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service Zone Code field.';
                    Editable = false;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Creation Date field.';
                    Editable = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                    Editable = false;
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Your Reference field.';
                    Editable = false;
                }
                Group(Submission)
                {

                    Caption = 'Submission';
                    Editable = false;

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
                    field("Resubmission Date"; Rec."Resubmission Date")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Resubmission Date field.';
                    }
                    field(Status; Rec.Status)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Status field.';
                    }
                    field("Work Description"; Rec."Work Description")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Work Description field.';
                    }
                }
                group(Contact)
                {
                    Caption = 'Contact';

                    field("Contact No."; Rec."Contact No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the corresponding Contact No.';
                        Editable = false;
                    }
                }
                field("Responsibility Center Filter"; Rec."Responsibility Center Filter")
                {
                    Editable = true;
                }
            }
            group("Object Status")
            {
                Caption = 'Object Status';
                Visible = UseSalesOpportunity;
                Editable = false;

                field("Opportunity No."; Rec."Opportunity No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Opportunity No. field.';
                }
                field(Attentioncode; Rec.Attentioncode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Attentioncode field.';
                }
                field(Tender; Rec.Tender)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender field.';
                }
                field("Object End Date"; Rec."Object End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Object End Date field.';
                }
                field("First Item Shipment"; Rec."First Item Shipment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the First Item Shipment field.';
                }
                field("Last Item Shipment"; Rec."Last Item Shipment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Item Shipment field.';
                }
                field("Sales Cycle Stage"; Rec."Sales Cycle Stage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Cycle Stage field.';
                }
                field("Sales Cycle Stage Description"; Rec."Sales Cycle Stage Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Cycle Stage Description field.';
                }
                field("Expected Completion Date"; Rec."Estimated Close Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Completion Date field.';
                }
                field("Expected Value (LCY)"; Rec."Estimated Value (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Value (LCY) field.';
                }
                field("Calcd. Current Value (LCY)"; Rec."Calcd. Current Value (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Calcd. Current Value (LCY) field.';
                }
                field("Chances of Success %"; Rec."Chances of Success %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Chances of Success % field.';
                }
                field("Completed %"; Rec."Completed %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completed % field.';
                }
                field("Probability %"; Rec."Probability %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Probability % field.';
                }
                field("Opportunity Status"; Rec."Opportunity Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Opportunity Status field.';
                }
            }
            part("BSD Obj. Resp.C.Rel.CardP Arch"; "BSD Obj. Resp.C.Rel.CardP Arch")
            {
                ApplicationArea = All;
                SubPageLink = "Object No." = field("No."), "Responsibility Center" = field("Responsibility Center Filter"), "Version No." = field("Version No.");
                Visible = HasResponsibilityCenterRelations;
                Editable = false;
            }
            part("BSD Obj. Contr. Sub. Arch."; "BSD Obj. Contr. Sub. Arch.")
            {
                ApplicationArea = All;
                SubPageLink = "Object No." = field("No."), "Responsibility Center" = field("Responsibility Center Filter"), "Version No." = field("Version No.");
                Editable = false;
            }
            part("BSD Obj. Prod. Sub. Arch."; "BSD Obj. Prod. Sub. Arch.")
            {
                ApplicationArea = All;
                SubPageLink = "Object No." = field("No."), "Responsibility Center" = field("Responsibility Center Filter"), "Version No." = field("Version No.");
                Editable = false;
            }
        }
        area(FactBoxes)
        {
            part(ObjectPicture; "BSD Object Picture Archive")
            {
                ApplicationArea = All;
                Provider = ObjectPictureLines;
                SubPageLink = "Object No." = field("Object No."), "Entry No." = field("Entry No."), "Version No." = field("Version No.");
                Editable = false;
            }
            part(ObjectPictureLines; "BSD Object Pic. Lines Arch. Fb")
            {
                ApplicationArea = All;
                SubPageLink = "Object No." = field("No."), "Version No." = field("Version No.");
                Editable = false;
            }
            part("BSD Opp. Resp.C. Rel. Arch. FB"; "BSD Opp. Resp.C. Rel. Arch. FB")
            {
                ApplicationArea = All;
                SubPageLink = "Object No." = field("No."), "Version No." = field("Version No.");
                Visible = UseSalesOpportunity;
                Editable = false;
            }
            part("BSD Comment Archive FactBox"; "BSD Comment Archive FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Table Name" = const("BSD Object"), "No." = field("No."), "Version No." = field("Version No.");
                Editable = false;
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            actionref(Restore_Promoted; Restore)
            {

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
                actionref(ObjectPictures_Promoted; ObjectPictures)
                {
                }
                actionref(ResponsibilityReference_Promoted; "ResponsibilityReference")
                {
                }
            }
        }
        area(Processing)
        {
            action(Restore)
            {
                ApplicationArea = All;
                Caption = 'Restore';
                Ellipsis = true;
                Image = Restore;
                ToolTip = 'Transfer the contents of this archived version to the original object. This is only possible if the original is not deleted.';

                trigger OnAction()
                var
                    RestoreObjectQst: Label 'Restore Object %1?', comment = '%1 = Object No.';
                begin
                    if Confirm(StrSubstNo(RestoreObjectQst, Rec."No.")) then
                        Rec.RestoreObject(Rec);
                end;
            }
            action(ResponsibilityReference)
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Responsibility Reference';
                Image = Responsibility;
                RunObject = Page "BSD Obj. Resp. Cent. Rel.Arch.";
                RunPageLink = "Object No." = field("No."), "Version No." = field("Version No.");
                ToolTip = 'View the corresponding Responsibility Centers.';
            }
            action(ObjectPictures)
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Object Pictures';
                Image = Picture;
                RunObject = Page "BSD Object Pictures Archive";
                RunPageLink = "Object No." = field("No."), "Version No." = field("Version No.");
                ToolTip = 'View all corresponding Object Pictures.';
            }
            action(Dimensions)
            {
                ApplicationArea = All;
                Caption = 'Dimensions';
                Image = Dimensions;
                RunObject = Page "BSD Default Dimensions Archive";
                RunPageLink = "Table ID" = const(Database::"BSD Object"),
                                  "No." = field("No."), "Version No." = field("Version No.");
                ShortCutKey = 'Alt+D';
                ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
            }
            action(Comments)
            {
                ApplicationArea = All;
                Caption = 'Comments';
                Image = ViewComments;
                RunObject = Page "Comment Archive List";
                RunPageLink = "Table Name" = const("BSD Object"),
                                  "No." = field("No."), "Version No." = field("Version No.");
                ToolTip = 'View or add comments for the record.';
            }
        }
    }

    var
        UseSalesOpportunity: Boolean;
        HasResponsibilityCenterRelations: Boolean;

    trigger OnOpenPage()
    var
        sisMANSetup: Record "BSD sisMAN Setup";
        ObjectRespCenterRel: Record "BSD Object Resp. Center Rel.";
    begin
        sisMANSetup.Get();
        UseSalesOpportunity := sisMANSetup."Use Sales Opportunity";

        ObjectRespCenterRel.SetRange("Object No.", Rec."No.");
        if not ObjectRespCenterRel.IsEmpty() then
            HasResponsibilityCenterRelations := true;
    end;
}
