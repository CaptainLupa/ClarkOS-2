#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float3 position [[attribute(0)]];
    float4 color [[attribute(1)]];
};

struct RastData {
    float4 position [[position]];
    float4 color;
};

struct ModelMat {
    float4x4 modelMatrix;
};
