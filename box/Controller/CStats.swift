import UIKit

class CStats:CController
{
    let model:MStats
    private weak var viewStats:VStats!
    
    override init()
    {
        model = MStats()
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewStats:VStats = VStats(controller:self)
        self.viewStats = viewStats
        view = viewStats
    }
}
