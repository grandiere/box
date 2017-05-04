import Foundation

class MGridAlgoItemHostileVirus:MGridAlgoItemHostile
{
    class func virusWith(
        firebaseId:String,
        firebaseVirus:FDbAlgoHostileVirusItem) -> MGridAlgoItemHostileVirus
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
                firebaseId:firebaseId,
                firebaseVirus:firebaseVirus)
        }
        else
        {
            virus = MGridAlgoItemHostileVirusFoe(
                firebaseId:firebaseId,
                firebaseVirus:firebaseVirus)
        }
        
        return virus
    }
    
    override func firebasePath() -> String
    {
        let path:String = "\(FDb.algoVirus)/\(firebaseId)"
        
        return path
    }
}
