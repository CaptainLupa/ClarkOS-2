import MetalKit
import simd

protocol ClarkDrawable {
    func render(_ rce: MTLRenderCommandEncoder)
}

protocol Polygon {
    var verts: [Vertex] { get }
    var vertexBuffer: MTLBuffer! { get }
    func makeBuffers()
    func makeVerts()
}

class Object {
    var drawable: ClarkDrawable!
    private var _position: float3 = float3(0.1, 0, 0)
    private var _orientation: quaternion = quaternion(vector: float4(0, 0, 0, 0))
    private var _scale: float3 = float3(1, 1, 1)
    
    private var modelMatrix = ModelMatracies()
    
    init() {
        
    }
    
    private func updateMatrix() {
        modelMatrix.modelMatrix.translate(_position)
        
        // TODO: Rotation
        
        modelMatrix.modelMatrix.scale(_scale)
    }
    
    func draw(_ rce: MTLRenderCommandEncoder) {
        updateMatrix()
        
        rce.setVertexBytes(&modelMatrix, length: ModelMatracies.stride, index: 1)
        
        self.drawable.render(rce)
    }
}

class Player: Object {
    init(_ cd: ClarkDrawable = Quad()) {
        super.init()
        
        self.drawable = cd
    }
}

class Quad: Polygon, ClarkDrawable {
    var verts: [Vertex] = []
    var indices: [UInt32] = [0, 1, 2,
                             0, 3, 2]
    
    var vertexBuffer: MTLBuffer!
    var indicesBuffer: MTLBuffer!
    
    init(_ v: [Vertex]) {
        do {
            try makeVerts(v)
        } catch ClarkErrors.InvalidVertexArraySize {
            print("In 'Quad.init(_ v: [Vertex])'")
            print("ClarkErrors::InvalidVertexArraySize was thrown by 'makeVerts(v)'")
            print("Invalid Vertex Array Size: must be 4, was \(v.count).")
        } catch { }
        
        makeBuffers()
    }
    
    init(_ v: [Vertex], _ i: [UInt32]) {
        do {
            try makeVerts(v)
        } catch ClarkErrors.InvalidVertexArraySize {
            print("In 'Quad.init(_ v: [Vertex], _ i: [UInt32])'")
            print("ClarkErrors::InvalidVertexArraySize was thrown by 'makeVerts(v)'")
            print("Invalid Vertex Array Size: must be 4, was \(v.count).")
        } catch { }
        
        indices = i
        
        makeBuffers()
    }
    
    init() {
        makeVerts()
        
        makeBuffers()
    }
    
    func render(_ rce: MTLRenderCommandEncoder) {
        rce.setRenderPipelineState(Metal.PipeStateLib[.Basic])
        
        rce.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        rce.drawIndexedPrimitives(type: .triangle, indexCount: indices.count, indexType: .uint32, indexBuffer: indicesBuffer, indexBufferOffset: 0)
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
    
    func makeVerts(_ v: [Vertex]) throws {
        if v.count != 4 {
            throw ClarkErrors.InvalidVertexArraySize
        }
        
        
        verts = [v[0], v[1], v[2], v[3]]
    }
    
    func setIndices(_ i: [UInt32]) {
        indices = i
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
