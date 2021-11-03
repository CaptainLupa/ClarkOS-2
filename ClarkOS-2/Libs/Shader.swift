import MetalKit

class Shader {
    var shaderFunction: MTLFunction!
    
    init(_ functionName: String) {
        self.shaderFunction = Nicotine.DefLib.makeFunction(name: functionName)
    }
}
