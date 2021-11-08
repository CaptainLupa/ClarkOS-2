import MetalKit

class EventHandler {
    private static var KEY_COUNT = 256
    private static var _keys = [Bool].init(repeating: false, count: KEY_COUNT)
    
    public static func setKeyPressed(_ keycode: UInt16, _ isOn: Bool) {
        _keys[Int(keycode)] = isOn
    }
    
    public static func isKeyPressed(_ keycode: Keycode) -> Bool {
        return _keys[Int(keycode.rawValue)]
    }
}
