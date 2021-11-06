import MetalKit

class Scene {
    var objects: [Object] = []
    var cameras: [Camera] = [Camera()]
    
    var activeCamera: Camera!
    
    init() {
        self.activeCamera = self.cameras[0]
    }
    
    func addObject(_ obj: Object) {
        objects.append(obj)
    }
    
    func addCamera(_ cam: Camera) {
        cameras.append(cam)
    }
    
    private func update() {
        for cam in cameras {
            cam.update()
        }
    }
    
    func drawScene(_ rce: MTLRenderCommandEncoder) {
        update()
        
        rce.setVertexBytes(&activeCamera.camMat, length: CameraMats.stride, index: 1)
        
        for obj in objects {
            obj.draw(rce)
        }
    }
}
