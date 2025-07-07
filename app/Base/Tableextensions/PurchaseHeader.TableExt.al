namespace BoSchData.sisMAN.Base;
using Microsoft.Purchases.Document;

tableextension 71458578 "BSD Purchase Header" extends "Purchase Header"
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
                CreateContributorQst: Label 'The Vendor %1 is not part of the contributors of Object %2.\Do you want to add the vendor as contributor?', comment = '%1 = Vendor No., %2 = Object No.';
            begin
                ObjectContributor.SetRange("Object No.", Rec."BSD Object No.");
                ObjectContributor.SetRange("Contributor Type", "BSD Contributor Type"::Vendor);
                ObjectContributor.SetRange("No.", Rec."Buy-from Vendor No.");
                ObjectContributor.SetRange("Responsibility Center", Rec."Responsibility Center");
                if ObjectContributor.IsEmpty() then
                    if Confirm(StrSubstNo(CreateContributorQst, Rec."Buy-from Vendor No.", Rec."BSD Object No.")) then
                        ObjectContributor.AddCustVendAsContributor("BSD Object No.", Rec."Buy-from Vendor No.", "BSD Contributor Type"::Vendor, Rec."Responsibility Center")
                    else
                        Error('');
            end;
        }
    }
}