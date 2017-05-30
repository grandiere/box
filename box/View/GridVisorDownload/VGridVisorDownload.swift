import UIKit

class VGridVisorDownload:VView
{
    private weak var controller:CGridVisorDownload!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CGridVisorDownload
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
