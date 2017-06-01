import UIKit

protocol MGridAlgoItemMatchProtocol
{
    var matchTitle:String? { get }
    var creditsMultiplier:CGFloat { get }
    func destroySuccess()
    func addDefeated()
}
