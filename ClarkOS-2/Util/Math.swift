import MetalKit

// Measureable stuff

protocol Measurable { }

extension Measurable {
    static var size: Int {
        return MemoryLayout<Self>.size
    }
    
    static var stride: Int {
        return MemoryLayout<Self>.stride
    }
    
    static func size(_ count: Int) -> Int {
        return MemoryLayout<Self>.size * count
    }
    
    static func stride(_ count: Int) -> Int {
        return MemoryLayout<Self>.stride * count
    }
}

public typealias float3 = simd_float3
public typealias float4 = simd_float4
public typealias quaternion = simd_quatf
public typealias quaternionD = simd_quatd

extension float3: Measurable { }
extension float4: Measurable { }
extension quaternion: Measurable { }
extension quaternionD: Measurable { }

extension UInt32: Measurable { }

extension float4x4: Measurable { }

extension Float {
    var toRadians: Float {
        return self * .pi / 180
    }
    
    var toDegrees: Float {
        return self * 180 / .pi
    }
}

// Fancy matrix extensions

extension float3 {
    mutating func rotate(_ angle: Float, _ axis: float3) {
        let quat = quaternion(angle: angle, axis: axis)
        
        let quatConj = quat.conjugate
        
        let qv = quatMultiply(quatConj, self)
        
        let rotated = qv * quat
        
        self = float3(rotated.vector.x, rotated.vector.y, rotated.vector.z)
    }
    
    func quatMultiply(_ q: quaternion, _ v: float3) -> quaternion {
        let w: Float = -(q.vector.x * v.x) - (q.vector.y * v.y) - (q.vector.z * v.z)
        let x: Float =  (q.vector.w * v.x) + (q.vector.y * v.z) - (q.vector.z * v.y)
        let y: Float =  (q.vector.w * v.y) + (q.vector.z * v.x) - (q.vector.x * v.z)
        let z: Float =  (q.vector.w * v.z) + (q.vector.x * v.y) - (q.vector.y * v.x)
        
        let newQ = quaternion(vector: float4(x, y, z, w))
        
        return newQ
    }
}


extension float4x4 {
    func makeTranslationMatrix(_ x: Float, _ y: Float, _ z: Float) -> float4x4 {
        let rows = [
            float4(1, 0, 0, x),
            float4(0, 1, 0, y),
            float4(0, 0, 1, z),
            float4(0, 0, 0, 1)
        ]
        
        return float4x4(rows: rows)
    }
    
    func makeScaleMatrix(_ x: Float, _ y: Float, _ z: Float) -> float4x4 {
        let rows = [
            float4(x, 0, 0, 0),
            float4(0, y, 0, 0),
            float4(0, 0, z, 0),
            float4(0, 0, 0, 1)
        ]
        
        return float4x4(rows)
    }
    
    mutating func translate(_ v: float3) {
        let result = makeTranslationMatrix(v.x, v.y, v.z)
        
        self = result * self
    }
    
    mutating func scale(_ v: float3) {
        let result = makeScaleMatrix(v.x, v.y, v.z)
        
        self = result * self
    }
    
    static func prespective(degreesFov: Float, aspectRatio: Float, near: Float, far: Float) -> float4x4 {
        let fov = degreesFov.toRadians
        
        let t: Float = tan(fov / 2)
        
        let x: Float = 1 / (aspectRatio * t)
        let y: Float = 1 / t
        let z: Float = -((far + near) / (far - near))
        let w: Float = -((2 * far * near) / far - near)
        
        var result = matrix_identity_float4x4
        
        result.columns = (
            float4(x,  0,  0,  0),
            float4(0,  y,  0,  0),
            float4(0,  0,  z, -1),
            float4(0,  0,  w,  0)
        )
        
        return result
    }
    
    func Orthographic(left: Float, right: Float, bottom: Float, top: Float, near: Float, far: Float) -> float4x4 {
        
        return float4x4(
            float4(2 / (right - left), 0, 0, 0),
            float4(0, 2 / (top - bottom), 0, 0),
            float4(0, 0, 1 / (far - near),   0),
            float4((left + right) / (left - right), (top + bottom) / (bottom - top), near / (near - far), 1)
        )
    }
}
