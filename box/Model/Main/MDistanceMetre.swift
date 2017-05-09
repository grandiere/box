import Foundation

class MDistanceMetre:MDistanceProtocol
{
    var name:String
    {
        get
        {
            return NSLocalizedString("", comment:"")
        }
    }
    
    var shortName:String
    {
        get
        {
            return NSLocalizedString("", comment:"")
        }
    }
    
    func convertFromStandard(standard:Double) -> Double
    {
        return standard
    }
}
