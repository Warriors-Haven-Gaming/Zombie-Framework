with uiNamespace do {
    private _display = findDisplay 46 createDisplay "RscDisplayEmpty";
    private _frame = _display ctrlCreate ["RscText", -1];
    _frame ctrlSetPosition [safezoneX + 0.38 * safezoneW, safezoneY + 0.2 * safezoneH, 0.24 * safezoneW, 0.6 * safezoneH];
    _frame ctrlSetBackgroundColor [0, 0, 0, 0.7];
    _frame ctrlEnable false;
    _frame ctrlCommit 0;

    private _title = _display ctrlCreate ["RscStructuredText", -1];
    _title ctrlSetPosition [safezoneX + 0.4 * safezoneW, safezoneY + 0.25 * safezoneH, 0.2 * safezoneW, 0.02 * safezoneH];
    _title ctrlSetStructuredText parseText format ["<t align='center'>%1</t>", localize "$STR_SHZ_welcomeTitle"];
    _title ctrlEnable false;
    _title ctrlCommit 0;

    private _image = _display ctrlCreate ["RscPicture", -1];
    _image ctrlSetPosition [safezoneX + 0.4 * safezoneW, safezoneY + 0.28 * safezoneH, 0.2 * safezoneW, 0.2 * safezoneH];
    _image ctrlSetText "splash.jpg";
    _image ctrlEnable false;
    _image ctrlCommit 0;

    private _description = _display ctrlCreate ["RscStructuredText", -1];
    _description ctrlSetPosition [safezoneX + 0.4 * safezoneW, safezoneY + 0.5 * safezoneH, 0.2 * safezoneW, 0.1 * safezoneH];
    _description ctrlSetStructuredText parseText format ["<t align='center' valign='center'>%1</t>", localize "$STR_SHZ_welcomeDescription"];
    _description ctrlEnable false;
    _description ctrlCommit 0;

    private _gettingStarted = _display ctrlCreate ["RscButton", -1];
    _gettingStarted ctrlSetPosition [safezoneX + 0.4 * safezoneW, safezoneY + 0.68 * safezoneH, 0.06 * safezoneW, 0.04 * safezoneH];
    _gettingStarted ctrlSetText localize "$STR_SHZ_addRecordGuide_subject";
    _gettingStarted ctrlCommit 0;

    private _credits = _display ctrlCreate ["RscButton", -1];
    _credits ctrlSetPosition [safezoneX + 0.47 * safezoneW, safezoneY + 0.68 * safezoneH, 0.06 * safezoneW, 0.04 * safezoneH];
    _credits ctrlSetText localize "$STR_DISP_MAIN_CREDITS";
    _credits ctrlCommit 0;

    private _discordButton = _display ctrlCreate ["RscButton", -1];
    _discordButton ctrlSetPosition [safezoneX + 0.54 * safezoneW, safezoneY + 0.68 * safezoneH, 0.06 * safezoneW, 0.04 * safezoneH];
    _discordButton ctrlEnable false;
    _discordButton ctrlCommit 0;

    private _discordLink = _display ctrlCreate ["RscStructuredText", -1];
    _discordLink ctrlSetPosition [safezoneX + 0.54 * safezoneW, safezoneY + 0.688 * safezoneH, 0.06 * safezoneW, 0.04 * safezoneH];
    _discordLink ctrlSetStructuredText parseText format ["<a align='center' href='%1'>Discord</a>", localize "$STR_SHZ_link_discord"];
    _discordLink ctrlCommit 0;

    private _close = _display ctrlCreate ["RscButton", 2];
    _close ctrlSetPosition [safezoneX + 0.54 * safezoneW, safezoneY + 0.74 * safezoneH, 0.06 * safezoneW, 0.04 * safezoneH];
    _close ctrlSetText localize "$STR_DISP_CLOSE";
    _close ctrlCommit 0;

    _gettingStarted ctrlAddEventHandler ["ButtonClick", {
        openMap true;
        processDiaryLink "<log subject='SHZ_fnc_addRecordGuide'></log>";
    }];

    _credits ctrlAddEventHandler ["ButtonClick", {
        openMap true;
        processDiaryLink "<log subject='SHZ_fnc_addRecordCredits'></log>";
    }];
};
