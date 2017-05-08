import UIKit

class VBoardsCell:UICollectionViewCell
{
    private weak var labelNumber:UILabel!
    private weak var labelScore:UILabel!
    private weak var labelName:UILabel!
    private weak var layoutCircleTop:NSLayoutConstraint!
    private let kCircleSize:CGFloat = 40
    private let kCircleLeft:CGFloat = 15
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        
        let circle:UIView = UIView()
        circle.isUserInteractionEnabled = false
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.clipsToBounds = true
        circle.backgroundColor = UIColor(white:1, alpha:0.5)
        circle.layer.cornerRadius = kCircleSize / 2.0
        
        let labelNumber:UILabel = UILabel()
        labelNumber.isUserInteractionEnabled = false
        labelNumber.translatesAutoresizingMaskIntoConstraints = false
        labelNumber.backgroundColor = UIColor.clear
        labelNumber.font = UIFont.bold(size:12)
        labelNumber.textColor = UIColor.black
        labelNumber.textAlignment = NSTextAlignment.center
        self.labelNumber = labelNumber
        
        circle.addSubview(labelNumber)
        addSubview(circle)
        
        layoutCircleTop = NSLayoutConstraint.topToTop(
            view:circle,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:circle,
            toView:self)
        NSLayoutConstraint.size(
            view:circle,
            constant:kCircleSize)
        
        NSLayoutConstraint.equals(
            view:labelNumber,
            toView:circle)
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
    
    //MARK: public
    
    func config(item:MBoardsItem)
    {
        labelNumber.text = "\(item.position)"
    }
}
