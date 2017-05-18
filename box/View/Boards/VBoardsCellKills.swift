import UIKit

class VBoardsCellKills:VBoardsCell
{
    private weak var labelKills:UILabel!
    private let kIconWidth:CGFloat = 54
    private let kKillsWidth:CGFloat = 200
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let labelKills:UILabel = UILabel()
        labelKills.isUserInteractionEnabled = false
        labelKills.translatesAutoresizingMaskIntoConstraints = false
        labelKills.backgroundColor = UIColor.clear
        labelKills.font = UIFont.bold(size:18)
        labelKills.textColor = UIColor.white
        labelKills.textAlignment = NSTextAlignment.right
        self.labelKills = labelKills
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.image = #imageLiteral(resourceName: "assetGenericBoardsKills")
        
        addSubview(imageView)
        addSubview(labelKills)
        
        NSLayoutConstraint.equalsVertical(
            view:labelKills,
            toView:self)
        NSLayoutConstraint.rightToLeft(
            view:labelKills,
            toView:imageView)
        NSLayoutConstraint.width(
            view:labelKills,
            constant:kKillsWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:imageView,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:imageView,
            toView:self)
        NSLayoutConstraint.width(
            view:imageView,
            constant:kIconWidth)
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
