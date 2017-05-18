import Foundation

class MBoardsItem
{
    var position:Int
    let score:Int
    let kills:Int
    let handler:String
    let userId:String
    
    init(
        score:Int,
        kills:Int,
        handler:String,
        userId:String)
    {
        self.score = score
        self.kills = kills
        self.handler = handler
        self.userId = userId
        position = 0
    }
}
