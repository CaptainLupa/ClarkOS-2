import MetalKit
import simd

public let XAXIS = float3(1, 0, 0)
public let YAXIS = float3(0, 1, 0)
public let ZAXIS = float3(0, 0, 1)


class Object {
    var drawable: ClarkDrawable!
    private var _position: float3 = float3(0, 0, 0)
    
    private var _eulerAnges: float3 = float3(0, 0, 45)
    
    private var _positionQuat: quaternion {
        return quaternion(vector: float4(_position, 0))
    }
    
    private var _scale: float3 = float3(1, 1, 1)
    
    var modMat: ModelMat!
    
    var modelMatrix: matrix_float4x4 {
        var modelMatrix = matrix_identity_float4x4
        //modelMatrix.translate(float3(0, 0, 0))
        
        modelMatrix.rotate(toRadians(_eulerAnges.z), ZAXIS, _positionQuat)
        
        modelMatrix.translate(_position)
        
        modelMatrix.scale(_scale)
        
        return matrix_multiply(matrix_identity_float4x4, modelMatrix)
    }
    
    // Override in derived classes
    func update() { }
    
    func draw(_ rce: MTLRenderCommandEncoder) {
        update()
        rce.setVertexBytes(&modMat, length: ModelMat.stride, index: 1)
        //rce.setVertexBytes(&proj, length: ViewMats.stride, index: 2)
        self.drawable.render(rce)
    }
}

// Player updates its own modelMat, I think... damn lol
class Player: Object {
    
    init(_ cd: ClarkDrawable = Quad()) {
        super.init()
        
        self.modMat = ModelMat()
        
        self.drawable = cd
        
        
    }
    
    func updateModMat() {
        modMat.modelMatrix = self.modelMatrix
    }
    
    override func update() {
        updateModMat()
    }
}

extension Object {
    // Position
    func moveX(_ x: Float) { _position.x += x }
    func moveY(_ y: Float) { _position.y += y }
    func moveZ(_ z: Float) { _position.z += z }
    func move(_ dp: float3) { _position += dp }
    
    func setX(_ x: Float) { _position.x = x }
    func setY(_ y: Float) { _position.y = y }
    func setZ(_ z: Float) { _position.z = z }
    func setPos(_ np: float3) { _position = np }
    
    func getPosX() -> Float { return _position.x }
    func getPosY() -> Float { return _position.y }
    func getPosZ() -> Float { return _position.z }
    func getPos() -> float3 { return _position }
    
    // TODO: Rotation
    
    // Scale
    func setScaleX(_ x: Float) { _scale.x = x }
    func setScaleY(_ y: Float) { _scale.y = y }
    func setScaleZ(_ z: Float) { _scale.z = z }
    func setScale(_ ns: float3) { _scale = ns }
    
    func getScaleX() -> Float { return _scale.x }
    func getScaleY() -> Float { return _scale.y }
    func getScaleZ() -> Float { return _scale.z }
    func getScale() -> float3 { return _scale }
}
