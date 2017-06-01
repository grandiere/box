import UIKit

protocol MGridAlgoItemProtocol
{
    var algoTitle:String? { get }
    var firebasePath:String { get }
    var icon:UIImage? { get }
    
    func detail() -> [MGridVisorDetailProtocol]
}
