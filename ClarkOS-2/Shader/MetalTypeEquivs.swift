import MetalKit

struct Vertex: Measurable {
    var position: float3
    var color: float4
}

struct ModelMatracies: Measurable {
    var modelMatrix = matrix_identity_float4x4
}
