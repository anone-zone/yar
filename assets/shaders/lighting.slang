#include "data_types.slang"

float3 BlinnPhong(float3 fragPos, float3 fragNormal, float3 eyePos, float specularity)
{
    float3 viewDir = normalize(eyePos - fragPos);
    float3 halfDir = normalize(ubo.sunDir + viewDir);

    float sunMult = smoothstep(-0.6, 0.1, ubo.sunDir.z);
    float3 sunColor = ubo.sunColor * sunMult;

    float diff = max(dot(fragNormal, ubo.sunDir), 0.0);
    float3 diffuse = diff * sunColor;

    float spec = pow(max(dot(fragNormal, halfDir), 0.0), 16.0);
    float3 specular = specularity * spec * sunColor;

    float3 ambient = float3(0.01);
    float horizonScatter = 1.0 - abs(ubo.sunDir.z);
    ambient += 0.08 * horizonScatter;
    ambient.r *= (1.0 + horizonScatter);

    return ambient + diffuse + specular;
}
