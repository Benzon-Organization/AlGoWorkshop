namespace BoSchData.sisMAN.Base;
using Microsoft.Purchases.Vendor;

tableextension 71458592 "BSD Vendor" extends Vendor
{
    procedure "BSD GetPhoneNo"(): Text[30]
    begin
        if "Phone No." = '' then
            exit("Mobile Phone No.");
        exit("Phone No.");
    end;
}