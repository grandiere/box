import UIKit

class VBoardsBarSelectorItem:UIButton
{
    init(title:String)
    {
        super.init(frame:CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        setTitle(title, for:UIControlState.normal)
        setTitleColor(
            UIColor.gridBlue,
            for:UIControlState.highlighted)
        setTitleColor(
            UIColor.white,
            for:UIControlState.selected)
        setTitleColor(
            UIColor.gridOrange,
            for:UIControlState.normal)
        titleLabel!.font = UIFont.bold(size:15)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
