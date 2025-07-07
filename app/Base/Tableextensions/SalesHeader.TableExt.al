namespace BoSchData.sisMAN.Base;

using Microsoft.Sales.Document;

tableextension 71458577 "BSD Sales Header" extends "Sales Header"
{
    fields
    {
        field(71458575; "BSD Object No."; Code[20])
        {
            Caption = 'Object No.';
            DataClassification = CustomerContent;
            TableRelation = "BSD Object";

            trigger OnValidate()
            var
                ObjectContributor: Record "BSD Object Contributor";
                CreateContributorQst: Label 'The Customer %1 is not part of the contributors of Object %2.\Do you want to add the customer as contributor?', comment = '%1 = Customer No., %2 = Object No.';
            begin
                if "BSD Object No." <> '' then begin
                    ObjectContributor.SetRange("Object No.", Rec."BSD Object No.");
                    ObjectContributor.SetRange("Contributor Type", "BSD Contributor Type"::Customer);
                    ObjectContributor.SetRange("No.", Rec."Sell-to Customer No.");
                    ObjectContributor.SetRange("Responsibility Center", Rec."Responsibility Center");
                    if ObjectContributor.IsEmpty() then
                        if Confirm(StrSubstNo(CreateContributorQst, Rec."Sell-to Customer No.", Rec."BSD Object No.")) then
                            ObjectContributor.AddCustVendAsContributor("BSD Object No.", Rec."Sell-to Customer No.", "BSD Contributor Type"::Customer, Rec."Responsibility Center")
                        else
                            Error('');
                end;

                CreateDimFromDefaultDim(Rec.FieldNo("BSD Object No."));
            end;
        }
    }
}