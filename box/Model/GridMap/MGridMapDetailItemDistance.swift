import UIKit
import CoreLocation

class MGridMapDetailItemDistance:MGridMapDetailItem
{
    private let kMaxDecimals:Int = 0
    private let kMinIntegers:Int = 1
    
    init?(
        userLocation:CLLocation,
        annotation:MGridMapAnnotation)
    {
        guard
            
            let location:CLLocation = annotation.algo?.location,
            let distanceMetrics:MDistanceProtocol = MSession.sharedInstance.settings?.currentDistance()
        
        else
        {
            return nil
        }
        
        let rawDistance:CLLocationDistance = location.distance(from:userLocation)
        let convertDistance:Double = distanceMetrics.convertFromStandard(standard:rawDistance)
        let rawDistanceNumber:NSNumber = convertDistance as NSNumber
        let numberFormatter:NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = kMaxDecimals
        numberFormatter.minimumIntegerDigits = kMinIntegers
        
        guard
            
            let rawDistanceString:String = numberFormatter.string(
                from:rawDistanceNumber)
        
        else
        {
            return nil
        }
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:14),
            NSForegroundColorAttributeName:UIColor(white:0, alpha:0.3)]
        let attributesSubtitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.numeric(size:14),
            NSForegroundColorAttributeName:UIColor.black]
        
        let stringTitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("MGridMapDetailItemDistance_stringTitle", comment:""),
            attributes:attributesTitle)
        let stringDistance:NSAttributedString = NSAttributedString(
            string:rawDistanceString,
            attributes:attributesSubtitle)
        let stringMetrics:NSAttributedString = NSAttributedString(
            string:" \(distanceMetrics.name)",
            attributes:attributesSubtitle)
        
        mutableString.append(stringTitle)
        mutableString.append(stringDistance)
        mutableString.append(stringMetrics)
        
        super.init(attributedString:mutableString)
    }
}
