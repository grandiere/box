import UIKit

class CBoards:CController
{
    private weak var viewBoards:VBoards!
    
    override func loadView()
    {
        let viewBoards:VBoards = VBoards(controller:self)
        self.viewBoards = viewBoards
        view = viewBoards
    }
}
