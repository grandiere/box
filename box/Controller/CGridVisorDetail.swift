import UIKit

class CGridVisorDetail:CController
{
    private weak var viewDetail:VGridVisorDetail!
    
    override func loadView()
    {
        let viewDetail:VGridVisorDetail = VGridVisorDetail(controller:self)
        self.viewDetail = viewDetail
        view = viewDetail
    }
}
