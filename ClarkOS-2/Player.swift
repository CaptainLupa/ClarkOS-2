import MetalKit


class Player: Object {
    private var _movable: Bool!
    
    init(_ cd: ClarkDrawable = Cube(), _ movable: Bool = true) {
        super.init()
        
        self._movable = movable
        
        self.drawable = cd
        
        self.modMat = ModelMat()
    }
    
    private func updateMat() {
        self.modMat.modelMatrix = self.modelMatrix
    }
    
    override func update() {
        if _movable {
            if EventHandler.isKeyPressed(.leftArrow) {
                self.rotateY(AppTime.DeltaTime)
            }
            if EventHandler.isKeyPressed(.rightArrow) {
                self.rotateY(-AppTime.DeltaTime)
            }
            if EventHandler.isKeyPressed(.l) {
                self.moveX(AppTime.DeltaTime)
            }
            if EventHandler.isKeyPressed(.j) {
                self.moveX(-AppTime.DeltaTime)
            }
        }
        
        updateMat()
    }
}
