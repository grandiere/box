import Foundation

protocol MDistanceProtocol
{
    var name:String { get }
    var shortName:String { get }
    func convertFromStandard(standard:Double) -> Double
}
