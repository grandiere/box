import UIKit

class CGrid:CController
{
    let model:MGrid
    let modelAlgo:MGridAlgo
    private weak var viewGrid:VGrid!
    
    override init()
    {
        model = MGrid()
        modelAlgo = MGridAlgo()
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewGrid:VGrid = VGrid(controller:self)
        self.viewGrid = viewGrid
        view = viewGrid
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
