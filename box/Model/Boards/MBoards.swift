import Foundation

class MBoards
{
    private(set) var sort:MBoardsSortProtocol
    private(set) var items:[MBoardsItem]
    private weak var controller:CBoards?
    private let kSortWait:TimeInterval = 1
    
    init()
    {
        sort = MBoardsSortScore()
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
            
            if handler.characters.count > 0
            {
                let item:MBoardsItem = MBoardsItem(
                    score:firebaseUser.score,
                    kills:firebaseUser.kills,
                    handler:handler,
                    userId:userId)
                items.append(item)
            }
        }
        
        self.items = items
        itemsLoaded()
    }
    
    private func itemsLoaded()
    {
        items = sort.sort(items:items)
        numberItems()
        controller?.boardsLoaded()
    }
    
    private func numberItems()
    {
        var position:Int = 1
        
        for item:MBoardsItem in items
        {
            item.position = position
            position += 1
        }
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
    
    func sortScore()
    {
        controller?.viewBoards.startLoading()
        sort = MBoardsSortScore()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).asyncAfter(
            deadline:DispatchTime.now() + kSortWait)
        { [weak self] in
            
            self?.itemsLoaded()
        }
    }
    
    func sortKills()
    {
        controller?.viewBoards.startLoading()
        sort = MBoardsSortKills()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).asyncAfter(
            deadline:DispatchTime.now() + kSortWait)
        { [weak self] in
            
            self?.itemsLoaded()
        }
    }
}
