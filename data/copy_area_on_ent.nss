#include "nwnx_player"

void SetAreaTileVFX(object oArea, object oPC) {
    object module = GetModule();
    object areaToMirror = GetLocalObject(oArea, "BG_VFX_AREA_OBJECT");

    //iterate over area to mirror
    int areaWidth  = (GetAreaSize(AREA_WIDTH, areaToMirror) * 10);
    int areaHeight  = (GetAreaSize(AREA_HEIGHT, areaToMirror) * 10);

    int curWidth = 5;
    int curHeight = 5;

    while(curWidth < areaWidth) {
        curHeight = 5;
        while(curHeight < areaHeight) {
            // Get our tile ids and models from the full city library.
            int tileID = GetLocalInt(module, "BG_CITY_VFX_ID_" + GetResRef(areaToMirror) + "_" + IntToString(curWidth) + "_" + IntToString(curHeight));
            string tileModel = GetLocalString(module, "BG_CITY_VFX_MODEL_" + GetResRef(areaToMirror) + "_"  + IntToString(curWidth) + "_" + IntToString(curHeight));
            NWNX_Player_SetResManOverride(oPC, 2002, "dummy_tile_" + IntToString(tileID), tileModel);
            WriteTimestampedLogEntry("SetAreaTileVFX - tileID: " + IntToString(tileID) + " tileModel: " + tileModel);
            curHeight = curHeight + 10;
        }
        curWidth = curWidth + 10;
    }
}

void CountEffectsOnObject(object oPC) {

    object invisObj = GetNearestObjectByTag("bg_unified_vfx_object", oPC);
    int i = 1;
    effect curEffect = GetFirstEffect(invisObj);
    while(GetIsEffectValid(curEffect) == TRUE) {
        WriteTimestampedLogEntry("effect count: " + IntToString(i));
        curEffect = GetNextEffect(invisObj);
        i = i + 1;
    }
}

void main() {
    object oArea = GetArea(OBJECT_SELF);
    object oPC = GetEnteringObject();

    SetAreaTileVFX(oArea, oPC);
    CountEffectsOnObject(oPC);
}
