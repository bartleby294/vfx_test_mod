int ValidEW(string alpha) {
    if(alpha == "a") {
        return TRUE;
    }
    if(alpha == "b") {
        return TRUE;
    }
    if(alpha == "c") {
        return TRUE;
    }
    if(alpha == "d") {
        return TRUE;
    }
    if(alpha == "e") {
        return TRUE;
    }
    if(alpha == "f") {
        return TRUE;
    }
    if(alpha == "g") {
        return TRUE;
    }
    if(alpha == "h") {
        return TRUE;
    }
    return FALSE;
}

int ValidNS(string alpha) {
    if(alpha == "0") {
        return TRUE;
    }
    if(alpha == "1") {
        return TRUE;
    }
    if(alpha == "2") {
        return TRUE;
    }
    if(alpha == "3") {
        return TRUE;
    }
    if(alpha == "4") {
        return TRUE;
    }
    if(alpha == "5") {
        return TRUE;
    }
    if(alpha == "6") {
        return TRUE;
    }
    if(alpha == "7") {
        return TRUE;
    }
    return FALSE;
}

int areaEWMapValue(string alpha) {
    if(alpha == "a") {
        return 0;
    }
    if(alpha == "b") {
        return 1;
    }
    if(alpha == "c") {
        return 2;
    }
    if(alpha == "d") {
        return 3;
    }
    if(alpha == "e") {
        return 4;
    }
    if(alpha == "f") {
        return 5;
    }
    if(alpha == "g") {
        return 6;
    }
    if(alpha == "h") {
        return 7;
    }
    return -1;
}

int areaNSMapValue(string alpha) {
    if(alpha == "0") {
        return 0;
    }
    if(alpha == "1") {
        return 1;
    }
    if(alpha == "2") {
        return 2;
    }
    if(alpha == "3") {
        return 3;
    }
    if(alpha == "4") {
        return 4;
    }
    if(alpha == "5") {
        return 5;
    }
    if(alpha == "6") {
        return 6;
    }
    if(alpha == "7") {
        return 7;
    }
    return -1;
}

int CheckInCity(object oPC) {
    object oArea = GetArea(oPC);
    string sAreaTag = GetTag(oArea);

    if(GetStringLength(sAreaTag) != 4) {
        return FALSE;
    }

    string oAreaTagLeft = GetStringLeft(sAreaTag, 2);
    if(oAreaTagLeft != "bg") {
        return FALSE;
    }

    string oAreaTagRight = GetStringRight(sAreaTag, 2);
    if(ValidEW(GetStringRight(oAreaTagRight, 1)) == FALSE) {
        return FALSE;
    }

    if(ValidNS(GetStringLeft(oAreaTagRight, 1)) == FALSE) {
        return FALSE;
    }
    return TRUE;
}

void StartBGCityMapDialog(object oPC, object map) {

    if(CheckInCity(oPC) == FALSE) {
        SendMessageToPC(oPC, "I should be in the city if I want to use the map.");
        return;
    }

    SetLocalObject(oPC, "current_map", map);
    AssignCommand(oPC, ActionStartConversation(oPC, "bg_map_convo_1", TRUE, FALSE));
}

