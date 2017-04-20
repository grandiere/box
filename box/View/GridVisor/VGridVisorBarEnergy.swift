import UIKit

class VGridVisorBarEnergy:UIView
{
    private weak var controller:CGridVisor!
    private weak var labelEnergy:UILabel!
    private let kLabelRight:CGFloat = 10
    
    init(controller:CGridVisor)
    {
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
        labelEnergy.font = UIFont.numeric(size:25)
        labelEnergy.textColor = UIColor.white
        self.labelEnergy = labelEnergy
        
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
        labelEnergy.text = "\(energy) %"
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
