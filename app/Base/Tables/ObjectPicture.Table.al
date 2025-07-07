namespace BoSchData.sisMAN.Base;
using System.Environment;

table 71458582 "BSD Object Picture"
{
    DrillDownPageID = "BSD Object Picture";
    LookupPageID = "BSD Object Picture";
    fields
    {
        field(1; "Object No."; Code[20])
        {
            Caption = 'Object No.';
            DataClassification = CustomerContent;
            TableRelation = "BSD Object";
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(3; Picture; Media)
        {
            Caption = 'Picture';
            DataClassification = CustomerContent;
        }
        field(4; Filename; Text[250])
        {
            Caption = 'Filename';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Object No.", "Entry No.")
        {
            Clustered = true;
        }
    }

    local procedure InitNewRecord(ObjectPicture: Record "BSD Object Picture")
    begin
        Rec.Init();
        Rec."Object No." := ObjectPicture."Object No.";
        Rec."Entry No." := 0;
        Rec.Insert();
    end;

    procedure ImportAttachment(ObjectPicture: Record "BSD Object Picture")
    var
        FromFileName: Text;
        InStreamPic: Instream;
    begin
        if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', FromFileName, InStreamPic) then begin
            if Rec.Get(ObjectPicture."Object No.", ObjectPicture."Entry No.") then
                InitNewRecord(ObjectPicture)
            else
                Rec.Insert();

            Rec.Picture.ImportStream(InStreamPic, FromFileName);
            Rec.Filename := CopyStr(FromFileName, 1, 250);
            Rec.Modify(true);
        end;
    end;

    procedure ExportAttachment()
    var
        TenantMedia: Record "Tenant Media";
        InStreamPic: InStream;
        FileNameTxt: Text;
    begin
        if not Rec.Picture.HasValue then
            exit;

        if TenantMedia.Get(Rec.Picture.MediaId) then begin
            TenantMedia.CalcFields(Content);
            if TenantMedia.Content.HasValue then begin
                FileNameTxt := StrSubstNo(Rec.Filename, Rec.TableCaption);
                TenantMedia.Content.CreateInStream(InStreamPic);
                DownloadFromStream(InStreamPic, '', '', '', FileNameTxt);
            end;
        end;
    end;
}