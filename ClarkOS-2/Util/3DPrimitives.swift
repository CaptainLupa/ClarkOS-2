import MetalKit

class Cube: Polygon, ClarkDrawable {
    var verts: [Vertex] = []
    var vertexBuffer: MTLBuffer!
    var indexBuffer: MTLBuffer!
    var indices: [UInt32] = [
        0, 1, 2, // First quad
        2, 1, 3,
        
        3, 4, 2, // right
        2, 5, 4,
        
        4, 6, 5, // back
        6, 5, 7,
        
        0, 1, 6, // left
        6, 1, 7,
        
        0, 3, 4, // top
        0, 4, 6,
        
        1, 2, 5, // bottom
        1, 5, 7
    ]
    
    init() {
        makeVerts()
        makeBuffers()
    }
    
    func makeBuffers() {
        vertexBuffer = Nicotine.Device.makeBuffer(bytes: verts, length: Vertex.stride(verts.count), options: [])
        indexBuffer = Nicotine.Device.makeBuffer(bytes: indices, length: UInt32.stride(indices.count), options: [])
    }
    
    func makeVerts() {
        verts = [
            // Front
            Vertex(position: float3(-0.5,  0.5,  0.5), color: float4(1, 0, 0, 1)), // 0
            Vertex(position: float3(-0.5, -0.5,  0.5), color: float4(0, 1, 0, 1)), // 1
            Vertex(position: float3( 0.5, -0.5,  0.5), color: float4(0, 0, 1, 1)), // 2
            Vertex(position: float3( 0.5,  0.5,  0.5), color: float4(1, 1, 0, 1)), // 3, top right
            // Right, uses 3 as its start
            Vertex(position: float3( 0.5,  0.5, -0.5), color: float4(0, 1, 0, 1)), // 4
            Vertex(position: float3( 0.5, -0.5, -0.5), color: float4(0, 0, 1, 1)), // 5
            // Back, uses 4 as start
            Vertex(position: float3(-0.5,  0.5, -0.5), color: float4(1, 0, 1, 1)), //6
            Vertex(position: float3(-0.5, -0.5, -0.5), color: float4(0, 1, 0, 1))  //7
            // Dont need any for the rest, these verts are enough
        ]
    }
    
    func render(_ rce: MTLRenderCommandEncoder) {
        rce.setRenderPipelineState(Metal.PipeStateLib[.Basic])
        
        rce.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        rce.drawIndexedPrimitives(type: .triangle,
                                  indexCount: indices.count,
                                  indexType: .uint32,
                                  indexBuffer: indexBuffer,
                                  indexBufferOffset: 0)
    }
}
