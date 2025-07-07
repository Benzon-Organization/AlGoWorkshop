namespace BoSchData.sisMAN.Base;

page 71458575 "BSD sisMAN Setup"
{
    Caption = 'sisMAN Setup';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BSD sisMAN Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Use Sales Opportunity"; Rec."Use Sales Opportunity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether Sales opportunities should be used.';
                }
                field("Resubmission date formula"; Rec."Resubmission date formula")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date formula for resubmission.';
                }
                field("Activate Changelog"; Rec."Activate Changelog")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the changelog should be activated.';
                }
                field("Object Type Dimension"; Rec."Object Type Dimension")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the dimension that should be used for Objecttypes';
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';

                field("No. Series"; Rec."Object Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the No. Series that are used.';
                }
            }
            group(Archiving)
            {
                Caption = 'Archiving';

                field("Archive Objects"; Rec."Archive Objects")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the objects should be archived when deleted.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}