import Foundation

class MGridVisorDownload
{
    private weak var controller:CGridVisorDownload?
    private weak var model:MGridAlgoAidItem!
    private let kDifficultyStats:UInt32 = 80
    
    init(controller:CGridVisorDownload, model:MGridAlgoAidItem)
    {
        self.controller = controller
        self.model = model
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.strategyDownload()
        }
    }
    
    //MARK: private
    
    private func strategyDownload()
    {
        let random:UInt32 = arc4random_uniform(kDifficultyStats)
        let strategy:MGridVisorDownloadProtocol
        
        if random == 0
        {
            strategy = MGridVisorDownloadStats.factory()
        }
        else
        {
            guard
            
                let strategyEnergy:MGridVisorDownloadEnergy = MGridVisorDownloadEnergy.factory()
            
            else
            {
                return
            }
            
            strategy = strategyEnergy
        }
        
        guard
            
            let controller:CGridVisorDownload = self.controller
            
        else
        {
            return
        }
        
        strategy.apply(controller:controller)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.controller?.viewTake.aidDefined(model:strategy)
        }
    }
}
