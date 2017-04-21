import UIKit

class CProfile:CController
{
    let model:MProfile
    private weak var viewProfile:VProfile!
    
    override init()
    {
        model = MProfile()
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewProfile:VProfile = VProfile(controller:self)
        self.viewProfile = viewProfile
        view = viewProfile
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
