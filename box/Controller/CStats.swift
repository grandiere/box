import UIKit

class CStats:CController
{
    private weak var viewStats:VStats!
    
    override func loadView()
    {
        let viewStats:VStats = VStats(controller:self)
        self.viewStats = viewStats
        view = viewStats
    }
}
