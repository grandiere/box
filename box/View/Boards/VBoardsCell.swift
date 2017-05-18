import UIKit

class VBoardsCell:UICollectionViewCell
{
    private weak var square:UIView!
    private weak var labelPosition:UILabel!
    private weak var labelHandler:UILabel!
    private let kHandlerLeft:CGFloat = 10
    private let kHandlerWidth:CGFloat = 150
    private let kSquareMargin:CGFloat = 10
    private let kSquareSize:CGFloat = 30
    private let kSquareCornerRadius:CGFloat = 3
    
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
        labelPosition.textColor = UIColor.black
        self.labelPosition = labelPosition
        
        let labelHandler:UILabel = UILabel()
        labelHandler.isUserInteractionEnabled = false
        labelHandler.translatesAutoresizingMaskIntoConstraints = false
        labelHandler.backgroundColor = UIColor.clear
        labelHandler.font = UIFont.bold(size:17)
        labelHandler.textColor = UIColor.white
        self.labelHandler = labelHandler
        
        square.addSubview(labelPosition)
        addSubview(square)
        addSubview(labelHandler)
        
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
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func currentUser()
    {
        square.backgroundColor = UIColor.gridBlue
    }
    
    private func otherUser()
    {
        square.backgroundColor = UIColor.gridOrange
    }
    
    //MARK: public
    
    func config(item:MBoardsItem)
    {
        let position:Int = item.position
        
        labelPosition.text = "\(position)"
        labelHandler.text = item.handler
        
        if position % 2 == 0
        {
            backgroundColor = UIColor(white:1, alpha:0.12)
        }
        else
        {
            backgroundColor = UIColor.clear
        }
        
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
