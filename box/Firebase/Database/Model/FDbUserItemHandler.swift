import Foundation

class FDbUserItemHandler:FDbProtocol
{
    let handler:String
    
    //MARK: node protocol
    
    required init?(snapshot:Any)
    {
        
        guard
            
            let handler:String = snapshot as? String
        
        else
        {
            return nil
        }
        
        self.handler = handler
    }
    
    func json() -> Any?
    {
        return handler
    }
}
