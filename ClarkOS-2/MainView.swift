import MetalKit

class MainView: MTKView {
    var rendyboy: Renderer!
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        
        Nicotine.Smoke(device!)
        
        self.colorPixelFormat = .bgra8Unorm
        
        self.clearColor = MTLClearColor(red: 0.25, green: 0.57, blue: 0.39, alpha: 1)
        
        rendyboy = Renderer()
        
        self.delegate = rendyboy
    }
}
