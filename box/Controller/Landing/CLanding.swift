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
            
            self?.viewLanding.sessionLoaded()
        }
    }
    
    //MARK: public
    
    func enterTheGrid()
    {
        let controllerGrid:CGrid = CGrid()
        parentController.push(
            controller:controllerGrid,
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func enterProfile()
    {
        let controllerProfile:CProfile = CProfile()
        parentController.push(
            controller:controllerProfile,
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func enterStats()
    {
        let controllerStats:CStats = CStats()
        parentController.push(
            controller:controllerStats,
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func enterBoards()
    {
        let controllerBoards:CBoards = CBoards()
        parentController.push(
            controller:controllerBoards,
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func openSettings()
    {
        let controllerSettings:CSettings = CSettings()
        parentController.push(
            controller:controllerSettings,
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func openStore()
    {
        let controllerStore:CStore = CStore()
        parentController.push(
            controller:controllerStore,
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func openTutorial()
    {
        let controllerTutorial:CTutorial = CTutorial()
        parentController.push(
            controller:controllerTutorial,
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
