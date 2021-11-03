import MetalKit

class Nicotine {
    public static var Device: MTLDevice!
    public static var CommandQ: MTLCommandQueue!
    public static var DefLib: MTLLibrary!
    
    public static func Smoke(_ dev: MTLDevice) {
        self.Device = dev
        self.CommandQ = dev.makeCommandQueue()
        self.DefLib = dev.makeDefaultLibrary()
        
        Metal.Grind()
        
        Mommy.Peg()
    }
}

class Metal {
    private static var _vertexDescLib: VertexDescriptorLibrary!
    public static var VertexDescLib: VertexDescriptorLibrary { return _vertexDescLib }
    
    private static var _shaderLib: ShaderLibrary!
    public static var ShaderLib: ShaderLibrary { return _shaderLib }
    
    private static var _pipeDescLib: PipelineDescriptorLibrary!
    public static var PipeDescLib: PipelineDescriptorLibrary { return _pipeDescLib }
    
    private static var _pipeStateLib: PipeStateLibrary!
    public static var PipeStateLib: PipeStateLibrary { return _pipeStateLib }
    
    public static func Grind() {
        self._vertexDescLib = VertexDescriptorLibrary()
        self._shaderLib = ShaderLibrary()
        self._pipeDescLib = PipelineDescriptorLibrary()
        self._pipeStateLib = PipeStateLibrary()
    }
}

class Mommy {
    public static func Peg() {
        
    }
}
