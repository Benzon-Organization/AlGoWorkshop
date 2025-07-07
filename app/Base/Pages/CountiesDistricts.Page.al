namespace BoSchData.sisMAN.Base;

page 71458576 "BSD Counties/Districts"
{
    Caption = 'Counties/Districts';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "BSD County/District";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Area"; Rec."Area")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Area Code.';
                }
                field("Area Text"; Rec."Area Text")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Area Text.';
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the County/District Code.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the County/District Descruiption Code.';
                }

            }
        }
    }
}