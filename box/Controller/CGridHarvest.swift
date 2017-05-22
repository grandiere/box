import UIKit

class CGridHarvest:CController
{
    let model:MGridHarvest
    private(set) weak var viewHarvest:VGridHarvest!
    
    override init()
    {
        model = MGridHarvest()
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewHarvest:VGridHarvest = VGridHarvest(controller:self)
        self.viewHarvest = viewHarvest
        view = viewHarvest
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        model.loadHarvest(controller:self)
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
