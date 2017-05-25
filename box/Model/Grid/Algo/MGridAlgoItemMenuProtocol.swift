import Foundation

protocol MGridAlgoItemMenuProtocol
{
    var showMatch:Bool { get }
    var showDetail:Bool { get }
    var showDownload:Bool { get }
    
    func detail() -> [MGridVisorDetailProtocol]
}
