import Foundation

class MGridVisorTake
{
    private weak var controller:CGridVisorTake?
    private weak var model:MGridAlgoItemAid!
    private let kDifficultySkill:UInt32 = 30
    
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
        let random:UInt32 = arc4random_uniform(kDifficultySkill)
        
        if random == 0
        {
            
        }
        else
        {
            
        }
    }
}
