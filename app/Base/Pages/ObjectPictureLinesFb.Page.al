namespace BoSchData.sisMAN.Base;

page 71458598 "BSD Object Picture Lines Fb"
{
    Caption = 'Object Pictures';
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "BSD Object Picture";


    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field(Filename; Rec.Filename)
                {
                    ApplicationArea = All;
                    Caption = 'Filename';
                    ToolTip = 'Filename of attached file.';

                    trigger OnDrillDown()
                    begin
                        Rec.ExportAttachment();
                    end;
                }
            }
        }
    }
    actions
    {
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