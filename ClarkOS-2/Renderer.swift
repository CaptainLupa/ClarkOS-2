import MetalKit

class Renderer: NSObject, MTKViewDelegate {
    public static var screenSize: simd_float2 = simd_float2(repeating: 0)
    public static var aspectRatio: Float {
        return screenSize.x / screenSize.y
    }
    
    var scene: Scene!
    
    init(_ mView: MTKView) {
        super.init()
        updateScreenSize(mView)
        //object.setScale(float3(repeating: 0.7))
        self.scene = Scene()
        scene.addObject(Player(Cube()))
        scene.activeCamera.setZ(-3)
    }
    
    func updateScreenSize(_ view: MTKView) {
        Renderer.screenSize = simd_float2(Float(view.bounds.width), Float(view.bounds.height))
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        updateScreenSize(view)
    }
    
    func draw(in view: MTKView) {
        
        guard let drawable = view.currentDrawable, let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        
        let commandBuffer = Nicotine.CommandQ.makeCommandBuffer()
        let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        AppTime.updateTime(1 / Float(view.preferredFramesPerSecond))
        
        scene.drawScene(commandEncoder!)
        
        commandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
