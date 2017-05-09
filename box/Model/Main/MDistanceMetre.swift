import Foundation

class MDistanceMetre:MDistanceProtocol
{
    var name:String
    {
        get
        {
            return NSLocalizedString("MDistanceMetre_name", comment:"")
        }
    }
    
    var shortName:String
    {
        get
        {
            return NSLocalizedString("MDistanceMetre_shortName", comment:"")
        }
    }
    
    func convertFromStandard(standard:Double) -> Double
    {
        return standard
    }
}
