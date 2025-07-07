namespace BoSchData.sisMAN.Base;

page 71458608 "BSD Obj. Prod. Comm. Arch."
{
    AutoSplitKey = true;
    Caption = 'Comment Sheet';
    DataCaptionFields = "Object No.";
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "BSD Object Prod. Comment Arch.";
    UsageCategory = None;
    Editable = false;

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
}

