#include "data_types.slang"

[shader("vertex")]
VertexOut vertex(VertexIn input)
{
    VertexOut output;

    output.pos = mul(float4(input.pos, 1.0), ubo.proj);
    output.dir = normalize((mul(float4(input.pos, 1.0), transpose(ubo.view))).xyz);

    return output;
}

[shader("pixel")]
PixelOut pixel(VertexOut input)
{
    PixelOut output;

    float sunDot = dot(input.dir, ubo.sunDir);

    float3 darkColor = float3(0.05, 0.05, 0.05);
    float3 baseColor = float3(0.1, 0.2, 0.7);
    float3 brightColor = float3(1.0, 1.0, 1.0);

    float dayAmount = 0.01 + smoothstep(-1.0, 1.0, ubo.sunDir.z);
    darkColor.rgb *= dayAmount;
    baseColor.rgb *= dayAmount;
    brightColor.rgb *= dayAmount;

    float horizonAmount = 3.0 * smoothstep(0.9, -0.4, ubo.sunDir.z);
    float3 horizonColor = 1.0 + float3(horizonAmount, 0.0, -0.4 * horizonAmount);
    darkColor.rgb *= horizonColor;
    baseColor.rgb *= horizonColor;
    brightColor.rgb *= horizonColor;

    float darkMix = smoothstep(0.0, -1.0, sunDot);

    float brightMix = sign(sunDot) * pow(sunDot, 4);
    brightMix = smoothstep(0.0, 1.0, brightMix);

    float3 gradient = lerp(baseColor, darkColor, darkMix)
            + lerp(baseColor, brightColor, brightMix);

    output.color = float4(gradient, 1.0);

    return output;
}
