import UIKit

extension UIFont
{
    class func numeric(size:CGFloat) -> UIFont
    {
        return UIFont(name:"HelveticaNeue", size:size)!
    }
    
    class func regular(size:CGFloat) -> UIFont
    {
        return UIFont(name:"Avenir-Light", size:size)!
    }
    
    class func italic(size:CGFloat) -> UIFont
    {
        return UIFont(name:"AvenirNext-Italic", size:size)!
    }
    
    class func medium(size:CGFloat) -> UIFont
    {
        return UIFont(name:"AvenirNext-Regular", size:size)!
    }
    
    class func bold(size:CGFloat) -> UIFont
    {
        return UIFont(name:"AvenirNext-Medium", size:size)!
    }
    
    class func bolder(size:CGFloat) -> UIFont
    {
        return UIFont(name:"AvenirNext-Bold", size:size)!
    }
}
