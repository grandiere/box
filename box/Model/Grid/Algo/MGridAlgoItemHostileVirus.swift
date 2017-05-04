import Foundation

class MGridAlgoItemHostileVirus:MGridAlgoItemHostile
{
    class func virusWith(firebaseVirus:FDbAlgoHostileVirusItem) -> MGridAlgoItemHostileVirus
    {
        let virus:MGridAlgoItemHostileVirus
        var friendly:Bool = false
        
        if let userId:String = MSession.sharedInstance.settings?.firebaseId
        {
            if userId == firebaseVirus.userId
            {
                friendly = true
            }
        }
        
        if friendly
        {
            virus = MGridAlgoItemHostileVirusFriendly(
        }
        else
        {
            
        }
        
        return virus
    }
    
    override func firebasePath() -> String
    {
        let path:String = "\(FDb.algoVirus)/\(firebaseId)"
        
        return path
    }
}
