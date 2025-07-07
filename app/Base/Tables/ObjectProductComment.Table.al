namespace BoSchData.sisMAN.Base;

table 71458583 "BSD Object Product Comment"
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
    }

    keys
    {
        key(Key1; "Object No.", "Product Line No.", "Line No.")
        {
            Clustered = true;
        }
    }

    procedure SetUpNewLine()
    var
        ObjectProductComment: Record "BSD Object Product Comment";
    begin
        ObjectProductComment.SetRange("Object No.", "Object No.");
        ObjectProductComment.SetRange("Product Line No.", "Product Line No.");
        ObjectProductComment.SetRange(Date, WorkDate());
        if ObjectProductComment.IsEmpty() then
            Date := WorkDate();
    end;
}

