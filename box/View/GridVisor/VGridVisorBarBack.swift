import UIKit

class VGridVisorBarBack:UIButton
{
    private weak var controller:CGridVisor!
    
    init(controller:CGridVisor)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        setImage(
            #imageLiteral(resourceName: "assetGenericVisorBack").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        setImage(
            #imageLiteral(resourceName: "assetGenericVisorBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        imageView!.clipsToBounds = true
        imageView!.contentMode = UIViewContentMode.center
        imageView!.tintColor = UIColor.white
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
}
