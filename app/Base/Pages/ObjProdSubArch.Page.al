namespace BoSchData.sisMAN.Base;

page 71458589 "BSD Obj. Prod. Sub. Arch."
{
    ApplicationArea = All;
    Caption = 'Products';
    PageType = ListPart;
    SourceTable = "BSD Object Product Archive";
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
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
                field("Item Category"; Rec."Item Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Category field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Variant Code field.';
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                    ShowMandatory = true;
                }
                field("Unit of Measure"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                }
                field("Sales Unit of Measure"; Rec."Sales Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Unit of Measure field.';
                }
                field("Purchase Unit of Measure"; Rec."Purchase Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Unit of Measure field.';
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Net Weight field.';
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gross Weight field.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line Discount % field.';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line Amount field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipment Date field.';
                }
            }
            //TODO Summenfelder etc. Workitem #192
        }
    }
    actions
    {
        area(Processing)
        {
            action(Comments)
            {
                ApplicationArea = Comments;
                Caption = 'Comments';
                Image = ViewComments;
                ToolTip = 'View or add comments for the record.';

                trigger OnAction()
                begin
                    Rec.ShowLineComments();
                end;
            }
        }
    }
}
