import MetalKit

class Renderer: NSObject, MTKViewDelegate {
    var object = Player()
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {  }
    
    func draw(in view: MTKView) {
        
        guard let drawable = view.currentDrawable, let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        
        let commandBuffer = Nicotine.CommandQ.makeCommandBuffer()
        let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        AppTime.updateTime(1 / Float(view.preferredFramesPerSecond))

        object.draw(commandEncoder!)
        
        commandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
