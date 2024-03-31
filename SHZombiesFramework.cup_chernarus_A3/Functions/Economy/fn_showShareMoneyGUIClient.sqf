/*
Function: SHZ_fnc_showShareMoneyGUIClient

Description:
    Shows a GUI for sharing money to the given player.
    Function must be remote executed on client from the server.

Parameters:
    Object target:
        The player to share money to.
    Number current:
        The amount of money available to the player.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};

params ["_target", "_current"];
if (getPlayerUID _target isEqualTo "") exitWith {};

uiNamespace setVariable ["SHZ_shareMoneyGUI_target", _target];
uiNamespace setVariable ["SHZ_shareMoneyGUI_current", _current];
uiNamespace setVariable ["SHZ_shareMoneyGUI_amounts", [250, 500, 1000, 2500, 5000, 10000]];
with uiNamespace do {
    createDialog "RscDisplayEmpty";
    private _display = findDisplay -1;

    private _fnc_formatMoney = (missionNamespace getVariable "SHZ_fnc_formatMoney");

    private _frame = _display ctrlCreate ["RscText", -1];
    _frame ctrlSetPosition [safezoneX + 0.4 * safezoneW, safezoneY + 0.45 * safezoneH, 0.2 * safezoneW, 0.11 * safezoneH];
    _frame ctrlSetBackgroundColor [0, 0, 0, 0.7];
    _frame ctrlEnable false;
    _frame ctrlCommit 0;

    private _title = _display ctrlCreate ["RscStructuredText", -1];
    _title ctrlSetPosition [safezoneX + 0.41 * safezoneW, safezoneY + 0.46 * safezoneH, 0.18 * safezoneW, 0.02 * safezoneH];
    _title ctrlSetStructuredText parseText format [
        "<t align='left'>%1</t><t align='right'>%2</t>",
        SHZ_shareMoneyGUI_current call _fnc_formatMoney,
        name SHZ_shareMoneyGUI_target
    ];
    _title ctrlEnable false;
    _title ctrlCommit 0;

    private _amount = _display ctrlCreate ["RscShareMoneyToolbox", 100];
    _amount ctrlSetPosition [safezoneX + 0.41 * safezoneW, safezoneY + 0.485 * safezoneH, 0.18 * safezoneW, 0.03 * safezoneH];
    lbClear _amount;
    {_amount lbAdd (_x call _fnc_formatMoney)} forEach SHZ_shareMoneyGUI_amounts;
    _amount ctrlCommit 0;

    private _confirm = _display ctrlCreate ["RscButton", 1];
    _confirm ctrlSetPosition [safezoneX + 0.505 * safezoneW, safezoneY + 0.52 * safezoneH, 0.04 * safezoneW, 0.03 * safezoneH];
    _confirm ctrlSetText localize "$STR_SHZ_showShareMoneyGUI_confirm";
    _confirm ctrlEnable (
        SHZ_shareMoneyGUI_amounts # lbCurSel _amount
        <= SHZ_shareMoneyGUI_current
    );
    _confirm ctrlCommit 0;

    private _cancel = _display ctrlCreate ["RscButton", 2];
    _cancel ctrlSetPosition [safezoneX + 0.55 * safezoneW, safezoneY + 0.52 * safezoneH, 0.04 * safezoneW, 0.03 * safezoneH];
    _cancel ctrlSetText localize "$STR_DISP_CANCEL";
    _cancel ctrlCommit 0;

    _amount ctrlAddEventHandler ["ToolBoxSelChanged", {with uiNamespace do {
        params ["", "_selectedIndex"];
        private _money = SHZ_shareMoneyGUI_amounts # _selectedIndex;
        private _confirm = displayCtrl 1;
        _confirm ctrlEnable (_money <= SHZ_shareMoneyGUI_current);
        _confirm ctrlCommit 0;
    }}];

    _display displayAddEventHandler ["Unload", {with uiNamespace do {
        params ["", "_exitCode"];
        if (_exitCode isNotEqualTo 1) exitWith {};
        private _money = SHZ_shareMoneyGUI_amounts # lbCurSel displayCtrl 100;
        [player, SHZ_shareMoneyGUI_target, _money] remoteExec ["SHZ_fnc_shareMoney", 2];
    }}];
};
