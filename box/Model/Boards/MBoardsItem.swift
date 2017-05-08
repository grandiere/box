import Foundation

class MBoardsItem
{
    var position:Int
    let score:Int
    let handler:String
    let userId:String
    
    init(
        score:Int,
        handler:String,
        userId:String)
    {
        self.score = score
        self.handler = handler
        self.userId = userId
        position = 0
    }
}
