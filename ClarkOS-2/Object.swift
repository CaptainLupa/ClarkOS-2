import MetalKit
import simd

public let XAXIS = float3(1, 0, 0)
public let YAXIS = float3(0, 1, 0)
public let ZAXIS = float3(0, 0, 1)

class Object {
    var drawable: ClarkDrawable!
    
    // Default Positions, rotations, etc...
    private var _position = float3(0, 0, 0)
    private var _orientations = float3(0, 0, 0) // x y z angles
    private var _scale = float3(1, 1, 1)
    
    var children: [Object] = []
    
    var modMat: ModelMat!
    
    // Default parent so the parent doesn't get moved around.
    var parentModelMatrix: float4x4 = matrix_identity_float4x4
    
    var modelMatrix: float4x4 {
        var modelMatrix = matrix_identity_float4x4
        
        modelMatrix.scale(_scale)
        
        
        _position.rotate(_orientations.x, XAXIS)
        _position.rotate(_orientations.y, YAXIS)
        _position.rotate(_orientations.z, ZAXIS)
        
        modelMatrix.translate(_position)
        
        return parentModelMatrix * modelMatrix
    }
    
    // Override in derived classes
    func update() { }
    
    func draw(_ rce: MTLRenderCommandEncoder) {
        update()
        
        for child in children {
            child.parentModelMatrix = self.modelMatrix
            child.update()
        }
        
        rce.setVertexBytes(&modMat, length: ModelMat.stride, index: 2)
        self.drawable.render(rce)
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
    
    // Rotation
    func rotateX(_ x: Float) { _orientations.x += x }
    func rotateY(_ y: Float) { _orientations.y += y }
    func rotateZ(_ z: Float) { _orientations.z += z }
    func rotate(_ xyz: float3) { _orientations += xyz }
    
    func setRotationX(_ x: Float) { _orientations.x = x }
    func setRotationY(_ y: Float) { _orientations.y = y }
    func setRotationZ(_ z: Float) { _orientations.z = z }
    func setRotation(_ xyz: float3) { _orientations = xyz }
    
    func getRotationX() -> Float { return _orientations.x }
    func getRotationY() -> Float { return _orientations.y }
    func getRotationZ() -> Float { return _orientations.z }
    func getRotation() -> float3 { return _orientations }
    
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
