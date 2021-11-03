import MetalKit

class Renderer: NSObject{
    //var renderPipelineState: MTLRenderPipelineState!
    
    var tri: Triangle!
    var verts: [Vertex] = []
    var vertBuffer: MTLBuffer!
    
    override init() {
        super.init()
        
        tri = Triangle()
        
        //makeVerts()
        
        //makeBuffer()
    }
    
    func makeBuffer() {
        vertBuffer = Nicotine.Device.makeBuffer(bytes: self.verts, length: Vertex.stride(verts.count), options: [])
    }
    
    func makeVerts() {
        verts.append(Vertex(position: float3(0, 0.5, 0), color: float4(1, 0, 0, 1)))
        verts.append(Vertex(position: float3(0.5, -0.5, 0), color: float4(0, 1, 0, 1)))
        verts.append(Vertex(position: float3(-0.5, -0.5, 0), color: float4(0, 0, 1, 1)))
        
    }
    
}

extension Renderer: MTKViewDelegate{
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {  }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable, let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        
        let commandBuffer = Nicotine.CommandQ.makeCommandBuffer()
        let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        tri.render(commandEncoder!)
        
        commandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
}
