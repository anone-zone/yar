#include "data_types.slang"

float4 FragClipPos(float4 pos)
{
    float4 ndc;
    ndc.xy = (2.0 * pos.xy / ubo.viewport.xy) - 1.0;
    ndc.z = (2.0 * pos.z) - 1.0;
    ndc.w = 1.0;
    float4 clip = ndc / pos.w;
    return clip;
}

float3 FragWorldPos(float4 pos)
{
    return mul(FragClipPos(pos), ubo.clipToWorld).xyz;
}
