import Foundation

class MBoardsItem
{
    var position:Int
    let score:Int
    let name:String
    let userId:String
    
    init(
        score:Int,
        name:String,
        userId:String)
    {
        self.score = score
        self.name = name
        self.userId = userId
        position = 0
    }
}
