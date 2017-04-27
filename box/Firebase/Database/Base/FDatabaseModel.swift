import Foundation

class FDatabaseModel
{
    init?()
    {
    }
    
    required init?(snapshot:Any)
    {
        return nil
    }
    
    //MARK: public
    
    func modelJson() -> Any?
    {
        return nil
    }
}
