namespace BoSchData.sisMAN.Base;

table 71458590 "BSD Object Prod. Comment Arch."
{
    Caption = 'Object Product Comment';
    DataClassification = CustomerContent;

    fields
    {
        field(2; "Object No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(5; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(6; Comment; Text[80])
        {
            Caption = 'Comment';
            DataClassification = CustomerContent;
        }
        field(7; "Product Line No."; Integer)
        {
            Caption = 'Product Line No.';
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
        key(Key1; "Object No.", "Product Line No.", "Line No.", "Version No.")
        {
            Clustered = true;
        }
    }
}

