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

extension matrix_float4x4: Measurable { }

func toRadians(_ degrees: Float) -> Float {
    return degrees * .pi / 180
}

// Fancy matrix extensions

extension matrix_float4x4 {
    mutating func translate(_ v: float3) {
        var result = matrix_identity_float4x4
        
        result.columns = (
            float4(1, 0, 0, 0),
            float4(0, 1, 0, 0),
            float4(0, 0, 1, 0),
            float4(v.x, v.y, v.z, 1)
        )
        
        self = matrix_multiply(self, result)
    }
    
    mutating func scale(_ v: float3) {
        var result = matrix_identity_float4x4
        
        result.columns = (
            float4(v.x, 0, 0, 0),
            float4(0, v.y, 0, 0),
            float4(0, 0, v.z, 0),
            float4(0, 0, 0, 1)
        )
        
        self = matrix_multiply(self, result)
    }
    
    mutating func rotate(_ angle: Float, _ axis: float3, _ pQuat: quaternion) {
        let newQ = quaternion(vector: float4(axis, cos(angle / 2)))
        
        let newPQ = newQ * pQuat * newQ.conjugate
        
        let newVec = float3(newPQ.vector.x, newPQ.vector.y, newPQ.vector.z)
        
        var mat = matrix_identity_float4x4
        
        mat.columns = (
            float4(1, 0, 0, 0),
            float4(0, 1, 0, 0),
            float4(0, 0, 1, 0),
            float4(newVec.x, newVec.y, newVec.z, 1)
        )
        
        self = matrix_multiply(self, mat)
    }
    
    /// vec is the vector to be rotated around quaternion
   // mutating func rotate(_ quat: quaternion, _ vec: float3) {
        //let nQuat = simd_normalize(quat)
        //let rotatedVec = nQuat.act(vec)
   // }
}
