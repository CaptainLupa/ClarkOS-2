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
}
