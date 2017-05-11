import Foundation

class MTutorial
{
    let items:[MTutorialProtocol]
    
    init()
    {
        let itemBasic:MTutorialBasic = MTutorialBasic()
        let itemDebug:MTutorialDebug = MTutorialDebug()
        
        items = [
            itemBasic,
            itemDebug]
    }
}
