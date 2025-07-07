namespace BoSchData.sisMAN.Base;

codeunit 71458578 "BSD On Install Extension"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany();
    var
        ModuleInf: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(ModuleInf); // Get info about the currently executing module

        if ModuleInf.DataVersion() = Version.Create(0, 0, 0, 0) then // A 'DataVersion' of 0.0.0.0 indicates a 'fresh/new' install
            HandleFreshInstall()
        else
            HandleReinstall(); // If not a fresh install, then we are Re-installing the same version of the extension
    end;

    /// <summary>
    /// HandleFreshInstall.
    /// </summary>
    local procedure HandleFreshInstall();
    var
        SalesCycleMgt: Codeunit "BSD Sales Cycle Mgt.";
    begin
        // Do work needed the first time this extension is ever installed for this tenant.
        // Some possible usages:
        // - Service callback/telemetry indicating that extension was install
        // - Initial data setup for use

        SalesCycleMgt.InitObjectSalesCycle();
    end;

    /// <summary>
    /// HandleReinstall.
    /// </summary>
    local procedure HandleReinstall();
    begin
        // Do work needed when reinstalling the same version of this extension back on this tenant.
        // Some possible usages:
        // - Service callback/telemetry indicating that extension was reinstalled
        // - Data 'patchup' work, for example, detecting if new 'base' records have been changed while you have been working 'offline'.
        // - Setup 'welcome back' messaging for next user access.
    end;
}