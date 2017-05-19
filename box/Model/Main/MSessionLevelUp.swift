import Foundation

class MSessionLevelUp
{
    private static let kResourceName:String = "ResourceLevels"
    private static let kResourceExtension:String = "plist"
    
    class func levelUp()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            asyncLevelUp()
        }
    }
    
    private class func asyncLevelUp()
    {
        guard
            
            let resourceLevels:URL = Bundle.main.url(
                forResource:kResourceName,
                withExtension:kResourceExtension),
            let levelsArray:NSArray = NSArray(
                contentsOf:resourceLevels),
            let levelsList:[Int] = levelsArray as? [Int]
            
        else
        {
            return
        }
        
        let level:Int = MSession.sharedInstance.level
        let score:Int = MSession.sharedInstance.score
        let scoreForLevelUp:Int = levelsList[level]
        
        if score >= scoreForLevelUp
        {
            let maxLevel:Int = Int(DUser.kMaxStats)
            
            if level < maxLevel
            {
                MSession.sharedInstance.performLevelUp()
                
                let message:String = NSLocalizedString("MSessionLevelUp_levelUp", comment:"")
                VToast.messageBlue(message:message)
            }
            else
            {
                let message:String = NSLocalizedString("MSessionLevelUp_maxLevel", comment:"")
                VToast.messageOrange(message:message)
            }
        }
    }
}
