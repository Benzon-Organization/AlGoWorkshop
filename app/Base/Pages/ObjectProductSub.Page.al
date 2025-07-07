namespace BoSchData.sisMAN.Base;
using Microsoft.Inventory.Availability;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.BOM;
using Microsoft.Inventory.Item.Substitution;

page 71458584 "BSD Object Product Sub."
{
    ApplicationArea = All;
    Caption = 'Products';
    PageType = ListPart;
    SourceTable = "BSD Object Product";
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;

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

                    trigger OnValidate()
                    begin
                        if Rec."Item Category" <> '' then
                            ItemCategoryLine := true
                        else
                            ItemCategoryLine := false;
                    end;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No. field.';

                    trigger OnValidate()
                    begin
                        if Rec."Item No." <> '' then
                            ItemCategoryLine := false;
                    end;
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
                    Editable = ItemCategoryLine;
                }
                field("Sales Unit of Measure"; Rec."Sales Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Unit of Measure field.';
                    Editable = ItemCategoryLine;
                }
                field("Purchase Unit of Measure"; Rec."Purchase Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Unit of Measure field.';
                    Editable = ItemCategoryLine;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Net Weight field.';
                    Editable = ItemCategoryLine;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gross Weight field.';
                    Editable = ItemCategoryLine;
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
            // group(Control51)
            // {
            //     ShowCaption = false;

            //     field("Invoice Discount Amount"; InvoiceDiscountAmount)
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Invoice Discount Amount';
            //         ToolTip = 'Specifies a discount amount that is deducted from the value of the Total line amount.';
            //         DecimalPlaces = 2 :;
            //         Editable = false;
            //     }
            //     field(ObjectProductTotals_LineAmount; ObjectProductTotals."Line Amount")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Subtotal Excl. VAT';
            //         Editable = false;
            //         ToolTip = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document.';
            //         DecimalPlaces = 2 :;
            //     }
            // }
            //TODO Summenfelder etc. Workitem #192
        }
    }
    actions
    {
        area(Processing)
        {
            group(Line)
            {
                Caption = 'Line';

                group("Item Availability by")
                {
                    Enabled = Rec."Item No." <> '';
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action(ItemAvailabilityByEvent)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Event';
                        Image = "Event";
                        ToolTip = 'View how the actual and the projected available balance of an item will develop over time according to supply and demand events.';

                        trigger OnAction()
                        begin
                            Rec.ShowItemAvailFromObjectProduct(Rec, "Item Availability Type"::"Event")
                        end;
                    }
                    action(ItemAvailabilityByPeriod)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Period';
                        Image = Period;
                        ToolTip = 'Show the projected quantity of the item over time according to time periods, such as day, week, or month.';

                        trigger OnAction()
                        begin
                            Rec.ShowItemAvailFromObjectProduct(Rec, "Item Availability Type"::Period)
                        end;
                    }
                    action(ItemAvailabilityByVariant)
                    {
                        ApplicationArea = Planning;
                        Caption = 'Variant';
                        Image = ItemVariant;
                        ToolTip = 'View or edit the item''s variants. Instead of setting up each color of an item as a separate item, you can set up the various colors as variants of the item.';

                        trigger OnAction()
                        begin
                            Rec.ShowItemAvailFromObjectProduct(Rec, "Item Availability Type"::Variant)
                        end;
                    }
                    action(ItemAvailabilityByLocation)
                    {
                        AccessByPermission = TableData Location = R;
                        ApplicationArea = Location;
                        Caption = 'Location';
                        Image = Warehouse;
                        ToolTip = 'View the actual and projected quantity of the item per location.';

                        trigger OnAction()
                        begin
                            Rec.ShowItemAvailFromObjectProduct(Rec, "Item Availability Type"::Location)
                        end;
                    }
                    action(Lot)
                    {
                        ApplicationArea = ItemTracking;
                        Caption = 'Lot';
                        Image = LotInfo;
                        RunObject = Page "Item Availability by Lot No.";
                        RunPageLink = "No." = field("Item No.");
                        ToolTip = 'View the current and projected quantity of the item for each lot.';
                    }
                    action("BOM Level")
                    {
                        AccessByPermission = TableData "BOM Buffer" = R;
                        ApplicationArea = Assembly;
                        Caption = 'BOM Level';
                        Image = BOMLevel;
                        ToolTip = 'View availability figures for items on bills of materials that show how many units of a parent item you can make based on the availability of child items.';

                        trigger OnAction()
                        begin
                            Rec.ShowItemAvailFromObjectProduct(Rec, "Item Availability Type"::BOM)
                        end;
                    }
                    action(ItemAvailabilityByUnitOfMeasure)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Unit of Measure';
                        Image = UnitOfMeasure;
                        ToolTip = 'View the item''s availability by a unit of measure.';

                        trigger OnAction()
                        begin
                            Rec.ShowItemAvailFromObjectProduct(Rec, "Item Availability Type"::UOM);
                        end;
                    }
                }
                group("Related Information")
                {
                    Caption = 'Related Information';
                    action(SelectItemSubstitution)
                    {
                        AccessByPermission = TableData "Item Substitution" = R;
                        ApplicationArea = Suite;
                        Caption = 'Select Item Substitution';
                        Image = SelectItemSubstitution;
                        ToolTip = 'Select another item that has been set up to be sold instead of the original item if it is unavailable.';

                        trigger OnAction()
                        begin
                            Rec.ShowItemSub();
                        end;
                    }
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
    }

    var
        ObjectProductTotals: Record "BSD Object Product";
        ItemCategoryLine: Boolean;

    trigger OnAfterGetCurrRecord()
    begin
        ObjectProductTotals.SetRange("Object No.", Rec."Object No.");
        ObjectProductTotals.CalcSums("Line Amount");


    end;
}
