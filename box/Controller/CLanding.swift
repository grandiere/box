import UIKit

class CLanding:CController
{
    private weak var viewLanding:VLanding!
    
    override func loadView()
    {
        let viewLanding:VLanding = VLanding(controller:self)
        self.viewLanding = viewLanding
        view = viewLanding
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
