import Foundation

class MSessionLevelUp
{
    class func levelUp()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            asyncLevelUp()
        }
    }
    
    private class func asyncLevelUp()
    {
        let level:Int = MSession.sharedInstance.level
        let score:Int = MSession.sharedInstance.score
        
        let scoreForLevelUp:Int = level * kScoreLevelRatio
        
        if score > scoreForLevelUp
        {
            let maxLevel:Int = Int(DUser.kMaxStats)
            level += 1
            
            if level > maxLevel
            {
                level = maxLevel
            }
            
            guard
                
                let userPath:String = firebasePath()
                
                else
            {
                return
            }
            
            let path:String = "\(userPath)/\(FDbUserItem.level)"
            FMain.sharedInstance.db.updateChild(
                path:path,
                json:level)
            
            let message:String = NSLocalizedString("MSession_levelUp", comment:"")
            VToast.messageBlue(message:message)
        }
    }
}
