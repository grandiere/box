import UIKit

class VBoardsCell:UICollectionViewCell
{
    private weak var square:UIView!
    private weak var labelPosition:UILabel!
    private weak var labelScore:UILabel!
    private weak var labelHandler:UILabel!
    private let kSquareMargin:CGFloat = 10
    private let kSquareSize:CGFloat = 40
    private let kHandlerLeft:CGFloat = 7
    private let kHandlerWidth:CGFloat = 80
    private let kScoreWidth:CGFloat = 200
    private let kSquareCornerRadius:CGFloat = 4
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        
        let square:UIView = UIView()
        square.isUserInteractionEnabled = false
        square.translatesAutoresizingMaskIntoConstraints = false
        square.clipsToBounds = true
        square.layer.cornerRadius = kSquareCornerRadius
        self.square = square
        
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
        
        square.addSubview(labelPosition)
        addSubview(square)
        addSubview(labelHandler)
        addSubview(labelScore)
        
        NSLayoutConstraint.topToTop(
            view:square,
            toView:self,
            constant:kSquareMargin)
        NSLayoutConstraint.leftToLeft(
            view:square,
            toView:self,
            constant:kSquareMargin)
        NSLayoutConstraint.size(
            view:square,
            constant:kSquareSize)
        
        NSLayoutConstraint.equals(
            view:labelPosition,
            toView:square)
        
        NSLayoutConstraint.equalsVertical(
            view:labelHandler,
            toView:self)
        NSLayoutConstraint.leftToRight(
            view:labelHandler,
            toView:square,
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
    
    //MARK: private
    
    private func currentUser()
    {
        square.backgroundColor = UIColor.gridBlue
        labelPosition.textColor = UIColor.black
        labelHandler.textColor = UIColor.white
        labelScore.textColor = UIColor.white
        backgroundColor = UIColor.clear
    }
    
    private func otherUser()
    {
        square.backgroundColor = UIColor.gridOrange
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
