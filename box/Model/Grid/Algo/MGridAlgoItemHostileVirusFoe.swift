import UIKit

class MGridAlgoItemHostileVirusFoe:MGridAlgoItemHostileVirus
{
    let posterId:String
    private let kWidth:Float = 110
    private let kHeight:Float = 110
    
    init(
        latitude:Double,
        longitude:Double,
        difficulty:Int,
        created:TimeInterval,
        posterId:String)
    {
        self.posterId = posterId
        
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
