import MetalKit
import simd

public let XAXIS = float3(1, 0, 0)
public let YAXIS = float3(0, 1, 0)
public let ZAXIS = float3(0, 0, 1)


class Object {
    var drawable: ClarkDrawable!
    
    // Default Positions, rotations, etc...
    private var _position = float3(0, 0, 0)
    private var _rotation: Float = 0.0
    private var _rotationAxis = float3(0, 0, 0)
    private var _orientation: quaternion {
        quaternion(angle: _rotation.toRadians, axis: _rotationAxis)
    }
    private var _scale = float3(1, 1, 1)
    
    var modMat: ModelMat!
    
    var modelMatrix: float4x4 {
        var modelMatrix = matrix_identity_float4x4
        
        modelMatrix.scale(_scale)
        
        modelMatrix.rotate(_orientation)
        
        modelMatrix.translate(_position)
        
        return modelMatrix
    }
    
    // Override in derived classes
    func update() { }
    
    func draw(_ rce: MTLRenderCommandEncoder) {
        update()
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
    func rotate(_ angle: Float, on axis: float3) {
        _rotationAxis = axis
        _rotation += angle
    }
    func setRotation(_ angle: Float, on axis: float3) {
        _rotationAxis = axis
        _rotation = angle
    }
    
    
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
