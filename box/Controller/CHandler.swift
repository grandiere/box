import UIKit

class CHandler:CController
{
    private weak var viewHandler:VHandler!
    
    override func loadView()
    {
        let viewHandler:VHandler = VHandler(controller:self)
        self.viewHandler = viewHandler
        view = viewHandler
    }
}
