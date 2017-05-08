import Foundation

class MBoards
{
    private(set) var items:[MBoardsItem]
    private weak var controller:CBoards?
    
    init()
    {
        items = []
    }
    
    //MARK: private
    
    private func asyncLoad()
    {
        let path:String = FDb.user
        
        FMain.sharedInstance.db.listenOnce(
            path:path,
            nodeType:FDbUser.self)
        { [weak self] (data:FDbProtocol?) in
            
            guard
            
                let users:FDbUser = data as? FDbUser
            
            else
            {
                return
            }
            
            self?.loadedUsers(users:users)
        }
    }
    
    private func loadedUsers(users:FDbUser)
    {
        var items:[MBoardsItem] = []
        
        let userIds:[String] = Array(users.items.keys)
        
        for userId:String in userIds
        {
            guard
            
                let firebaseUser:FDbUserItem = users.items[userId],
                let handler:String = firebaseUser.handler
            
            else
            {
                continue
            }
            
            let item:MBoardsItem = MBoardsItem(
                score:firebaseUser.score,
                name:handler,
                userId:userId)
            items.append(item)
        }
        
        items.sort
        { (itemA:MBoardsItem, itemB:MBoardsItem) -> Bool in
            
            if itemA.score > itemB.score
            {
                return true
            }
            
            return false
        }

        var position:Int = 1
        
        for item:MBoardsItem in items
        {
            item.position = position
            position += 1
        }
        
        self.items = items
        controller?.boardsLoaded()
    }
    
    //MARK: public
    
    func load(controller:CBoards)
    {
        self.controller = controller
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncLoad()
        }
    }
}
