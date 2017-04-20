import UIKit

class VGridVisorDetailCellDebug:VGridVisorDetailCell
{
    private weak var labelLevel:UILabel!
    private let kTitleLeft:CGFloat = 10
    private let kTitleWidth:CGFloat = 240
    private let kHexagonWidth:CGFloat = 66
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.bold(size:16)
        labelTitle.textColor = UIColor.black
        labelTitle.text = NSLocalizedString("VGridVisorDetailCellLevel_labelTitle", comment:"")
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.image = #imageLiteral(resourceName: "assetGenericHexagon")
        
        let labelLevel:UILabel = UILabel()
        labelLevel.translatesAutoresizingMaskIntoConstraints = false
        labelLevel.isUserInteractionEnabled = false
        labelLevel.backgroundColor = UIColor.clear
        labelLevel.textAlignment = NSTextAlignment.center
        labelLevel.font = UIFont.numeric(size:16)
        labelLevel.textColor = UIColor.white
        self.labelLevel = labelLevel
        
        addSubview(labelTitle)
        addSubview(imageView)
        addSubview(labelLevel)
        
        NSLayoutConstraint.equalsVertical(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:labelTitle,
            toView:self,
            constant:kTitleLeft)
        NSLayoutConstraint.width(
            view:labelTitle,
            constant:kTitleWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:imageView,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:imageView,
            toView:self)
        NSLayoutConstraint.width(
            view:imageView,
            constant:kHexagonWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:labelLevel,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:labelLevel,
            toView:self)
        NSLayoutConstraint.width(
            view:labelLevel,
            constant:kHexagonWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(model:MGridVisorDetailItem)
    {
        guard
            
            let modelLevel:MGridVisorDetailItemLevel = model as? MGridVisorDetailItemLevel
            
        else
        {
            return
        }
    }
}
