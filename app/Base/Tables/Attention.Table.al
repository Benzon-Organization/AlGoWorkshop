namespace BoSchData.sisMAN.Base;

table 71458577 "BSD Attention"
{
    DrillDownPageID = "BSD Attentions";
    LookupPageID = "BSD Attentions";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
