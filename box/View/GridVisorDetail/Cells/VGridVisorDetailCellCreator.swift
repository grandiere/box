import UIKit

class VGridVisorDetailCellCreator:VGridVisorDetailCell
{
    private weak var labelCreator:UILabel!
    private weak var layoutIconLeft:NSLayoutConstraint!
    private let kIconWidth:CGFloat = 36
    private let kIconRight:CGFloat = 10
    private let kLabelWidth:CGFloat = 200
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let labelCreator:UILabel = UILabel()
        labelCreator.translatesAutoresizingMaskIntoConstraints = false
        labelCreator.isUserInteractionEnabled = false
        labelCreator.backgroundColor = UIColor.clear
        labelCreator.font = UIFont.regular(size:15)
        labelCreator.textColor = UIColor.black
        labelCreator.textAlignment = NSTextAlignment.right
        self.labelCreator = labelCreator
        
        let icon:UIImageView = UIImageView()
        icon.isUserInteractionEnabled = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.clipsToBounds = true
        icon.contentMode = UIViewContentMode.center
        icon.image = #imageLiteral(resourceName: "assetGenericCreator")
        
        addSubview(labelCreator)
        addSubview(icon)
        
        NSLayoutConstraint.equalsVertical(
            view:icon,
            toView:self)
        layoutIconLeft = NSLayoutConstraint.leftToLeft(
            view:icon,
            toView:self)
        NSLayoutConstraint.width(
            view:icon,
            constant:kIconWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:labelCreator,
            toView:self)
        NSLayoutConstraint.rightToLeft(
            view:labelCreator,
            toView:icon)
        NSLayoutConstraint.width(
            view:labelCreator,
            constant:kLabelWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainLeft:CGFloat = width - kIconWidth
        let marginLeft:CGFloat = remainLeft / 2.0
        layoutIconLeft.constant = marginLeft + kIconRight
        
        super.layoutSubviews()
    }
    
    override func config(controller:CGridVisorDetail, model:MGridVisorDetailProtocol)
    {
        super.config(controller:controller, model:model)
        
        guard
            
            let modelCreator:MGridVisorDetailCreator = model as? MGridVisorDetailCreator
            
        else
        {
            return
        }
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.loadFirebaseHandler(userId:modelCreator.userId)
        }
    }
    
    //MARK: private
    
    private func loadFirebaseHandler(userId:String)
    {
        let path:String = "\(FDb.user)/\(userId)/\(FDbUserItem.handler)"
        FMain.sharedInstance.db.listenOnce(
            path:path,
            nodeType:FDbUserItemHandler.self)
        { [weak self] (data:FDbProtocol?) in
            
            guard
            
                let handler:FDbUserItemHandler = data as? FDbUserItemHandler
            
            else
            {
                let noHandler:String = NSLocalizedString("VGridVisorDetailCellCreator_noHandler", comment:"")
                self?.handlerFound(handler:noHandler)
                
                return
            }
            
            self?.handlerFound(handler:handler.handler)
        }
    }
    
    private func handlerFound(handler:String)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.labelCreator.text = handler
        }
    }
}
