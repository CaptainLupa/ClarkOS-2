#include <metal_stdlib>
#include "MetalTypes.metal"
using namespace metal;

vertex RastData vertexShader(const VertexIn vIn [[stage_in]],
                             constant ModelMatracies &modelSex [[buffer(1)]]) {
    RastData rd;
    
    rd.position = modelSex.modelMatrix * float4(vIn.position, 1.0);
    rd.color = vIn.color;
    
    return rd;
}

fragment float4 fragmentShader(RastData rd [[stage_in]]) {
    return rd.color;
}
