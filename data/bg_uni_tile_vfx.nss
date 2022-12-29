#include "es_s_areacreator"
#include "es_srv_tiles"
#include "nwnx_area"
#include "nwnx_tileset"
#include "nwnx_player"

void CreateUnifiedVFXObjectForArea(object areaToMirror, object areaToSeed,
                                   float scale, float heightOffset,
                                   float xOffset, float yOffset,
                                   float unifiedObjX, float unifiedObjY) {

    if(areaToMirror == OBJECT_INVALID) {
        WriteTimestampedLogEntry("[CreateAreaVFXObjects] Aborted areaToMirror invalid.");
        return;
    }

    if(areaToSeed == OBJECT_INVALID) {
        WriteTimestampedLogEntry("[CreateAreaVFXObjects] Aborted areaToSeed invalid.");
        return;
    }

    //iterate over area to mirror
    int areaWidth  = (GetAreaSize(AREA_WIDTH, areaToSeed) * 10);
    int areaHeight  = (GetAreaSize(AREA_HEIGHT, areaToSeed) * 10);

    int curWidth = 5;
    int curHeight = 5;

    object module = GetModule();
    location unifiedVFXTileLocation = Location(areaToSeed, Vector(unifiedObjX, unifiedObjY, 0.3), 0.0);
    object singleObject = CreateObject(OBJECT_TYPE_PLACEABLE, "vfx_invis_object", unifiedVFXTileLocation, FALSE, "bg_unified_vfx_object");
    SetLocalObject(areaToSeed, "BG_VFX_AREA_OBJECT", areaToMirror);

    SetName(singleObject, "INVISIBLE VFX OBJECT");
    NWNX_Visibility_SetVisibilityOverride(OBJECT_INVALID, singleObject, NWNX_VISIBILITY_ALWAYS_VISIBLE);

    int i = 1;
    while(curWidth < areaWidth) {
        curHeight = 5;
        while(curHeight < areaHeight) {
            float curWidthFloat = IntToFloat(curWidth) + xOffset - unifiedObjX;
            float curHeightFloat = IntToFloat(curHeight) + yOffset - unifiedObjY;
            WriteTimestampedLogEntry("[Init VFX Area] mirror area:" + GetName(areaToMirror) + " current area:" + GetName(areaToSeed)
                                      + "(" + FloatToString(unifiedObjX, 5, 2) + ", " + FloatToString(unifiedObjY, 5, 2) + ")("
                                            + FloatToString(curWidthFloat, 5, 2) + ", " + FloatToString(curHeightFloat, 5, 2) + ")");

            // Get our tile ids and models from the full city library.
            int tileID = GetLocalInt(module, "BG_CITY_VFX_ID_" + GetResRef(areaToMirror) + "_" + IntToString(curWidth) + "_" + IntToString(curHeight));
            vector vRotate = GetLocalVector(module, "BG_CITY_VFX_ROTATE_" + GetResRef(areaToMirror) + "_"  + IntToString(curWidth) + "_" + IntToString(curHeight));
            string tileModel = GetLocalString(module, "BG_CITY_VFX_MODEL_" + GetResRef(areaToMirror) + "_"  + IntToString(curWidth) + "_" + IntToString(curHeight));
            WriteTimestampedLogEntry("tileID: " + IntToString(tileID) + " tileModel: " + tileModel);

            vector vRotate2 = Vector(vRotate.x + 270, 0.0f, 0.0f);

            //vTranslate = Vector(curWidthf, curHeightf, IntToFloat(0));
            //vector vTranslate = Vector(IntToFloat(0), IntToFloat(0), IntToFloat(0));
            vector vTranslate = Vector(curWidthFloat, curHeightFloat, 0.5);

            effect eTile = EffectVisualEffect(AREACREATOR_VISUALEFFECT_START_ROW + tileID, FALSE, scale, vTranslate, vRotate2);
            eTile = TagEffect(eTile, "TILE_EFFECT_" + IntToString(curWidth) + "_" + IntToString(curHeight));

            // Dynamic delay apply
            //DelayCommand(1.0 + (0.3 * i), ApplyEffectToObject(DURATION_TYPE_PERMANENT, eTile, singleObject));
            // Constant delay apply
            //DelayCommand(AREACREATOR_TILE_EFFECT_APPLY_DELAY, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eTile, singleObject));
            // Instant apply
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eTile, singleObject);

            curHeight = curHeight + 10;
            i = i + 1;
        }
        curWidth = curWidth + 10;
    }
}

