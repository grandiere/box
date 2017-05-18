import UIKit

class VBoardsBarSelectorBackground:UIView
{
    private let kBorderWidth:CGFloat = 1
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        layer.borderWidth = kBorderWidth
        layer.borderColor = UIColor.gridBlue.cgColor
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let height:CGFloat = bounds.maxY
        let height_2:CGFloat = height / 2.0
        layer.cornerRadius = height_2
        
        super.layoutSubviews()
    }
}
