namespace BoSchData.sisMAN.Base;
using Microsoft.CRM.Task;

pageextension 71458606 "BSD Task Card" extends "Task Card"
{
    layout
    {
        addlast(General)
        {
            field("BSD Responsibility Center"; Rec."BSD Responsibility Center")
            {
                ApplicationArea = All;
            }
        }
    }
}