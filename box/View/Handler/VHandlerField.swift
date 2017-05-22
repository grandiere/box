import UIKit

class VHandlerField:UITextField, UITextFieldDelegate
{
    private weak var controller:CHandler?
    private let kBorderHeight:CGFloat = 1
    private let kMaxCharacter:Int = 10
    
    init(controller:CHandler)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        font = UIFont.regular(size:34)
        textColor = UIColor.white
        tintColor = UIColor.white
        autocorrectionType = UITextAutocorrectionType.no
        autocapitalizationType = UITextAutocapitalizationType.none
        spellCheckingType = UITextSpellCheckingType.no
        keyboardType = UIKeyboardType.alphabet
        keyboardAppearance = UIKeyboardAppearance.light
        borderStyle = UITextBorderStyle.none
        clearButtonMode = UITextFieldViewMode.never
        text = MSession.sharedInstance.handler
        delegate = self
        self.controller = controller
        
        let border:VBorder = VBorder(color:UIColor(white:1, alpha:0.5))
        
        addSubview(border)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:1)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: field delegate
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField:UITextField)
    {
        guard
        
            let handler:String = textField.text
        
        else
        {
            return
        }
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            MSession.sharedInstance.updateHandler(handler:handler)
            
            DispatchQueue.main.async
            { [weak self] in
                
                self?.controller?.updateWarning()
            }
        }
    }
    
    func textField(_ textField:UITextField, shouldChangeCharactersIn range:NSRange, replacementString string:String) -> Bool
    {
        guard
        
            let text:String = textField.text
        
        else
        {
            return false
        }
        
        let nsString:NSString = text as NSString
        let replaced:String = nsString.replacingCharacters(in:range, with:string)
        
        if replaced.characters.count > kMaxCharacter
        {
            return false
        }
        
        return true
    }
}
