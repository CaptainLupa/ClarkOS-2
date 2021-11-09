import MetalKit

class Scene {
    var _objects: [Object] = []
    var _cameras: [Camera] = [Camera()]
    
    var activeCamera: Camera!
    
    init() {
        self.activeCamera = _cameras[0]
    }
    
    func addObject(_ obj: Object) {
        _objects.append(obj)
    }
    
    func addCamera(_ cam: Camera) {
        _cameras.append(cam)
    }
    
    func removeCamera(_ index: Int) {
        _cameras.remove(at: index)
    }
    
    func setActiveCamera(_ index: Int) {
        activeCamera = _cameras[index]
    }
    
    private func update() {
        for cam in _cameras {
            cam.update()
        }
    }
    
    func drawScene(_ rce: MTLRenderCommandEncoder) {
        update()
        
        rce.setVertexBytes(&activeCamera.camMat, length: CameraMats.stride, index: 1)
        
        for obj in _objects {
            obj.draw(rce)
        }
    }
}
