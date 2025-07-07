namespace BoSchData.sisMAN.Base;

using Microsoft.Foundation.Comment;

page 71458587 "BSD Object Archive List"
{
    ApplicationArea = All;
    Caption = 'Objects Archive';
    PageType = List;
    SourceTable = "BSD Object Archive";
    UsageCategory = History;
    CardPageId = "BSD Object Archive Card";
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
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
                }
                field("No. 2"; Rec."No. 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. 2 field.';
                    Visible = false;
                }
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Version No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description 2 field.';
                    Visible = false;
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
            part(ObjectPicture; "BSD Object Picture Archive")
            {
                ApplicationArea = All;
                Provider = ObjectPictureLines;
                SubPageLink = "Object No." = field("Object No."), "Entry No." = field("Entry No."), "Version No." = field("Version No.");
            }
            part(ObjectPictureLines; "BSD Object Pic. Lines Arch. Fb")
            {
                ApplicationArea = All;
                SubPageLink = "Object No." = field("No."), "Version No." = field("Version No.");
            }
            part("BSD Opp. Resp.C. Rel. Arch. FB"; "BSD Opp. Resp.C. Rel. Arch. FB")
            {
                ApplicationArea = All;
                SubPageLink = "Object No." = field("No."), "Version No." = field("Version No.");
                Visible = UseSalesOpportunity;
            }
            part("BSD Comment Archive FactBox"; "BSD Comment Archive FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Table Name" = const("BSD Object"), "No." = field("No."), "Version No." = field("Version No.");
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

    trigger OnAfterGetRecord()
    var
        sisMANSetup: Record "BSD sisMAN Setup";
    begin
        sisMANSetup.Get();
        UseSalesOpportunity := sisMANSetup."Use Sales Opportunity";
    end;
}
