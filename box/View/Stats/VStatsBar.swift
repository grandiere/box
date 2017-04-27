import UIKit

class VStatsBar:UIView
{
    private weak var controller:CStats!
    private let kButtonSize:CGFloat = 60
    private let kLabelScoreHeight:CGFloat = 80
    
    init(controller:CStats)
    {
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:12),
            NSForegroundColorAttributeName:UIColor(white:1, alpha:0.8)]
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        let stringTitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VStatsBar_scoreTitle", comment:""),
            attributes:attributesTitle)
        mutableString.append(stringTitle)
        
        if let score:Int = MSession.sharedInstance.score
        {
            let numberFormatter:NumberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            
            let numberScore:NSNumber = score as NSNumber
            
            if let stringScore:String = numberFormatter.string(from:numberScore)
            {
                let attributesScore:[String:AnyObject] = [
                    NSFontAttributeName:UIFont.numeric(size:20),
                    NSForegroundColorAttributeName:UIColor.white]
                
                let stringAttributedScore:NSAttributedString = NSAttributedString(
                    string:stringScore,
                    attributes:attributesScore)
                
                mutableString.append(stringAttributedScore)
            }
        }
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.center
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "assetGenericStats")
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        backButton.imageView!.clipsToBounds = true
        backButton.imageView!.contentMode = UIViewContentMode.center
        backButton.imageView!.tintColor = UIColor.white
        backButton.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let labelScore:UILabel = UILabel()
        labelScore.translatesAutoresizingMaskIntoConstraints = false
        labelScore.isUserInteractionEnabled = false
        labelScore.backgroundColor = UIColor.clear
        labelScore.numberOfLines = 0
        labelScore.textAlignment = NSTextAlignment.center
        labelScore.attributedText = mutableString
        
        addSubview(labelScore)
        addSubview(imageView)
        addSubview(backButton)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:backButton,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:backButton,
            toView:self)
        NSLayoutConstraint.size(
            view:backButton,
            constant:kButtonSize)
        
        NSLayoutConstraint.bottomToBottom(
            view:labelScore,
            toView:self)
        NSLayoutConstraint.height(
            view:labelScore,
            constant:kLabelScoreHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelScore,
            toView:self)
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
