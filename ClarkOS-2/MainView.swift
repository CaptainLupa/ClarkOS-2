import MetalKit

class MainView: MTKView {
    var rendyboy: Renderer!
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        
        self.preferredFramesPerSecond = 120
        
        Nicotine.Smoke(device!)
        
        self.colorPixelFormat = .bgra8Unorm
        
        Stuff.changeClearColor(.blue)
        
        self.clearColor = Stuff.clearColor!
        
        rendyboy = Renderer(self)
        
        self.delegate = rendyboy
    }
}
