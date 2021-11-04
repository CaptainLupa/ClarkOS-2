import MetalKit

class AppTime {
    private static var _totalAppTime: Float = 0.0
    private static var _deltaTime: Float = 0.0
    
    public static func updateTime(_ dt: Float) {
        self._deltaTime = dt
        self._totalAppTime += dt
    }
    
    public static var TotalAppTime: Float {
        return self._totalAppTime
    }
    
    public static var DeltaTime: Float {
        return self._deltaTime
    }
}
