import UIKit

class CGridVirus:CController
{
    private weak var modelAlgo:MGridAlgo!
    private weak var viewVirus:VGridVirus!
    
    init(modelAlgo:MGridAlgo)
    {
        self.modelAlgo = modelAlgo
        super.init()
    }
    
    required init?(coder: NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewVirus:VGridVirus = VGridVirus(controller:self)
        self.viewVirus = viewVirus
        view = viewVirus
    }
}
