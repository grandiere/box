import Foundation

protocol FDbProtocol
{
    init?(snapshot:Any)
    func json() -> Any?
}
