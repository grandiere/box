import UIKit

class CGridHarvest:CController
{
    let model:MGridHarvest
    private weak var modelAlgo:MGridAlgo?
    private(set) weak var viewHarvest:VGridHarvest!
    
    init(modelAlgo:MGridAlgo)
    {
        self.modelAlgo = modelAlgo
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
        
        guard
            
            let modelAlgo:MGridAlgo = self.modelAlgo
        
        else
        {
            return
        }
        
        model.loadHarvest(
            controller:self,
            modelAlgo:modelAlgo)
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func harvestLoaded()
    {
        viewHarvest.refresh()
    }
}
