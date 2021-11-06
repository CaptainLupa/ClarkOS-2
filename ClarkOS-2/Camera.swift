import MetalKit

class Camera {
    private var _position = float3(0, 0, 0)
    private var _rotationAngle: Float = 0
    private var _rotationAxis = float3(0, 0, 0)
    private var _orientation: quaternion {
        return quaternion(angle: _rotationAngle.toRadians, axis: _rotationAxis)
    }
    
    var camMat = CameraMats()
    
    var viewMatrix: float4x4 {
        var vm = matrix_identity_float4x4
        
        vm.rotate(_orientation)
        vm.translate(_position)
        
        return vm
    }
    
    init() {
        
    }
    
    func update() {
        self.camMat.viewMatrix = self.viewMatrix
    }
}

extension Camera {
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
        _rotationAngle += angle
    }
    func setRotation(_ angle: Float, on axis: float3) {
        _rotationAxis = axis
        _rotationAngle = angle
    }
}
