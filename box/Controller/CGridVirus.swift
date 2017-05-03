import UIKit

class CGridVirus:CController
{
    private weak var model:MGridAlgo!
    private weak var viewVirus:VGridVirus!
    
    init(model:MGridAlgo)
    {
        self.model = model
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
