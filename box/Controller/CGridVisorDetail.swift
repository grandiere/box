import UIKit

class CGridVisorDetail:CController
{
    let modelDetail:MGridVisorDetail
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
    
    //MARK: public
    
    func back()
    {
        parentController.dismissAnimateOver(completion:nil)
    }
    
    func share()
    {
        
    }
    
    func enterMach()
    {
        guard
            
            let model:MGridAlgoItemHostile = self.model as? MGridAlgoItemHostile
        
        else
        {
            return
        }
        
        let controllerMatch:CGridVisorMatch = CGridVisorMatch(model:model)
        parentController.animateOver(controller:controllerMatch)
    }
    
    func enterTake()
    {
        
    }
}
