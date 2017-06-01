import UIKit

@UIApplicationMain
class AppDelegate:UIResponder, UIApplicationDelegate
{
    var window:UIWindow?

    func application(
        _ application:UIApplication,
        didFinishLaunchingWithOptions
        launchOptions:[UIApplicationLaunchOptionsKey:Any]?) -> Bool
    {
        FMain.sharedInstance.load()
        
        let window:UIWindow = UIWindow(frame:UIScreen.main.bounds)
        window.backgroundColor = UIColor.black
        window.makeKeyAndVisible()
        
        let parent:CParent = CParent()
        window.rootViewController = parent
        self.window = window
        
        return true
    }
    
    func applicationWillEnterForeground(_ application:UIApplication)
    {
        MSession.sharedInstance.settings?.addTtl()
    }
}
