import UIKit

class CGridVirus:CController
{
    let model:MGridVirus
    private weak var modelAlgo:MGridAlgo!
    private weak var viewVirus:VGridVirus!
    
    init(modelAlgo:MGridAlgo)
    {
        self.modelAlgo = modelAlgo
        model = MGridVirus()
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
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func releaseVirus()
    {
        
    }
}
