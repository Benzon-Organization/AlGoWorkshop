namespace BoSchData.sisMAN.Base;

page 71458578 "BSD Tenders"
{
    Caption = 'Tenders';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "BSD Tender";

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