#include <metal_stdlib>
#include "MetalTypes.metal"
using namespace metal;

vertex RastData vertexShader(const VertexIn vIn [[stage_in]],
                             constant ModelMat &modelMatrix [[buffer(1)]]) {
    RastData rd;
    
    rd.position = modelMatrix.modelMatrix * float4(vIn.position, 1.0);
    //rd.position = float4(vIn.position, 1.0) * modelMatrix.modelMatrix;
    rd.color = vIn.color;
    
    return rd;
}

fragment float4 fragmentShader(RastData rd [[stage_in]]) {
    return rd.color;
}
