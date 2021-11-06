#include <metal_stdlib>
#include "MetalTypes.metal"
using namespace metal;

vertex RastData vertexShader(const VertexIn vIn [[stage_in]],
                             constant CameraMats &cameraMats [[buffer(1)]],
                             constant ModelMat &modelMatrix [[buffer(2)]]) {
    RastData rd;
    
    rd.position = cameraMats.projectionMatrix * cameraMats.viewMatrix * modelMatrix.modelMatrix * float4(vIn.position, 1.0);
    //rd.position = float4(vIn.position, 1.0) * modelMatrix.modelMatrix;
    rd.color = vIn.color;
    
    return rd;
}

fragment float4 fragmentShader(RastData rd [[stage_in]]) {
    return rd.color;
}
