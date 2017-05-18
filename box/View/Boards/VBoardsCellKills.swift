import UIKit

class VBoardsCellKills:VBoardsCell
{
    private weak var labelKills:UILabel!
    private let kKillsWidth:CGFloat = 200
    private let kKillsRight:CGFloat = -10
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let labelKills:UILabel = UILabel()
        labelKills.isUserInteractionEnabled = false
        labelKills.translatesAutoresizingMaskIntoConstraints = false
        labelKills.backgroundColor = UIColor.clear
        labelKills.font = UIFont.numeric(size:16)
        labelKills.textColor = UIColor(white:1, alpha:0.8)
        labelKills.textAlignment = NSTextAlignment.right
        self.labelKills = labelKills
        
        addSubview(labelKills)
        
        NSLayoutConstraint.equalsVertical(
            view:labelKills,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:labelKills,
            toView:self,
            constant:kKillsRight)
        NSLayoutConstraint.width(
            view:labelKills,
            constant:kKillsWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    override func config(item:MBoardsItem)
    {
        super.config(item:item)
        labelKills.text = "\(item.kills)"
    }
}
