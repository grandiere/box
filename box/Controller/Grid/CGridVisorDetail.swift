import UIKit

class CGridVisorDetail:CController
{
    let modelDetail:[MGridVisorDetailProtocol]
    private weak var viewDetail:VGridVisorDetail!
    private weak var model:MGridAlgoItem!
    
    init(model:MGridAlgoItem)
    {
        self.model = model
        modelDetail = model.detail()
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewDetail:VGridVisorDetail = VGridVisorDetail(controller:self)
        self.viewDetail = viewDetail
        view = viewDetail
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        parentController.viewParent.panRecognizer.isEnabled = false
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(vertical:CParent.TransitionVertical.fromBottom)
    }
    
    func share()
    {
        
    }
    
    func enterMach()
    {
        guard
            
            let model:MGridAlgoHostileItem = self.model as? MGridAlgoHostileItem
        
        else
        {
            return
        }
        
        let controllerMatch:CGridVisorMatch = CGridVisorMatch(model:model)
        parentController.animateOver(controller:controllerMatch)
    }
    
    func enterTake()
    {
        guard
            
            let model:MGridAlgoAidItem = self.model as? MGridAlgoAidItem
            
        else
        {
            return
        }
        
        let controllerTake:CGridVisorTake = CGridVisorTake(model:model)
        parentController.animateOver(controller:controllerTake)
    }
}
