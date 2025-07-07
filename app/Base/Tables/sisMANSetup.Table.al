namespace BoSchData.sisMAN.Base;
using Microsoft.Foundation.NoSeries;
using System.Diagnostics;
using Microsoft.Finance.Dimension;

table 71458575 "BSD sisMAN Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "Use Sales Opportunity"; Boolean)
        {
            Caption = 'Use Sales Opportunity';
            DataClassification = CustomerContent;
        }
        field(3; "Resubmission date formula"; DateFormula)
        {
            Caption = 'Resubmission date formula';
            DataClassification = CustomerContent;
        }
        field(4; "Object Nos."; Code[20])
        {
            Caption = 'Object Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(5; "Archive Objects"; Enum "BSD Archive Objects")
        {
            Caption = 'Archive Objects';
            DataClassification = CustomerContent;
        }
        field(6; "Activate Changelog"; Boolean)
        {
            Caption = 'Activate Changelog';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ChangeLogSetup: Record "Change Log Setup";
                ChangeLogSetupTable: Record "Change Log Setup (Table)";
                ChangeLogSetupField: Record "Change Log Setup (Field)";
                Object: Record "BSD Object";
                ChangeLogNotActiveErr: Label 'The change log needs to be activated globally first. Please go to the change log setup and activate first.';
            begin
                ChangeLogSetup.Get();
                if not ChangeLogSetup."Change Log Activated" then
                    Error(ChangeLogNotActiveErr);

                if "Activate Changelog" then begin
                    if not ChangeLogSetupTable.Get(Database::"BSD Object") then begin
                        ChangeLogSetupTable.Init();
                        ChangeLogSetupTable."Table No." := Database::"BSD Object";
                        ChangeLogSetupTable.Insert();
                    end;

                    ChangeLogSetupTable.Validate("Log Insertion", ChangeLogSetupTable."Log Insertion"::"Some Fields");
                    ChangeLogSetupTable.Validate("Log Modification", ChangeLogSetupTable."Log Modification"::"All Fields");
                    ChangeLogSetupTable.Validate("Log Deletion", ChangeLogSetupTable."Log Deletion"::"Some Fields");
                    ChangeLogSetupTable.Modify(true);


                    if not ChangeLogSetupField.Get(Database::"BSD Object", Object.FieldNo("No.")) then begin
                        ChangeLogSetupField.Init();
                        ChangeLogSetupField."Table No." := Database::"BSD Object";
                        ChangeLogSetupField."Field No." := Object.FieldNo("No.");
                        ChangeLogSetupField.Insert();
                    end;

                    ChangeLogSetupField.Validate("Log Insertion", true);
                    ChangeLogSetupField.Validate("Log Deletion", true);
                    ChangeLogSetupField.Modify(true);
                end
                else begin
                    if ChangeLogSetupTable.Get(Database::"BSD Object") then
                        ChangeLogSetupTable.Delete(true);

                    ChangeLogSetupField.SetRange("Table No.", Database::"BSD Object");
                    if ChangeLogSetupField.FindSet() then
                        ChangeLogSetupField.DeleteAll();
                end;
            end;
        }
        field(7; "Object Type Dimension"; Code[20])
        {
            Caption = 'Object Type Dimension';
            DataClassification = CustomerContent;
            TableRelation = Dimension;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
}