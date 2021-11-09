import MetalKit

class Camera {
    private var _position = float3(0, 0, 0)
    private var _orientation = float3(0, 0, 0)
    private var _scale = float3(1, 1, 1)
    
    private var _movable: Bool!
    
    var camMat = CameraMats()
    
    var viewMatrix: float4x4 {
        var vm = matrix_identity_float4x4
        
        vm.scale(_scale)
        
        vm.rotate(_orientation.x, XAXIS)
        vm.rotate(_orientation.y, YAXIS)
        vm.rotate(_orientation.z, ZAXIS)
        
        vm.translate(-_position)
        
        return vm
    }
    
    var projectionMatrix: float4x4 {
        return float4x4.prespective(degreesFov: 90, aspectRatio: Renderer.aspectRatio, near: 0.1, far: 1000)
    }
    
    init(_ movable: Bool = true) {
        self._movable = movable
    }
    
    func update() {
        if _movable {
            if EventHandler.isKeyPressed(.upArrow) {
                self.moveY(AppTime.DeltaTime)
            }
            if EventHandler.isKeyPressed(.downArrow) {
                self.moveY(-AppTime.DeltaTime)
            }
            if EventHandler.isKeyPressed(.leftArrow) {
                self.rotateY(AppTime.DeltaTime)
            }
            if EventHandler.isKeyPressed(.rightArrow) {
                self.rotateY(-AppTime.DeltaTime)
            }
            if EventHandler.isKeyPressed(.w) {
                self.moveZ(-AppTime.DeltaTime)
            }
            if EventHandler.isKeyPressed(.s) {
                self.moveZ(AppTime.DeltaTime)
            }
            if EventHandler.isKeyPressed(.d) {
                self.moveX(AppTime.DeltaTime)
            }
            if EventHandler.isKeyPressed(.a) {
                self.moveX(-AppTime.DeltaTime)
            }
        }
        
        
        self.camMat.viewMatrix = self.viewMatrix
        self.camMat.projectionMatrix = self.projectionMatrix
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
    func rotateX(_ x: Float) { _orientation.x += x }
    func rotateY(_ y: Float) { _orientation.y += y }
    func rotateZ(_ z: Float) { _orientation.z += z }
    func rotate(_ xyz: float3) { _orientation += xyz }
    
    func setRotationX(_ x: Float) { _orientation.x = x }
    func setRotationY(_ y: Float) { _orientation.y = y }
    func setRotationZ(_ z: Float) { _orientation.z = z }
    func setRotation(_ xyz: float3) { _orientation = xyz }
    
    func getRotationX() -> Float { return _orientation.x }
    func getRotationY() -> Float { return _orientation.y }
    func getRotationZ() -> Float { return _orientation.z }
    func getRotation() -> float3 { return _orientation }
}
