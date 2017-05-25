import UIKit

protocol MGridAlgoItemProtocol
{
    var firebasePath:String { get }
    var icon:UIImage? { get }
    
    func detail() -> [MGridVisorDetailProtocol]
}
