namespace BoSchData.sisMAN.Base;
using Microsoft.Foundation.Address;

pageextension 71458575 "BSD Post Codes" extends "Post Codes"
{
    layout
    {
        modify(County)
        {
            Visible = false;
        }
        addafter("Country/Region Code")
        {
            field("BSD County"; Rec."BSD County")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the County.';
            }
            field("BSD District"; Rec."BSD District")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the District.';
            }
        }
    }
}