import UIKit

class VBlur:UIVisualEffectView
{
    class func light() -> VBlur
    {
        let style:UIBlurEffectStyle = UIBlurEffectStyle.light
        let blur:VBlur = VBlur(style:style)
        
        return blur
    }
    
    class func extraLight() -> VBlur
    {
        let style:UIBlurEffectStyle = UIBlurEffectStyle.extraLight
        let blur:VBlur = VBlur(style:style)
        
        return blur
    }
    
    class func dark() -> VBlur
    {
        let style:UIBlurEffectStyle = UIBlurEffectStyle.dark
        let blur:VBlur = VBlur(style:style)
        
        return blur
    }
    
    private init(style:UIBlurEffectStyle)
    {
        let visualEffect:UIBlurEffect = UIBlurEffect(style:style)
        
        super.init(effect:visualEffect)
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
