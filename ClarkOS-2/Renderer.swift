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
        self.scene = Scene()
        scene.removeCamera(0)
        scene.addCamera(Camera(false))
        scene.setActiveCamera(0)
        scene.addObject(Player(Cube()))
        scene.addObject(Player(Cube()))
        scene._objects[1].setX(5)
        scene.activeCamera.setZ(7)
        scene.activeCamera.setX(2.5)
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
        
        scene._objects[0].rotateX(AppTime.DeltaTime)
        scene._objects[1].rotateZ(AppTime.DeltaTime)
        
        scene.drawScene(commandEncoder!)
        
        commandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
