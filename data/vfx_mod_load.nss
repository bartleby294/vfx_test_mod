#include "tile_vfx_map"
#include "bg_uni_tile_vfx"

void MapTheCity(){
    CreateTileForArea("bg4f");
}

void SeedAreaVFX() {
    CreateUnifiedVFXObjectForArea(GetObjectByTag("bg4f"), GetObjectByTag("copy_area"), 1.0, 0.3, 0.0, 0.0, 150.0, 150.0);
}

void main()
{
    NWNX_Util_SetInstructionLimit(2000000000);

    WriteTimestampedLogEntry("[VFX ON MODULE LOAD] Map The City");
    MapTheCity();
    WriteTimestampedLogEntry("[VFX ON MODULE LOAD] Seed Area VFX");
    SeedAreaVFX();

    NWNX_Util_SetInstructionLimit(-1);
}
