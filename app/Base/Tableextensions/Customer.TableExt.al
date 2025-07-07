namespace BoSchData.sisMAN.Base;
using Microsoft.Sales.Customer;

tableextension 71458591 "BSD Customer" extends Customer
{
    procedure "BSD GetPhoneNo"(): Text[30]
    begin
        if "Phone No." = '' then
            exit("Mobile Phone No.");
        exit("Phone No.");
    end;
}