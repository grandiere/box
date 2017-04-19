import UIKit

class CGridVisorDetail:CController
{
    private weak var viewDetail:VGridVisorDetail!
    private weak var model:MGridAlgoItem!
    
    init(model:MGridAlgoItem)
    {
        self.model = model
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
}
