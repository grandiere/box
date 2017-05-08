import UIKit

class VBoardsCell:UICollectionViewCell
{
    private weak var circle:UIView!
    private weak var labelNumber:UILabel!
    private weak var labelScore:UILabel!
    private weak var labelHandler:UILabel!
    private weak var layoutCircleTop:NSLayoutConstraint!
    private let kCircleSize:CGFloat = 35
    private let kCircleLeft:CGFloat = 10
    private let kHandlerLeft:CGFloat = 10
    private let kHandlerWidth:CGFloat = 100
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        
        let circle:UIView = UIView()
        circle.isUserInteractionEnabled = false
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.clipsToBounds = true
        circle.layer.cornerRadius = kCircleSize / 2.0
        self.circle = circle
        
        let labelNumber:UILabel = UILabel()
        labelNumber.isUserInteractionEnabled = false
        labelNumber.translatesAutoresizingMaskIntoConstraints = false
        labelNumber.backgroundColor = UIColor.clear
        labelNumber.font = UIFont.bold(size:12)
        labelNumber.textAlignment = NSTextAlignment.center
        self.labelNumber = labelNumber
        
        let labelHandler:UILabel = UILabel()
        labelHandler.isUserInteractionEnabled = false
        labelHandler.translatesAutoresizingMaskIntoConstraints = false
        labelHandler.backgroundColor = UIColor.clear
        labelHandler.font = UIFont.bold(size:15)
        self.labelHandler = labelHandler
        
        circle.addSubview(labelNumber)
        addSubview(circle)
        addSubview(labelHandler)
        
        layoutCircleTop = NSLayoutConstraint.topToTop(
            view:circle,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:circle,
            toView:self,
            constant:kCircleLeft)
        NSLayoutConstraint.size(
            view:circle,
            constant:kCircleSize)
        
        NSLayoutConstraint.equals(
            view:labelNumber,
            toView:circle)
        
        NSLayoutConstraint.equalsVertical(
            view:labelHandler,
            toView:self)
        NSLayoutConstraint.leftToRight(
            view:labelHandler,
            toView:circle,
            constant:kHandlerLeft)
        NSLayoutConstraint.width(
            view:labelHandler,
            constant:kHandlerWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let height:CGFloat = bounds.maxY
        let remainCircle:CGFloat = height - kCircleSize
        let marginTop:CGFloat = remainCircle / 2.0
        layoutCircleTop.constant = marginTop
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func currentUser()
    {
        circle.backgroundColor = UIColor.black
        labelNumber.textColor = UIColor.white
        labelHandler.textColor = UIColor.black
        backgroundColor = UIColor(white:1, alpha:0.3)
    }
    
    private func otherUser()
    {
        circle.backgroundColor = UIColor(white:1, alpha:0.75)
        labelNumber.textColor = UIColor.black
        labelHandler.textColor = UIColor.white
        backgroundColor = UIColor.clear
    }
    
    //MARK: public
    
    func config(item:MBoardsItem)
    {
        labelNumber.text = "\(item.position)"
        labelHandler.text = item.handler
        
        guard
        
            let userId:String = MSession.sharedInstance.settings?.firebaseId
        
        else
        {
            return
        }
        
        if userId == item.userId
        {
            currentUser()
        }
        else
        {
            otherUser()
        }
    }
}
