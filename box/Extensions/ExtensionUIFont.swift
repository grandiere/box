import UIKit

extension UIFont
{
    class func numeric(size:CGFloat) -> UIFont
    {
        return UIFont(name:"HelveticaNeue", size:size)!
    }
    
    class func regular(size:CGFloat) -> UIFont
    {
        return UIFont(name:"ArialMT", size:size)!
    }
    
    class func bold(size:CGFloat) -> UIFont
    {
        return UIFont(name:"Arial-BoldMT", size:size)!
    }
}
