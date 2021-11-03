import MetalKit

enum VDTypes {
    case Basic
}

protocol VDClass {
    var name: String { get }
    var vertexDescriptor: MTLVertexDescriptor! { get }
}

class VertexDescriptorLibrary: Library {
    private var _library: [VDTypes: VDClass] = [:]
    
    override func generateLib() {
        _library.updateValue(BasicVD(), forKey: .Basic)
    }
    
    subscript(_ type: VDTypes) -> MTLVertexDescriptor {
        return _library[type]!.vertexDescriptor
    }
}

public class BasicVD: VDClass {
    var name = "Basic Vertex Descriptor"
    
    var vertexDescriptor: MTLVertexDescriptor!
    
    init() {
        vertexDescriptor = MTLVertexDescriptor()
        
        // Position
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].offset = 0
        
        // Color
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].offset = float3.size
        
        vertexDescriptor.layouts[0].stride = Vertex.stride
    }
}
