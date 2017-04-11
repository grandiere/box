import UIKit

class CScanner:CController
{
    private weak var viewScanner:VScanner!
    
    override func loadView()
    {
        let viewScanner:VScanner = VScanner(controller:self)
        self.viewScanner = viewScanner
        view = viewScanner
    }
}
