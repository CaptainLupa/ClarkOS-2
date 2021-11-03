import MetalKit

enum PDTypes {
    case Basic
}

protocol RPD {
    var pipeD: MTLRenderPipelineDescriptor! { get }
}

class PipelineDescriptorLibrary: Library {
    private var _library: [PDTypes: RPD] = [:]
    
    override func generateLib() {
        _library.updateValue(BasicPD(), forKey: .Basic)
    }
    
    subscript(_ type: PDTypes) -> MTLRenderPipelineDescriptor {
        return _library[type]!.pipeD
    }
}

public class BasicPD: RPD {
    var pipeD: MTLRenderPipelineDescriptor!
    
    init() {
        pipeD = MTLRenderPipelineDescriptor()
        
        pipeD.colorAttachments[0].pixelFormat = .bgra8Unorm
        pipeD.vertexFunction = Metal.ShaderLib[.BasicVert]
        pipeD.fragmentFunction = Metal.ShaderLib[.BasicFrag]
        pipeD.vertexDescriptor = Metal.VertexDescLib[.Basic]
    }
}
