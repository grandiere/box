import UIKit

class CLanding:CController
{
    let model:MLanding
    private weak var viewLanding:VLanding!
    
    override init()
    {
        model = MLanding()
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedSessionLoaded(sender:)),
            name:Notification.sessionLoaded,
            object:nil)
        
        MSession.sharedInstance.loadSession()
    }
    
    override func loadView()
    {
        let viewLanding:VLanding = VLanding(controller:self)
        self.viewLanding = viewLanding
        view = viewLanding
    }
    
    //MARK: notified
    
    func notifiedSessionLoaded(sender notification:Notification)
    {
        NotificationCenter.default.removeObserver(self)
        
        DispatchQueue.main.async
        { [weak self] in
            
            
        }
    }
    
    //MARK: public
    
    func openScanner()
    {
        let controllerGrid:CGrid = CGrid()
        parentController.push(
            controller:controllerGrid,
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
