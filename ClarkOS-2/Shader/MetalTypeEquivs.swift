import MetalKit

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
public typealias quaternion = simd_quatd
public typealias quaternionS = simd_quatf

extension float3: Measurable { }
extension float4: Measurable { }
extension quaternion: Measurable { }
extension quaternionS: Measurable { }

extension UInt32: Measurable { }

struct Vertex: Measurable {
    var position: float3
    var color: float4
}
