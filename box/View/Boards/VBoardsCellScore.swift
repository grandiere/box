import UIKit

class VBoardsCellScore:VBoardsCell
{
    private weak var labelScore:UILabel!
    private let kScoreWidth:CGFloat = 300
    private let kScoreRight:CGFloat = -10
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let labelScore:UILabel = UILabel()
        labelScore.isUserInteractionEnabled = false
        labelScore.translatesAutoresizingMaskIntoConstraints = false
        labelScore.backgroundColor = UIColor.clear
        labelScore.font = UIFont.numeric(size:16)
        labelScore.textColor = UIColor(white:1, alpha:0.8)
        labelScore.textAlignment = NSTextAlignment.right
        self.labelScore = labelScore

        addSubview(labelScore)
        
        NSLayoutConstraint.equalsVertical(
            view:labelScore,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:labelScore,
            toView:self,
            constant:kScoreRight)
        NSLayoutConstraint.width(
            view:labelScore,
            constant:kScoreWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    override func config(item:MBoardsItem)
    {
        super.config(item:item)
        labelScore.text = "\(item.score)"
    }
}
