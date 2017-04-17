import UIKit

class MGridAlgoItemHostileBug:MGridAlgoItemHostile
{
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
            difficulty:difficulty,
            created:created)
    }
}
