import MetalKit
import simd

class Object {
    var drawable: ClarkDrawable!
    private var _position: float3 = float3(0.5, 0, 0)
    private var _orientation: quaternion = quaternion(vector: float4(0, 0, 0, 0))
    private var _scale: float3 = float3(1, 1, 1)
    
    var modMat: ModelMat!
    
    var modelMatrix: matrix_float4x4 {
        var modelMatrix = matrix_identity_float4x4
        
        modelMatrix.translate(_position)
        
        // TODO: Rotation
        
        modelMatrix.scale(_scale)
        
        return matrix_multiply(matrix_identity_float4x4, modelMatrix)
    }
    
    // Override in derived classes
    func update() { }
    
    func draw(_ rce: MTLRenderCommandEncoder) {
        update()
        rce.setVertexBytes(&modMat, length: ModelMat.stride, index: 1)
        self.drawable.render(rce)
    }
}

// Player updates its own modelMat, I think... damn lol
class Player: Object {
    func updateModMat() {
        modMat.modelMatrix = self.modelMatrix
    }
    
    override func update() {
        updateModMat()
    }
    
    init(_ cd: ClarkDrawable = Quad()) {
        super.init()
        
        self.modMat = ModelMat()
        
        self.drawable = cd
    }
}

