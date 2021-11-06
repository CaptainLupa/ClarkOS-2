import MetalKit

protocol ClarkDrawable {
    func render(_ rce: MTLRenderCommandEncoder)
}

protocol Polygon {
    var verts: [Vertex] { get }
    var vertexBuffer: MTLBuffer! { get }
    func makeBuffers()
    func makeVerts()
}

class Quad: Polygon, ClarkDrawable {
    var verts: [Vertex] = []
    var indices: [UInt32] = [0, 1, 2,
                             0, 3, 2]
    
    var vertexBuffer: MTLBuffer!
    var indicesBuffer: MTLBuffer!
    
    init() {
        makeVerts()
        
        makeBuffers()
    }
    
    func render(_ rce: MTLRenderCommandEncoder) {
        rce.setRenderPipelineState(Metal.PipeStateLib[.Basic])
        
        rce.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        rce.drawIndexedPrimitives(type: .triangle,
                                  indexCount: indices.count,
                                  indexType: .uint32,
                                  indexBuffer: indicesBuffer,
                                  indexBufferOffset: 0)
    }
    
    func makeBuffers() {
        vertexBuffer = Nicotine.Device.makeBuffer(bytes: &verts, length: Vertex.stride(verts.count), options: [])
        indicesBuffer = Nicotine.Device.makeBuffer(bytes: &indices, length: UInt32.stride(indices.count), options: [])
    }
    
    func makeVerts() {
        verts = [
            Vertex(position: float3(-0.5,  0.5, 0), color: float4(1, 0, 0, 1)),
            Vertex(position: float3(-0.5, -0.5, 0), color: float4(0, 1, 0, 1)),
            Vertex(position: float3( 0.5, -0.5, 0), color: float4(0, 0, 1, 1)),
            Vertex(position: float3( 0.5,  0.5, 0), color: float4(1, 0, 1, 1))
        ]
    }
}

class Triangle: Polygon, ClarkDrawable {
    var verts: [Vertex] = []
    
    var vertexBuffer: MTLBuffer!
    
    init() {
        makeVerts()
        
        makeBuffers()
    }
    
    func render(_ rce: MTLRenderCommandEncoder) {
        rce.setRenderPipelineState(Metal.PipeStateLib[.Basic])
        
        rce.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        rce.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: verts.count)
    }
    
    func makeBuffers() {
        vertexBuffer = Nicotine.Device.makeBuffer(bytes: &verts, length: Vertex.stride(verts.count), options: [])
    }
    
    func makeVerts() {
        verts = [
            Vertex(position: float3( 0.0,  0.5, 0), color: float4(1, 0, 0, 1)),
            Vertex(position: float3( 0.5, -0.5, 0), color: float4(0, 1, 0, 1)),
            Vertex(position: float3(-0.5, -0.5, 0), color: float4(0, 0, 1, 1))
        ]
    }
}
