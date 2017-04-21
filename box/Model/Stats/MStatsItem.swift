import UIKit

class MStatsItem
{
    let image:UIImage
    let title:String
    let countString:String
    private let kMinIntegers:Int = 1
    private let kNoCount:String = "0"
    
    init(image:UIImage, title:String, count:Int)
    {
        self.image = image
        self.title = title
        
        let numberCount:NSNumber = count as NSNumber
        
        let numberFormatter:NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.minimumIntegerDigits = kMinIntegers
        
        if let countString:String = numberFormatter.string(
            from:numberCount)
        {
            self.countString = countString
        }
        else
        {
            self.countString = kNoCount
        }
    }
}
