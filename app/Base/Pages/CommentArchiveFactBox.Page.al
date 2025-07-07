namespace BoSchData.sisMAN.Base;
using Microsoft.Foundation.Comment;


page 71458610 "BSD Comment Archive FactBox"
{
    Caption = 'Comments';
    DeleteAllowed = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Comment Line Archive";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                ShowCaption = false;
                field("Date"; Rec.Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Date of comment creation.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the comment.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Comments)
            {
                ApplicationArea = All;
                Caption = 'Open Comments';
                Image = ViewComments;
                RunObject = Page "Comment Sheet";
                RunPageLink = "Table Name" = const("BSD Object"),
                                  "No." = field("No.");
                ToolTip = 'View or add comments for the record.';
            }
        }
    }
}

