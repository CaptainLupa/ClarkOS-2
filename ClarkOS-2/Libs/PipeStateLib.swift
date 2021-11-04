import MetalKit

enum PSTypes {
    case Basic
}

/// Render Pipeline State Protocol
protocol PS {
    var pipeS: MTLRenderPipelineState! { get }
}

class PipeStateLibrary: Library {
    private var _library: [PSTypes:PS] = [:]
    
    override func generateLib() {
        _library.updateValue(BasicPS(), forKey: .Basic)
    }
    
    subscript(_ type: PSTypes) -> MTLRenderPipelineState {
        return _library[type]!.pipeS
    }
}

class BasicPS: PS {
    var pipeS: MTLRenderPipelineState!
    
    init() {
        do {
            pipeS = try Nicotine.Device.makeRenderPipelineState(descriptor: Metal.PipeDescLib[.Basic])
        } catch let error as NSError {
            print(error)
        }
    }
}
