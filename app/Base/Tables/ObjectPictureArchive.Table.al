namespace BoSchData.sisMAN.Base;

table 71458589 "BSD Object Picture Archive"
{
    DrillDownPageID = "BSD Object Pictures Archive";
    LookupPageID = "BSD Object Pictures Archive";
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
        field(999; "Version No."; Integer)
        {
            Caption = 'Version No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Object No.", "Entry No.", "Version No.")
        {
            Clustered = true;
        }
    }
}