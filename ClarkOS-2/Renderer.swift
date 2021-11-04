import MetalKit

class Renderer: NSObject, MTKViewDelegate {
    var object = Player()
    
    var x: Float = 1
    var y: Float = -0.6
    
    override init() {
        super.init()
        object.setScale(float3(repeating: 0.5))
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {  }
    
    func draw(in view: MTKView) {
        
        guard let drawable = view.currentDrawable, let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        
        let commandBuffer = Nicotine.CommandQ.makeCommandBuffer()
        let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        AppTime.updateTime(1 / Float(view.preferredFramesPerSecond))
        
        if object.getPosX() > 0.5 || object.getPosX() < -0.75 {
            self.x = -self.x
        }
        
        if object.getPosY() > 0.75 || object.getPosY() < -0.75 {
            self.y = -self.y
        }
        
        object.moveX(self.x * AppTime.DeltaTime)
        object.moveY(self.y * AppTime.DeltaTime)

        object.draw(commandEncoder!)
        
        commandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
