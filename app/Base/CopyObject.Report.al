namespace BoSchData.sisMAN.Base;

report 71458575 "BSD Copy Object"
{
    Caption = 'Copy Object';
    ProcessingOnly = true;
    UsageCategory = None;

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ObjectNo_Options; ObjectNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Object No.';
                        ShowMandatory = true;
                        ToolTip = 'Specifies the number of the Object that is processed by the report or batch job.';
                        TableRelation = "BSD Object";

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            Object: Record "BSD Object";
                        begin
                            if PAGE.RunModal(Page::"BSD Object List", Object) = ACTION::LookupOK then begin
                                ObjectNo := Object."No.";
                                Description := Object.Description;
                            end;
                        end;

                        trigger OnValidate()
                        var
                            Object: Record "BSD Object";
                        begin
                            if Object.Get(ObjectNo) then
                                Description := Object.Description
                            else
                                Description := '';
                        end;
                    }
                    field(Description_Options; Description)
                    {
                        ApplicationArea = All;
                        Caption = 'Description';
                        Editable = false;
                        ToolTip = 'Specifies the description of the Object.';
                    }
                    field(IncludeHeader_Options; IncludeHeader)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Include Header';
                        ToolTip = 'Specifies if you also want to copy the information from the object header.';
                    }
                    field(IncludeContributors_Options; IncludeContributors)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Include Contributors';
                        ToolTip = 'Specifies if you also want to copy the information from the contributor lines.';
                    }
                    field(IncludeProducts_Options; IncludeProducts)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Include Products';
                        ToolTip = 'Specifies if you also want to copy the information from the prodcut lines.';
                    }
                }
            }
        }
    }
    var
        TargetObject: Record "BSD Object";
        ObjectNo: Code[20];
        Description: Text[100];
        IncludeHeader: Boolean;
        IncludeContributors: Boolean;
        IncludeProducts: Boolean;

    trigger OnPreReport()
    var
        Object: Record "BSD Object";
        TargetObjectNo: Code[20];
        NothingToProcessErr: Label 'There is nothing to process. Please choose atleast one of the options: Include Headers, Include Contributors or Include Products.';
        SuccessMsg: Label 'Success! The Object has been copied.';
    begin
        if (not IncludeHeader) and (not IncludeContributors) and (not IncludeProducts) then
            Error((NothingToProcessErr));

        Object.Get(ObjectNo);
        TargetObjectNo := TargetObject."No.";

        if IncludeHeader then
            CopyHeader(Object, TargetObjectNo);

        if IncludeContributors then
            CopyContributors(Object, TargetObjectNo);

        if IncludeProducts then
            CopyProducts(Object, TargetObjectNo);

        Message(SuccessMsg);
    end;

    local procedure CopyHeader(Object: Record "BSD Object"; TargetObjectNo: Code[20])
    var
        NewObject: Record "BSD Object";
    begin
        TargetObject.Delete();
        NewObject.Init();
        NewObject.TransferFields(Object);
        NewObject."No." := TargetObjectNo;
        NewObject.Insert();
    end;

    local procedure CopyContributors(Object: Record "BSD Object"; TargetObjectNo: Code[20])
    var
        ObjectContributor: Record "BSD Object Contributor";
        NewObjectContributor: Record "BSD Object Contributor";
    begin
        ObjectContributor.SetRange("Object No.", TargetObjectNo);
        ObjectContributor.DeleteAll();

        ObjectContributor.SetRange("Object No.", Object."No.");
        if ObjectContributor.FindSet() then
            repeat
                NewObjectContributor.Init();
                NewObjectContributor.TransferFields(ObjectContributor);
                NewObjectContributor."Object No." := TargetObjectNo;
                NewObjectContributor.Insert();
            until ObjectContributor.Next() = 0;
    end;

    local procedure CopyProducts(Object: Record "BSD Object"; TargetObjectNo: Code[20])
    var
        ObjectProduct: Record "BSD Object Product";
        NewObjectProduct: Record "BSD Object Product";
    begin
        ObjectProduct.SetRange("Object No.", TargetObjectNo);
        ObjectProduct.DeleteAll();

        ObjectProduct.SetRange("Object No.", Object."No.");
        if ObjectProduct.FindSet() then
            repeat
                NewObjectProduct.Init();
                NewObjectProduct.TransferFields(ObjectProduct);
                NewObjectProduct."Object No." := TargetObjectNo;
                NewObjectProduct.Insert();
            until ObjectProduct.Next() = 0;
    end;

    procedure SetObject(var NewObject: Record "BSD Object")
    begin
        NewObject.TestField("No.");
        TargetObject := NewObject;
    end;
}
