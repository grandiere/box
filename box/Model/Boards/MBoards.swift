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
            nodeType:FDbuser)
        { (data:FDbProtocol?) in
                <#code#>
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
}
