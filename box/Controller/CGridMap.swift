import UIKit

class CGridMap:CController
{
    private(set) weak var modelAlgo:MGridAlgo!
    private weak var viewMap:VGridMap!
    
    init(modelAlgo:MGridAlgo)
    {
        self.modelAlgo = modelAlgo
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewMap:VGridMap = VGridMap(controller:self)
        self.viewMap = viewMap
        view = viewMap
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
