namespace BoSchData.sisMAN.Base;
using System.Utilities;
using Microsoft.Finance.Dimension;
using Microsoft.Foundation.Address;
using Microsoft.Foundation.Shipping;
using Microsoft.CRM.BusinessRelation;
using Microsoft.Foundation.NoSeries;
using Microsoft.Inventory.Ledger;
using Microsoft.Service.Setup;
using System.Security.User;
using Microsoft.CRM.Team;
using Microsoft.Inventory.Location;
using Microsoft.Foundation.Comment;
using Microsoft.CRM.Opportunity;

table 71458584 "BSD Object Archive"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Search Name"; Code[100])
        {
            Caption = 'Search Name';
            DataClassification = CustomerContent;
        }
        field(4; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
        field(5; Address; Text[100])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(6; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = CustomerContent;
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
            TableRelation = if ("Country/Region Code" = const('')) "Post Code".City
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("Country/Region Code"));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(8; County; Code[10])
        {
            Caption = 'County';
            DataClassification = CustomerContent;
            TableRelation = "BSD County/District"."Area";
        }
        field(9; District; Code[10])
        {
            Caption = 'District';
            DataClassification = CustomerContent;
            TableRelation = "BSD County/District".Code where("Area" = field("County"));
        }
        field(10; "No. 2"; Code[20])
        {
            Caption = 'No. 2';
            DataClassification = CustomerContent;
        }
        field(12; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));
            DataClassification = CustomerContent;
        }
        field(13; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
            DataClassification = CustomerContent;
        }
        field(14; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
            DataClassification = CustomerContent;
        }
        field(15; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code where("Shipping Agent Code" = field("Shipping Agent Code"));
            DataClassification = CustomerContent;
        }
        field(16; "Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser" where(Blocked = const(false));
            DataClassification = CustomerContent;
        }
        field(17; "Salesperson Code 2"; Code[20])
        {
            Caption = 'Salesperson Code 2';
            TableRelation = "Salesperson/Purchaser" where(Blocked = const(false));
            DataClassification = CustomerContent;
        }
        field(18; "Assigned User ID"; Code[50])
        {
            Caption = 'Assigned User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = "User Setup";
        }
        field(19; "Service Zone Code"; Code[10])
        {
            Caption = 'Service Zone Code';
            TableRelation = "Service Zone";
            DataClassification = CustomerContent;
        }
        field(20; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(21; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(22; "Your Reference"; Text[35])
        {
            Caption = 'Your Reference';
            DataClassification = CustomerContent;
        }
        field(23; "Submission Date"; Date)
        {
            Caption = 'Submission Date';
            DataClassification = CustomerContent;
        }
        field(24; "Planned Duration from"; Date)
        {
            Caption = 'Planned Duration from';
            DataClassification = CustomerContent;
        }
        field(25; "Planned Duration to"; Date)
        {
            Caption = 'Planned Duration to';
            DataClassification = CustomerContent;
        }
        field(26; "Resubmission Date"; Date)
        {
            Caption = 'Resubmission Date';
            DataClassification = CustomerContent;
        }
        field(27; Status; Enum "BSD Object Status")
        {
            Caption = 'Status';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(28; "Work Description"; Text[500])
        {
            Caption = 'Work Description';
            DataClassification = CustomerContent;
        }
        field(29; "Opportunity No."; Code[20])
        {
            Caption = 'Opportunity No.';
            DataClassification = CustomerContent;
            TableRelation = Opportunity;
        }
        field(30; Attentioncode; Code[20])
        {
            Caption = 'Attentioncode';
            DataClassification = CustomerContent;
            TableRelation = "BSD Attention";
        }
        field(31; Tender; Code[20])
        {
            Caption = 'Tender';
            DataClassification = CustomerContent;
            TableRelation = "BSD Tender";
        }
        field(32; "Object End Date"; Date)
        {
            Caption = 'Object End Date';
            DataClassification = CustomerContent;
        }
        field(33; "Sales Cycle Stage"; Integer)
        {
            Caption = 'Sales Cycle Stage';
            DataClassification = CustomerContent;
            TableRelation = "Sales Cycle Stage".Stage;
            Editable = false;
        }
        field(34; "Sales Cycle Stage Description"; Text[100])
        {
            Caption = 'Sales Cycle Stage Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(35; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(36; "Estimated Value (LCY)"; Decimal)
        {
            Caption = 'Estimated Value (LCY)';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(37; "Calcd. Current Value (LCY)"; Decimal)
        {
            Caption = 'Calcd. Current Value (LCY)';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(38; "Chances of Success %"; Decimal)
        {
            Caption = 'Chances of Success %';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(39; "Completed %"; Decimal)
        {
            Caption = 'Completed %';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(40; "Probability %"; Decimal)
        {
            Caption = 'Sales Cycle Stage Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(42; "First Item Shipment"; Date)
        {
            Caption = 'First Item Shipment';
            FieldClass = FlowField;
            CalcFormula = min("Item Ledger Entry"."Posting Date" where("BSD Object No." = field("No.")));
            Editable = false;
        }
        field(43; "Last Item Shipment"; Date)
        {
            Caption = 'Last Item Shipment';
            FieldClass = FlowField;
            CalcFormula = max("Item Ledger Entry"."Posting Date" where("BSD Object No." = field("No.")));
            Editable = false;
        }
        field(44; "Estimated Close Date"; Date)
        {
            Caption = 'Estimated Close Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(45; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Contact Business Relation"."Contact No." where("No." = field("No."), "Link to Table" = const("Contact Business Relation Link To Table"::"BSD Object")));
            Editable = false;
        }
        field(46; "Opportunity Status"; Enum "Opportunity Status")
        {
            Caption = 'Opportunity Status';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(91; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = CustomerContent;
            TableRelation = if ("Country/Region Code" = const('')) "Post Code"
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("Country/Region Code"));
            ValidateTableRelation = false;
        }
        field(77; "Responsibility Center Filter"; Code[10])
        {
            Caption = 'Responsibility Center Filter';
            ToolTip = 'Filter this page for a responsibility center specified in the Responsibility Center Relations.';
            DataClassification = CustomerContent;
            TableRelation = "BSD Object Resp. Center Rel."."Responsibility Center" where("Object No." = field("No."));
        }
        field(78; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(999; "Version No."; Integer)
        {
            Caption = 'Version No.';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "No.", "Version No.")
        {
            Clustered = true;
        }
    }

    procedure RestoreObject(ObjectArchive: Record "BSD Object Archive")
    var
        Object: Record "BSD Object";
        NoOriginalObjectErr: Label 'The original Object could not be found so restoring is not possible.';
        RestoredMsg: Label 'Object %1 hase been restored.', comment = '%1 = Object No.';
    begin
        if Object.Get(ObjectArchive."No.") then begin
            Object.Delete();

            Object.Reset();
            Object.Init();
            Object.TransferFields(ObjectArchive);
            Object.Insert();

            DeleteAndInsertObjectContributors(ObjectArchive."No.", "Version No.");
            DeleteAndInsertObjectProducts(ObjectArchive."No.", "Version No.");
            DeleteAndInsertObjectRespCenterRel(ObjectArchive."No.", "Version No.");
            DeleteAndInsertObjectPictures(ObjectArchive."No.", "Version No.");
            DeleteAndInsertObjectProductComments(ObjectArchive."No.", "Version No.");
            DeleteAndInsertCommentLines(ObjectArchive."No.", "Version No.");
            DeleteAndInsertDefaultDimensions(ObjectArchive."No.", "Version No.");

            Message(RestoredMsg, Object."No.");
        end else
            Error(NoOriginalObjectErr);
    end;

    local procedure DeleteAndInsertObjectContributors(ObjectNo: Code[20]; VersionNo: Integer)
    var
        ObjectContributor: Record "BSD Object Contributor";
        ObjectContrArchive: Record "BSD Object Contr. Archive";
    begin
        ObjectContributor.SetRange("Object No.", ObjectNo);
        if not ObjectContributor.IsEmpty() then
            ObjectContributor.DeleteAll();

        ObjectContrArchive.SetRange("Object No.", ObjectNo);
        ObjectContrArchive.SetRange("Version No.", VersionNo);
        if ObjectContrArchive.Findset() then
            repeat
                ObjectContributor.Init();
                ObjectContributor.TransferFields(ObjectContrArchive);
                ObjectContributor.Insert();
            until ObjectContrArchive.Next() = 0;
    end;

    local procedure DeleteAndInsertObjectProducts(ObjectNo: Code[20]; VersionNo: Integer)
    var
        ObjectProduct: Record "BSD Object Product";
        ObjectProductArchive: Record "BSD Object Product Archive";
    begin
        ObjectProduct.SetRange("Object No.", ObjectNo);
        if not ObjectProduct.IsEmpty() then
            ObjectProduct.DeleteAll();

        ObjectProductArchive.SetRange("Object No.", ObjectNo);
        ObjectProductArchive.SetRange("Version No.", VersionNo);
        if ObjectProductArchive.Findset() then
            repeat
                ObjectProduct.Init();
                ObjectProduct.TransferFields(ObjectProductArchive);
                ObjectProduct.Insert();
            until ObjectProductArchive.Next() = 0;
    end;

    local procedure DeleteAndInsertObjectRespCenterRel(ObjectNo: Code[20]; VersionNo: Integer)
    var
        ObjectRespCenterRel: Record "BSD Object Resp. Center Rel.";
        ObjRespCentRelArch: Record "BSD Obj. Resp. Cent. Rel.Arch.";
    begin
        ObjectRespCenterRel.SetRange("Object No.", ObjectNo);
        if not ObjectRespCenterRel.IsEmpty() then
            ObjectRespCenterRel.DeleteAll();

        ObjRespCentRelArch.SetRange("Object No.", ObjectNo);
        ObjRespCentRelArch.SetRange("Version No.", VersionNo);
        if ObjRespCentRelArch.Findset() then
            repeat
                ObjectRespCenterRel.Init();
                ObjectRespCenterRel.TransferFields(ObjRespCentRelArch);
                ObjectRespCenterRel.Insert();
            until ObjRespCentRelArch.Next() = 0;
    end;

    local procedure DeleteAndInsertObjectPictures(ObjectNo: Code[20]; VersionNo: Integer)
    var
        ObjectPictures: Record "BSD Object Picture";
        ObjectPictureArchive: Record "BSD Object Picture Archive";
        TempBlob: Codeunit "Temp Blob";
        Outstream: OutStream;
        Instream: InStream;
    begin
        ObjectPictures.SetRange("Object No.", ObjectNo);
        if not ObjectPictures.IsEmpty() then
            ObjectPictures.DeleteAll();

        ObjectPictureArchive.SetRange("Object No.", ObjectNo);
        ObjectPictureArchive.SetRange("Version No.", VersionNo);
        if ObjectPictureArchive.Findset() then
            repeat
                Outstream := TempBlob.CreateOutStream();
                ObjectPictureArchive.Picture.ExportStream(Outstream);
                Instream := TempBlob.CreateInStream();

                ObjectPictures.Init();
                ObjectPictures.TransferFields(ObjectPictureArchive);
                ObjectPictures.Picture.ImportStream(Instream, '');
                ObjectPictures.Insert();
            until ObjectPictureArchive.Next() = 0;
    end;

    local procedure DeleteAndInsertObjectProductComments(ObjectNo: Code[20]; VersionNo: Integer)
    var
        ObjectProductComment: Record "BSD Object Product Comment";
        ObjectProdCommentArch: Record "BSD Object Prod. Comment Arch.";
    begin
        ObjectProductComment.SetRange("Object No.", ObjectNo);
        if not ObjectProductComment.IsEmpty() then
            ObjectProductComment.DeleteAll();

        ObjectProdCommentArch.SetRange("Object No.", ObjectNo);
        ObjectProdCommentArch.SetRange("Version No.", VersionNo);
        if ObjectProdCommentArch.Findset() then
            repeat
                ObjectProductComment.Init();
                ObjectProductComment.TransferFields(ObjectProdCommentArch);
                ObjectProductComment.Insert();
            until ObjectProdCommentArch.Next() = 0;
    end;

    local procedure DeleteAndInsertCommentLines(ObjectNo: Code[20]; VersionNo: Integer)
    var
        CommentLine: Record "Comment Line";
        CommentLineArchive: Record "Comment Line Archive";
    begin
        CommentLine.SetRange("Table Name", "Comment Line Table Name"::"BSD Object");
        CommentLine.SetRange("No.", ObjectNo);
        if not CommentLine.IsEmpty() then
            CommentLine.DeleteAll();

        CommentLineArchive.SetRange("Table Name", "Comment Line Table Name"::"BSD Object");
        CommentLineArchive.SetRange("No.", ObjectNo);
        CommentLineArchive.SetRange("Version No.", VersionNo);
        if CommentLineArchive.Findset() then
            repeat
                CommentLine.Init();
                CommentLine.TransferFields(CommentLineArchive);
                CommentLine.Insert();
            until CommentLineArchive.Next() = 0;
    end;

    local procedure DeleteAndInsertDefaultDimensions(ObjectNo: Code[20]; VersionNo: Integer)
    var
        DefaultDimension: Record "Default Dimension";
        DefaultDimensionArchive: Record "BSD Default Dimension Archive";
    begin
        DefaultDimension.SetRange("Table ID", Database::"BSD Object");
        DefaultDimension.SetRange("No.", ObjectNo);
        if not DefaultDimension.IsEmpty() then
            DefaultDimension.DeleteAll();

        DefaultDimensionArchive.SetRange("Table ID", Database::"BSD Object");
        DefaultDimensionArchive.SetRange("No.", ObjectNo);
        DefaultDimensionArchive.SetRange("Version No.", VersionNo);
        if DefaultDimensionArchive.Findset() then
            repeat
                DefaultDimension.Init();
                DefaultDimension.TransferFields(DefaultDimensionArchive);
                DefaultDimension.Insert();
            until DefaultDimensionArchive.Next() = 0;
    end;
}