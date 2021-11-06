import MetalKit


class Player: Object {
    init(_ cd: ClarkDrawable = Quad()) {
        super.init()
        
        self.drawable = cd
        
        self.modMat = ModelMat()
    }
    
    private func updateMat() {
        self.modMat.modelMatrix = self.modelMatrix
    }
    
    override func update() {
        updateMat()
    }
}
