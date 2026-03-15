struct UniformBufferObject
{
    float4x4 model;
    float4x4 view;
    float4x4 proj;
    float4x4 mvp;
    float4x4 invModel;
    float4x4 invView;
    float4x4 invProj;
    float4x4 clipToWorld;
    float3 eye;

    float4 viewport;

    float3 sunDir;
    float3 sunColor;
};

layout(binding = 0) ConstantBuffer<UniformBufferObject> ubo;

#define MAT_MVP mul(ubo.model, mul(ubo.view, ubo.proj))

struct VertexIn {
    float3 pos : POSITION;
    float3 normal : NORMAL;
    float2 uv : TEXCOORD0;
    float3 color;
};

struct VertexOut {
    float4 pos : SV_Position;
    float3 dir;
    float2 uv : TEXCOORD0;
    float3 color;
};

struct PixelOut {
    float4 color : SV_Target0;
};
