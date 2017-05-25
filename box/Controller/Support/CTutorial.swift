import UIKit

class CTutorial:CController
{
    let model:MTutorial
    private weak var viewTutorial:VTutorial!
    private let urlMap:[String:String]?
    private let kResourceName:String = "ResourceURL"
    private let kResourceExtension:String = "plist"
    private let kEmailKey:String = "email"
    
    override init()
    {
        model = MTutorial()
        
        guard
            
            let resourceUrl:URL = Bundle.main.url(
                forResource:kResourceName,
                withExtension:kResourceExtension),
            let urlDictionary:NSDictionary = NSDictionary(
                contentsOf:resourceUrl),
            let urlMap:[String:String] = urlDictionary as? [String:String]
            
        else
        {
            self.urlMap = nil
            
            super.init()
            
            return
        }
        
        self.urlMap = urlMap
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewTutorial:VTutorial = VTutorial(controller:self)
        self.viewTutorial = viewTutorial
        view = viewTutorial
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func write()
    {
        guard
            
            let urlString:String = urlMap?[kEmailKey],
            let url:URL = URL(string:urlString)
            
        else
        {
            return
        }
        
        UIApplication.shared.openURL(url)
    }
    
    func tutorialSelected(model:MHelp)
    {
        let controllerHelp:CHelp = CHelp(model:model)
        parentController.push(
            controller:controllerHelp,
            vertical:CParent.TransitionVertical.fromTop,
            background:false)
    }
}
