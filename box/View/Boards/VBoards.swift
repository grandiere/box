import UIKit

class VBoards:VView
{
    private weak var controller:CBoards!
    private weak var spinner:VSpinner?
    private let kBarHeight:CGFloat = 50
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CBoards
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let viewBar:VBoardsBar = VBoardsBar(
            controller:self.controller)
        
        addSubview(spinner)
        addSubview(viewBar)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
