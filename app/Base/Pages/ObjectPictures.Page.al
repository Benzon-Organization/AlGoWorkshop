namespace BoSchData.sisMAN.Base;

page 71458581 "BSD Object Pictures"
{
    ApplicationArea = All;
    Caption = 'Object Pictures';
    PageType = List;
    SourceTable = "BSD Object Picture";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Picture; Rec.Picture)
                {
                    ToolTip = 'Specifies the value of the Picture field.';
                }
                field(Filename; Rec.Filename)
                {
                    ToolTip = 'Specifies the value of the Filename field.';
                }
            }
        }
    }
    actions
    {
        area(Promoted)
        {
            actionref(ImportMedia_Promoted; ImportMedia)
            {

            }
            actionref(ExportMedia_Promoted; ExportMedia)
            {

            }
        }
        area(Processing)
        {
            action(ImportMedia)
            {
                ApplicationArea = All;
                Caption = 'Import Attachment';
                ToolTip = 'Import an Attachment.';
                Image = Import;

                trigger OnAction()
                begin
                    Rec.ImportAttachment(Rec);
                end;
            }

            action(ExportMedia)
            {
                ApplicationArea = all;
                Caption = 'Export Attachment';
                ToolTip = 'Export the Attachment.';
                Image = Export;

                trigger OnAction()
                begin
                    Rec.ExportAttachment();
                end;
            }
        }
    }
}
