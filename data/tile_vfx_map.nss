#include "es_s_areacreator"
#include "es_srv_tiles"
#include "bg_city_map_util"
#include "nwnx_area"
#include "nwnx_tileset"
#include "nwnx_player"
#include "nwnx_visibility"

void SaveTileVFX(float scale,
    struct NWNX_Area_TileInfo tile, object oArea, int objectX, int objectY,
    int curWidth, int curHeight)
{
    //object oArea = GetObjectByTag("m11");
    float fTileX = 2.0;
    float fTileY = 2.0;

    int nTileID = tile.nID;

    string tilesetRefRef = GetTilesetResRef(oArea);
    string tileModel = Tiles_GetTileModel(tilesetRefRef, nTileID);

    float fOrientation;
    int nTileOrientation = tile.nOrientation;
    switch (nTileOrientation)
    {
        case 0: fOrientation = 90.0f; break;
        case 1: fOrientation = 180.0f; break;
        case 2: fOrientation = 270.0f; break;
        case 3: fOrientation = 0.0f; break;
    }

    vector vRotate = Vector(fOrientation, 0.0f, 0.0f);

    float fHeight = 0.1;
    vector vTranslate = Vector(0.0, 0.0, 0.0);

    object module = GetModule();
    SetLocalInt(module, "BG_CITY_VFX_ID_" + IntToString(objectX) + "_" + IntToString(objectY), nTileID);
    //WriteTimestampedLogEntry("nTileID: " + IntToString(nTileID));
    SetLocalInt(module, "BG_CITY_VFX_HEIGHT_" + IntToString(objectX) + "_" + IntToString(objectY), tile.nHeight);
    SetLocalFloat(module, "BG_CITY_VFX_SCALE_" + IntToString(objectX) + "_" + IntToString(objectY), scale);
    SetLocalVector(module, "BG_CITY_VFX_TRANSLATE_" + IntToString(objectX) + "_" + IntToString(objectY), vTranslate);
    SetLocalVector(module, "BG_CITY_VFX_ROTATE_" + IntToString(objectX) + "_" + IntToString(objectY), vRotate);
    SetLocalString(module, "BG_CITY_VFX_MODEL_" + IntToString(objectX) + "_" + IntToString(objectY), tileModel);

    SetLocalInt(module, "BG_CITY_VFX_ID_" + GetResRef(oArea) + "_" + IntToString(curWidth) + "_" + IntToString(curHeight), nTileID);
    SetLocalInt(module, "BG_CITY_VFX_HEIGHT_" + GetResRef(oArea) + "_" + IntToString(curWidth) + "_" + IntToString(curHeight), tile.nHeight);
    SetLocalFloat(module, "BG_CITY_VFX_SCALE_" + GetResRef(oArea) + "_"  + IntToString(curWidth) + "_" + IntToString(curHeight), scale);
    SetLocalVector(module, "BG_CITY_VFX_TRANSLATE_" + GetResRef(oArea) + "_" + IntToString(curWidth) + "_" + IntToString(curHeight), vTranslate);
    SetLocalVector(module, "BG_CITY_VFX_ROTATE_" + GetResRef(oArea) + "_"  + IntToString(curWidth) + "_" + IntToString(curHeight), vRotate);
    SetLocalString(module, "BG_CITY_VFX_MODEL_" + GetResRef(oArea) + "_"  + IntToString(curWidth) + "_" + IntToString(curHeight), tileModel);
}

void MirrorExistingAreaVFXToScale(object areaToMirror, int startX, int startY,
                                  float scale) {

    //iterate over area to mirror
    int width  = (GetAreaSize(AREA_WIDTH,  areaToMirror) * 10);
    int height  = (GetAreaSize(AREA_HEIGHT,  areaToMirror) * 10);

    //SendMessageToPC(oPlayer, "in bg_tile_vfx_mirr: cur area: " + GetName(curArea));

    int curWidth = 5;
    int curHeight = 5;
    int tileWidth = 0;

    int objectX = startX;
    int objectY = startY;

    while(curWidth < width) {
        curHeight = 5;
        int tileHeight = 0;
        objectY = startY;
        while(curHeight < height) {

            /* Get Tile */
            float curWidthFloat = IntToFloat(curWidth);
            float curHeightFloat = IntToFloat(curHeight);
            struct NWNX_Area_TileInfo tile = NWNX_Area_GetTileInfo(areaToMirror, curWidthFloat, curHeightFloat);

            /* Save off Tile Info */
            SaveTileVFX(scale, tile, areaToMirror, objectX, objectY, curWidth, curHeight);

            /* Iterate y for next */
            curHeight = curHeight + 10;
            tileHeight = tileHeight + 1;
            objectY = objectY + 1;
        }
        /* Iterate x for next */
        curWidth = curWidth + 10;
        tileWidth = tileWidth + 1;
        objectX = objectX + 1;
    }
}

void CreateTileForArea(string area) {
    object oArea = GetObjectByTag(area);
    if(oArea == OBJECT_INVALID) {
        return;
    }

    string areaX = GetStringRight(area, 1);
    string areaY = GetStringLeft(GetStringRight(area, 2), 1);
    int ew = areaEWMapValue(areaX);
    int ns = areaNSMapValue(areaY);
    //WriteTimestampedLogEntry("EW: " + IntToString(ew));
    //WriteTimestampedLogEntry("NS: " + IntToString(ns));

    int x = ((ew - 1) * 30) + 1;
    int y = 300 - ((ns - 1) * 30) - 31;

    //WriteTimestampedLogEntry("Start X: " + IntToString(x));
    //WriteTimestampedLogEntry("Start Y: " + IntToString(y));

    MirrorExistingAreaVFXToScale(oArea, x, y, 0.1);
}



