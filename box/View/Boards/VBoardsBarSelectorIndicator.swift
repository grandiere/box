import UIKit

class VBoardsBarSelectorIndicator:UIView
{
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.gridBlue
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
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
