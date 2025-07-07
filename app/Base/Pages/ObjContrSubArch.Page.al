namespace BoSchData.sisMAN.Base;

page 71458588 "BSD Obj. Contr. Sub. Arch."
{
    ApplicationArea = All;
    Caption = 'Contributors';
    PageType = ListPart;
    SourceTable = "BSD Object Contr. Archive";
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
                field("Contributor Type"; Rec."Contributor Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contributor Type field.';
                }
                field("Contact Type"; Rec."Contact Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact Type field.';
                }
                field("Business Relation"; Rec."Business Relation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Business Relation field.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name 2 field.';
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
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post Code field.';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the City field.';
                }
                field("Customer Template"; Rec."Customer Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Template field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
