namespace BoSchData.sisMAN.Base;

using Microsoft.CRM.Contact;
using Microsoft.CRM.Setup;
using Microsoft.Foundation.NoSeries;
using Microsoft.CRM.BusinessRelation;

codeunit 71458576 "BSD ObjCont-Update"
{
    Permissions = tabledata Contact = rimd;

    var
        MarketingSetup: Record "Marketing Setup";

    procedure OnInsert(var Object: Record "BSD Object")
    begin
        MarketingSetup.Get();
        if MarketingSetup."BSD Bus. Rel. Code Objects" = '' then
            exit;

        InsertNewContact(Object);
    end;

    procedure OnModify(var Object: Record "BSD Object")
    var
        ContactBusinessRelation: Record "Contact Business Relation";
        Contact: Record Contact;
        OldContact: Record Contact;
        ContactNo: Code[20];
        NoSeries: Code[20];
    begin
        ContactBusinessRelation.SetCurrentKey("Link to Table", "No.");
        ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."Link to Table"::"BSD Object");
        ContactBusinessRelation.SetRange("No.", Object."No.");
        if not ContactBusinessRelation.FindFirst() then
            exit;
        if not Contact.Get(ContactBusinessRelation."Contact No.") then begin
            ContactBusinessRelation.Delete();
            exit;
        end;

        OldContact := Contact;

        ContactNo := Contact."No.";
        NoSeries := Contact."No. Series";

        Contact.TransferFields(Object);
        Contact."No." := ContactNo;
        Contact."No. Series" := NoSeries;

        Contact.Type := OldContact.Type;
        Contact.Validate(Name);
        Contact.DoModify(OldContact);
        Contact.Modify(true);

        Object.Get(Object."No.");
    end;

    procedure OnDelete(var Object: Record "BSD Object")
    var
        ContactBusinessRelation: Record "Contact Business Relation";
    begin
        ContactBusinessRelation.SetCurrentKey("Link to Table", "No.");
        ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."Link to Table"::"BSD Object");
        ContactBusinessRelation.SetRange("No.", Object."No.");
        ContactBusinessRelation.DeleteAll(true);
    end;

    procedure InsertNewContact(var Object: Record "BSD Object")
    var
        ContactBusinessRelation: Record "Contact Business Relation";
        Contact: Record Contact;
        ObjectRespCenterRel: Record "BSD Object Resp. Center Rel.";
        NoSeries: Codeunit "No. Series";
    begin
        Contact.Init();
        Contact.TransferFields(Object);
        Contact.Validate(Contact.Name);

        Contact."No." := '';
        Contact."No. Series" := '';
        MarketingSetup.Get();
        MarketingSetup.TestField("Contact Nos.");

        Contact."No. Series" := MarketingSetup."Contact Nos.";
        Contact."No." := NoSeries.GetNextNo(Contact."No. Series");

        Contact.Type := Contact.Type::Company;
        Contact.SetSkipDefault();
        Contact.Insert(true);

        ContactBusinessRelation.Init();
        ContactBusinessRelation."Contact No." := Contact."No.";
        ContactBusinessRelation."Business Relation Code" := MarketingSetup."BSD Bus. Rel. Code Objects";
        ContactBusinessRelation."Link to Table" := ContactBusinessRelation."Link to Table"::"BSD Object";
        ContactBusinessRelation."No." := Object."No.";
        ContactBusinessRelation.Insert(true);

        ObjectRespCenterRel.SetRange("Object No.", Object."No.");
        ObjectRespCenterRel.ModifyAll("Contact No.", Contact."No.");
    end;
}

