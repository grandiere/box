import Foundation

protocol FDatabaseNodeProtocol
{
    init?(snapshot:Any)
    func json() -> Any
}
