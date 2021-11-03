import MetalKit

protocol Polygon {
    var verts: [Vertex] { get }
    var vertexBuffer: MTLBuffer! { get }
    func render(_ rce: MTLRenderCommandEncoder)
    func makeBuffer()
    func makeVerts()
}

class Triangle: Polygon {
    var verts: [Vertex] = []
    
    var vertexBuffer: MTLBuffer!
    
    init() {
        makeVerts()
        
        makeBuffer()
    }
    
    func render(_ rce: MTLRenderCommandEncoder) {
        rce.setRenderPipelineState(Metal.PipeStateLib[.Basic])
        
        rce.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        rce.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: verts.count)
    }
    
    func makeBuffer() {
        vertexBuffer = Nicotine.Device.makeBuffer(bytes: verts, length: Vertex.stride(verts.count), options: [])
    }
    
    func makeVerts() {//weird bug, you have to append, cant just verts = [...]
        verts.append(Vertex(position: float3(0, 0.5, 0), color: float4(1, 0, 0, 1)))
        verts.append(Vertex(position: float3(0.5, -0.5, 0), color: float4(0, 1, 0, 1)))
        verts.append(Vertex(position: float3(-0.5, -0.5, 0), color: float4(0, 0, 1, 1)))
    }
}
