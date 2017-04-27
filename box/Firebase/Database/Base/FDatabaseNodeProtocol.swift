import Foundation

protocol FDatabaseNodeProtocol
{
    init?()
    init?(snapshot:Any)
    
    func json() -> Any?
}
