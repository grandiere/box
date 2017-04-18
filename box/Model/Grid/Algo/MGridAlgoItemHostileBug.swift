import UIKit

class MGridAlgoItemHostileBug:MGridAlgoItemHostile
{
    private let kWidth:Float = 110
    private let kHeight:Float = 110
    
    init(
        latitude:Double,
        longitude:Double,
        difficulty:Int,
        created:TimeInterval)
    {
        super.init(
            latitude:latitude,
            longitude:longitude,
            image:#imageLiteral(resourceName: "assetTextureTriangle"),
            width:kWidth,
            height:kHeight,
            difficulty:difficulty,
            created:created)
    }
}
