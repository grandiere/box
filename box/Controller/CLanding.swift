import UIKit

class CLanding:CController
{
    private weak var viewLanding:VLanding!
    
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
