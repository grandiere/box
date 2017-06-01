import Foundation

class MGridAlgoHostileVirusItem:MGridAlgoHostileItem
{
    class func virusWith(
        firebaseId:String,
        firebaseVirus:FDbAlgoHostileVirusItem) -> MGridAlgoHostileVirusItem
    {
        let virus:MGridAlgoHostileVirusItem
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
            virus = MGridAlgoHostileVirusFriendlyItem(
                firebaseId:firebaseId,
                firebaseVirus:firebaseVirus)
        }
        else
        {
            virus = MGridAlgoHostileVirusFoeItem(
                firebaseId:firebaseId,
                firebaseVirus:firebaseVirus)
        }
        
        return virus
    }
    
    override var firebasePath:String
    {
        get
        {
            let path:String = "\(FDb.algoVirus)/\(firebaseId)"
            
            return path
        }
    }
}
