import MetalKit

class MainView: MTKView {
    var rendyboy: Renderer!
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        
        self.preferredFramesPerSecond = 120
        
        Nicotine.Smoke(device!)
        
        self.colorPixelFormat = .bgra8Unorm
        
        Stuff.changeClearColor(.white)
        
        self.clearColor = Stuff.clearColor!
        
        rendyboy = Renderer(self)
        
        self.delegate = rendyboy
    }
}

// INPUT HANDLING --------------------------------------------------------------------

extension MainView {
    override var acceptsFirstResponder: Bool {
        return true
    }
    
    // Any Keys
    override func keyUp(with event: NSEvent) {
        EventHandler.setKeyPressed(event.keyCode, false)
    }

    override func keyDown(with event: NSEvent) {
        EventHandler.setKeyPressed(event.keyCode, true)
    }

    // MOUSE EVENTS----------------------------------------------------
    
    // Left Mouse Button
//    override func mouseUp(with event: NSEvent) {
//        <#code#>
//    }
//
//    override func mouseDown(with event: NSEvent) {
//        <#code#>
//    }
//
//    override func mouseMoved(with event: NSEvent) {
//        <#code#>
//    }
//
//    override func mouseDragged(with event: NSEvent) {
//        <#code#>
//    }
//
//    // Right Mouse Button
//    override func rightMouseUp(with event: NSEvent) {
//        <#code#>
//    }
//
//    override func rightMouseDown(with event: NSEvent) {
//        <#code#>
//    }
//
//    override func rightMouseDragged(with event: NSEvent) {
//        <#code#>
//    }
}
