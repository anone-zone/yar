#include "data_types.slang"

[shader("vertex")]
VertexOut vertex(VertexIn input)
{
    VertexOut output;

    output.pos = mul(float4(input.pos, 1.0), MAT_MVP);
    output.color = input.color;

    return output;
}

[shader("pixel")]
PixelOut pixel(VertexOut input)
{
    PixelOut output;

    output.color = float4(input.color, 1.0);

    return output;
}
