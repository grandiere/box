import UIKit

class VGridVisorMatchBaseBackgroundAnimation:UIView
{
    private let model:MGridVisorMatchAnimation
    private let kWaitInit:TimeInterval = 0.5
    
    init()
    {
        model = MGridVisorMatchAnimation()
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kWaitInit)
        { [weak self] in
            
            guard
                
                let width:CGFloat = self?.bounds.maxX,
                let height:CGFloat = self?.bounds.maxY
            
            else
            {
                return
            }
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                guard
                
                    let model:MGridVisorMatchAnimation = self?.model
                
                else
                {
                    return
                }
                
                model.initialElements(width:width, height:height)
            }
        }
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
