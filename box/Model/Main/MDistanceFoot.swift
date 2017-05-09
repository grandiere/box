import Foundation

class MDistanceFoot:MDistanceProtocol
{
    var name:String
    {
        get
        {
            return NSLocalizedString("MDistanceFoot_name", comment:"")
        }
    }
    
    var shortName:String
    {
        get
        {
            return NSLocalizedString("MDistanceFoot_shortName", comment:"")
        }
    }
    
    func convertFromStandard(standard:Double) -> Double
    {
        return standard
    }
}
