import UIKit

class CGridVisorDownload:CController
{
    private weak var model:MGridAlgoAidItem?
    private weak var viewDownload:VGridVisorDownload!
    private let kWaitTime:TimeInterval = 2
    private let kMessageTime:TimeInterval = 2
    
    init(model:MGridAlgoAidItem)
    {
        self.model = model
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).asyncAfter(
            deadline:DispatchTime.now() + kWaitTime)
        { [weak self] in
            
            self?.strategyDownload()
        }
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        parentController.viewParent.panRecognizer.isEnabled = false
    }
    
    override func loadView()
    {
        let viewDownload:VGridVisorDownload = VGridVisorDownload(controller:self)
        self.viewDownload = viewDownload
        view = viewDownload
    }
    
    //MARK: private
    
    private func strategyDownload()
    {
        guard
            
            let model:MGridAlgoAidItem = self.model,
            let strategy:MGridVisorDownloadProtocol = MGridVisorDownload.strategyDownload(
                item:model)
        
        else
        {
            return
        }
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.strategyFound(strategy:strategy)
        }
    }
    
    private func strategyFound(strategy:MGridVisorDownloadProtocol)
    {
        strategy.apply()
        destroyDownload()
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewDownload.downloaded(model:strategy)
        }
    }
    
    private func destroyDownload()
    {
        guard
            
            let model:MGridAlgoAidItem = self.model
            
        else
        {
            return
        }
        
        let path:String = model.firebasePath
        FMain.sharedInstance.db.removeChild(path:path)
        
        NotificationCenter.default.post(
            name:Notification.destroyAlgoRendered,
            object:model)
    }
    
    private func done()
    {
        parentController.dismissAnimateOver(completion:nil)
    }
}
