import MetalKit

struct Vertex: Measurable {
    var position: float3
    var color: float4
    // TODO: Texture
}

struct ModelMat: Measurable {
    var modelMatrix = matrix_identity_float4x4
}

struct CameraMats: Measurable {
    var viewMatrix = matrix_identity_float4x4
    var projectionMatrix = float4x4.prespective(degreesFov: 90,
                                                aspectRatio: Renderer.aspectRatio,
                                                near: 0.1,
                                                far: 1000)
}
