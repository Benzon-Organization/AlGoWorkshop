namespace BoSchData.sisMAN.Base;
using Microsoft.Inventory.Intrastat;

table 71458576 "BSD County/District"
{
    DrillDownPageID = "BSD Counties/Districts";
    LookupPageID = "BSD Counties/Districts";

    fields
    {
        field(1; "Area"; Code[10])
        {
            Caption = 'Area';
            DataClassification = CustomerContent;
            TableRelation = "Area";
        }
        field(2; "Area Text"; Text[50])
        {
            Caption = 'Text';
            FieldClass = FlowField;
            CalcFormula = lookup(Area.Text where(Code = field("Area")));
            Editable = false;
        }
        field(3; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Area", Code)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Area", "Area Text", Code, Description)
        {

        }
    }
}