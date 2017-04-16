import UIKit

class CGrid:CController
{
    private weak var viewGrid:VGrid!
    
    override func loadView()
    {
        let viewGrid:VGrid = VGrid(controller:self)
        self.viewGrid = viewGrid
        view = viewGrid
    }
}
