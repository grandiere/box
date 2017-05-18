import Foundation

protocol MBoardsSortProtocol
{
    var reusableIdentifier:String { get }
    func sort(items:[MBoardsItem]) -> [MBoardsItem]
}
