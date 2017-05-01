import Foundation

class MGridVisorTake
{
    private weak var controller:CGridVisorTake?
    private weak var model:MGridAlgoItemAid!
    
    init(controller:CGridVisorTake, model:MGridAlgoItemAid)
    {
        self.controller = controller
        self.model = model
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.strategyTake()
        }
    }
    
    //MARK: private
    
    private func strategyTake()
    {
        
    }
}
