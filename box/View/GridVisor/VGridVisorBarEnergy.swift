import UIKit

class VGridVisorBarEnergy:UIView
{
    private weak var controller:CGridVisor!
    private weak var labelEnergy:UILabel!
    private let stringTitle:NSAttributedString
    private let stringPercent:NSAttributedString
    private let attributesAmount:[String:AnyObject]
    private let kLabelRight:CGFloat = -10
    
    init(controller:CGridVisor)
    {
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:12),
            NSForegroundColorAttributeName:UIColor(white:1, alpha:0.8)]
        let attributesPercent:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:16),
            NSForegroundColorAttributeName:UIColor(white:1, alpha:0.6)]
        attributesAmount = [
            NSFontAttributeName:UIFont.bold(size:19),
            NSForegroundColorAttributeName:UIColor.white]
        
        stringTitle = NSAttributedString(
            string:NSLocalizedString("VGridVisorBarEnergy_title", comment:""),
            attributes:attributesTitle)
        stringPercent = NSAttributedString(
            string:NSLocalizedString("VGridVisorBarEnergy_percent", comment:""),
            attributes:attributesPercent)
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        self.controller = controller
        
        let labelEnergy:UILabel = UILabel()
        labelEnergy.translatesAutoresizingMaskIntoConstraints = false
        labelEnergy.backgroundColor = UIColor.clear
        labelEnergy.isUserInteractionEnabled = false
        labelEnergy.textAlignment = NSTextAlignment.right
        self.labelEnergy = labelEnergy
        
        addSubview(labelEnergy)
        
        NSLayoutConstraint.equalsVertical(
            view:labelEnergy,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:labelEnergy,
            toView:self,
            constant:kLabelRight)
        NSLayoutConstraint.leftToLeft(
            view:labelEnergy,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func asyncRefresh()
    {
        guard
        
            let energy:Int = MSession.sharedInstance.settings?.energy?.percentEnergy()
        
        else
        {
            return
        }
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.updateEnergy(energy:energy)
        }
    }
    
    private func updateEnergy(energy:Int)
    {
        let rawAmount:String = "\(energy)"
        let stringAmount:NSAttributedString = NSAttributedString(
            string:rawAmount,
            attributes:attributesAmount)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringTitle)
        mutableString.append(stringAmount)
        mutableString.append(stringPercent)
        
        labelEnergy.attributedText = mutableString
    }
    
    //MARK: public
    
    func refresh()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncRefresh()
        }
    }
}
