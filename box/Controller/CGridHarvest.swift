import UIKit

class CGridHarvest:CController
{
    private weak var viewHarvest:VGridHarvest!
    
    override func loadView()
    {
        let viewHarvest:VGridHarvest = VGridHarvest(controller:self)
        self.viewHarvest = viewHarvest
        view = viewHarvest
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
