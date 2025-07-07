namespace BoSchData.sisMAN.Base;
using Microsoft.Foundation.Address;

tableextension 71458575 "BSD Post Code" extends "Post Code"
{
    fields
    {
        field(71458575; "BSD County"; Code[10])
        {
            Caption = 'County';
            DataClassification = CustomerContent;
            TableRelation = "BSD County/District"."Area";

            trigger OnLookup()
            var
                CountyDistrict: Record "BSD County/District";
            begin
                if Page.RunModal(Page::"BSD Counties/Districts", CountyDistrict) = ACTION::LookupOK then begin
                    "BSD County" := CountyDistrict."Area";
                    "BSD District" := CountyDistrict.Code;
                end;
            end;
        }
        field(71458576; "BSD District"; Code[10])
        {
            Caption = 'District';
            DataClassification = CustomerContent;
            TableRelation = "BSD County/District".Code where("Area" = field("BSD County"));
        }
    }
}