import Foundation

class MTutorial
{
    let items:[MTutorialProtocol]
    
    init()
    {
        let itemBasic:MTutorialBasic = MTutorialBasic()
        
        items = [
            itemBasic]
    }
}
