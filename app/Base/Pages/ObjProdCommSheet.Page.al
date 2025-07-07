namespace BoSchData.sisMAN.Base;

page 71458585 "BSD Obj. Prod. Comm. Sheet"
{
    AutoSplitKey = true;
    Caption = 'Comment Sheet';
    DataCaptionFields = "Object No.";
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "BSD Object Product Comment";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Date"; Rec.Date)
                {
                    ApplicationArea = Comments;
                    ToolTip = 'Specifies the date the comment was created.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Comments;
                    ToolTip = 'Specifies the comment itself.';
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Comments;
                    ToolTip = 'Specifies a code for the comment.';
                    Visible = false;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetUpNewLine();
    end;
}

