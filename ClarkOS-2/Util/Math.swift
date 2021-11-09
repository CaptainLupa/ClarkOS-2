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
        let quat = quaternion(angle: angle.toRadians, axis: axis)
        
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
    
    mutating func quatRotate(_ angle: Float, _ axis: float3) {
        let q = quaternion(angle: angle.toRadians, axis: axis)
        
        let qMat = float4x4(q.normalized)
        
        self = qMat * self
    }
    
    mutating func rotate(_ angle: Float, _ axis: float3) {//God why
        //var result = matrix_identity_float4x4
        
        let x: Float = axis.x
        let y: Float = axis.y
        let z: Float = axis.z
        
        let c: Float = cos(angle)
        let s: Float = sin(angle)
        
        let mc: Float = (1 - c)
        
        let r1c1: Float = x * x * mc + c
        let r2c1: Float = x * y * mc + z * s
        let r3c1: Float = x * z * mc - y * s
        
        let r1c2: Float = y * x * mc - z * s
        let r2c2: Float = y * y * mc + c
        let r3c2: Float = y * z * mc + x * s
        
        let r1c3: Float = z * x * mc + y * s
        let r2c3: Float = z * y * mc - x * s
        let r3c3: Float = z * z * mc + c
        
        let rows = [
            float4(r1c1, r1c2, r1c3, 0),
            float4(r2c1, r2c2, r2c3, 0),
            float4(r3c1, r3c2, r3c3, 0),
            float4(   0,    0,    0, 1)
        ]
        
        let result = float4x4(rows: rows)
        
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
            float4(0, 0, -2 / (far - near),   0),
            float4((left + right) / (left - right), (top + bottom) / (bottom - top), near / (near - far), 1)
        )
    }
}

// Quaternion helper funcs
extension quaternion {
//    func rotationBetweenVecs(_ start: float3, _ dest: float3) -> quaternion {
//        var v1 = simd_normalize(start)
//        var v2 = simd_normalize(dest)
//
//        var cosTheta = dot(v1, v2)
//        var rotAxis: float3
//
//        if cosTheta < (-1 + 0.001) {
//            rotAxis = cross(float3(0, 0, 1), v1)
//
//            if simd_length(rotAxis) < 0.01 {
//                rotAxis = cross(float3(1, 0, 0), v1)
//            }
//
//            rotAxis = simd_normalize(rotAxis)
//            let jeff: Float = 180
//            return quaternion(angle: jeff.toRadians, axis: rotAxis)
//        }
//
//        rotAxis = cross(v1, v2)
//        let s: Float = sqrtf((1+cosTheta)*2)
//        let invs: Float = 1 / 2
//
//        return
//    }
}
