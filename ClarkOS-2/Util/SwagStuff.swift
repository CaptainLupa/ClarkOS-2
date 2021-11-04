import MetalKit

enum CCTypes {
    case white
    case blue
    case red
}

struct Colors {
    public static var lib: [CCTypes:MTLClearColor] = [
        .white: MTLClearColorMake(1, 1, 1, 1),
        .blue: MTLClearColorMake(0.2, 0.14, 0.74, 1.0),
        .red: MTLClearColorMake(0.83, 0.34, 0.18, 1.0)
    ]
}

class Stuff {
    public static var clearColor = Colors.lib[.white]
    
    public static func changeClearColor(_ c: CCTypes) {
        clearColor = Colors.lib[c]
    }
}
