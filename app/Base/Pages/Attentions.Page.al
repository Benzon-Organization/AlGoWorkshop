namespace BoSchData.sisMAN.Base;

page 71458577 "BSD Attentions"
{
    Caption = 'Attentions';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "BSD Attention";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Attention Code.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Description.';
                }
            }
        }
    }
}