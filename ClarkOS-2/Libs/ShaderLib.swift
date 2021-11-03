import MetalKit

enum ShaderTypes {
    case BasicVert
    case BasicFrag
}

class ShaderLibrary: Library {
    private var _library: [ShaderTypes: Shader] = [:]
    
    override func generateLib() {
        _library.updateValue(Shader("vertexShader"), forKey: .BasicVert)
        _library.updateValue(Shader("fragmentShader"), forKey: .BasicFrag)
    }
    
    subscript(_ type: ShaderTypes) -> MTLFunction {
        _library[type]!.shaderFunction
    }
}
