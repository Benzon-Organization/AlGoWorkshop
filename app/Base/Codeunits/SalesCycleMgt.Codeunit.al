namespace BoSchData.sisMAN.Base;
using Microsoft.CRM.Opportunity;

codeunit 71458575 "BSD Sales Cycle Mgt."
{
    procedure InitObjectSalesCycle()
    var
        SalesCycle: Record "Sales Cycle";
        ObjectLbl: Label 'Object';
    begin
        SalesCycle.Init();
        SalesCycle.Validate(Code, ObjectLbl);
        SalesCycle.Insert();
        SalesCycle.Validate(Description, ObjectLbl);
        SalesCycle.Validate("Probability Calculation", SalesCycle."Probability Calculation"::"Chances of Success %");
        SalesCycle.Validate(Blocked, false);
        SalesCycle.Modify();

        InitObjectSalesCycleStages(SalesCycle);
    end;

    local procedure InitObjectSalesCycleStages(SalesCycle: Record "Sales Cycle")
    var
        SalesCycleStage: Record "Sales Cycle Stage";
        AllocationPhaseLbl: Label 'Allocation Phase';
        QuotePhaseLbl: Label 'Quote Phase';
        OrderPhaseLbl: Label 'Order Phase';
        PlanningPhaseLbl: Label 'Planning Phase';
    begin
        SalesCycleStage.Init();
        SalesCycleStage.Validate("Sales Cycle Code", SalesCycle.Code);
        SalesCycleStage.Validate(Stage, 1);
        SalesCycleStage.Insert();
        SalesCycleStage.Validate(Description, AllocationPhaseLbl);
        SalesCycleStage.Validate("Chances of Success %", 10);
        SalesCycleStage.Modify();

        SalesCycleStage.Init();
        SalesCycleStage.Validate("Sales Cycle Code", SalesCycle.Code);
        SalesCycleStage.Validate(Stage, 2);
        SalesCycleStage.Insert();
        SalesCycleStage.Validate(Description, QuotePhaseLbl);
        SalesCycleStage.Validate("Chances of Success %", 30);
        SalesCycleStage.Modify();

        SalesCycleStage.Init();
        SalesCycleStage.Validate("Sales Cycle Code", SalesCycle.Code);
        SalesCycleStage.Validate(Stage, 3);
        SalesCycleStage.Insert();
        SalesCycleStage.Validate(Description, OrderPhaseLbl);
        SalesCycleStage.Validate("Chances of Success %", 60);
        SalesCycleStage.Modify();

        SalesCycleStage.Init();
        SalesCycleStage.Validate("Sales Cycle Code", SalesCycle.Code);
        SalesCycleStage.Validate(Stage, 4);
        SalesCycleStage.Insert();
        SalesCycleStage.Validate(Description, PlanningPhaseLbl);
        SalesCycleStage.Validate("Chances of Success %", 90);
        SalesCycleStage.Modify();
    end;
}