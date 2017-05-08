import UIKit

class VBoardsCell:UICollectionViewCell
{
    private weak var circle:UIView!
    private weak var labelPosition:UILabel!
    private weak var labelScore:UILabel!
    private weak var labelHandler:UILabel!
    private weak var layoutCircleTop:NSLayoutConstraint!
    private let kCircleSize:CGFloat = 35
    private let kCircleLeft:CGFloat = 10
    private let kHandlerLeft:CGFloat = 7
    private let kHandlerWidth:CGFloat = 80
    private let kScoreWidth:CGFloat = 200
    
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
        
        let labelPosition:UILabel = UILabel()
        labelPosition.isUserInteractionEnabled = false
        labelPosition.translatesAutoresizingMaskIntoConstraints = false
        labelPosition.backgroundColor = UIColor.clear
        labelPosition.font = UIFont.bold(size:12)
        labelPosition.textAlignment = NSTextAlignment.center
        self.labelPosition = labelPosition
        
        let labelHandler:UILabel = UILabel()
        labelHandler.isUserInteractionEnabled = false
        labelHandler.translatesAutoresizingMaskIntoConstraints = false
        labelHandler.backgroundColor = UIColor.clear
        labelHandler.font = UIFont.bold(size:17)
        self.labelHandler = labelHandler
        
        let labelScore:UILabel = UILabel()
        labelScore.isUserInteractionEnabled = false
        labelScore.translatesAutoresizingMaskIntoConstraints = false
        labelScore.backgroundColor = UIColor.clear
        labelScore.font = UIFont.numeric(size:24)
        self.labelScore = labelScore
        
        circle.addSubview(labelPosition)
        addSubview(circle)
        addSubview(labelHandler)
        addSubview(labelScore)
        
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
            view:labelPosition,
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
        
        NSLayoutConstraint.equalsVertical(
            view:labelScore,
            toView:self)
        NSLayoutConstraint.leftToRight(
            view:labelScore,
            toView:labelHandler)
        NSLayoutConstraint.width(
            view:labelScore,
            constant:kScoreWidth)
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
        labelPosition.textColor = UIColor.white
        labelHandler.textColor = UIColor.black
        labelScore.textColor = UIColor.black
        backgroundColor = UIColor(white:1, alpha:0.6)
    }
    
    private func otherUser()
    {
        circle.backgroundColor = UIColor(white:1, alpha:0.75)
        labelPosition.textColor = UIColor.black
        labelHandler.textColor = UIColor.white
        labelScore.textColor = UIColor.white
        backgroundColor = UIColor.clear
    }
    
    //MARK: public
    
    func config(item:MBoardsItem)
    {
        labelPosition.text = "\(item.position)"
        labelHandler.text = item.handler
        labelScore.text = "\(item.score)"
        
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
