import UIKit

class CTutorial:CController
{
    private weak var viewTutorial:VTutorial!
    
    override func loadView()
    {
        let viewTutorial:VTutorial = VTutorial(controller:self)
        self.viewTutorial = viewTutorial
        view = viewTutorial
    }
}
