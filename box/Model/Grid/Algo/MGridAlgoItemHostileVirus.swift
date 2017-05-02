import Foundation

class MGridAlgoItemHostileVirus:MGridAlgoItemHostile
{
    override func firebasePath() -> String
    {
        let path:String = "\(FDb.algoVirus)/\(firebaseId)"
        
        return path
    }
}
