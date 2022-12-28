#include "tile_vfx_map"
#include "bg_uni_tile_vfx"

void MapTheCity(){
    CreateTileForArea("bg4f");
}

void SeedAreaVFX() {
    CreateUnifiedVFXObjectForArea(GetObjectByTag("bg4f"), GetObjectByTag(""), 1.0, -2.0, 0.0, 0.0, 150.0, 150.0);
}

void main()
{
    WriteTimestampedLogEntry("[VFX ON MODULE LOAD] Map The City");
    MapTheCity();
    WriteTimestampedLogEntry("[VFX ON MODULE LOAD] Seed Area VFX");
    SeedAreaVFX();
}
