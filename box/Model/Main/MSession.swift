import Foundation

class MSession
{
    static let sharedInstance:MSession = MSession()
    private(set) var settings:DSettings?
    private(set) var handler:String?
    private(set) var score:Int
    private(set) var active:Bool
    
    private init()
    {
        score = 0
        active = true
    }
    
    //MARK: private
    
    private func asyncLoadSession()
    {
        DManager.sharedInstance?.fetchData(
            entityName:DSettings.entityName,
            limit:1)
        { (data) in
            
            guard
            
                let settings:DSettings = data?.first as? DSettings
            
            else
            {
                self.createSession()
                
                return
            }
            
            settings.addTtl()
            self.settings = settings
            self.sessionLoaded()
        }
    }
    
    private func createSession()
    {
        DManager.sharedInstance?.createData(
            entityName:DSettings.entityName)
        { (data) in
            
            guard
            
                let settings:DSettings = data as? DSettings
            
            else
            {
                return
            }
            
            self.settings = settings
            self.createUser()
        }
    }
    
    private func createUser()
    {
        DManager.sharedInstance?.createData(
            entityName:DUser.entityName)
        { (data) in
            
            guard
            
                let user:DUser = data as? DUser
            
            else
            {
                return
            }
            
            user.defaultValues()
            self.settings?.user = user
            self.createEnergy()
        }
    }
    
    private func createEnergy()
    {
        DManager.sharedInstance?.createData(
            entityName:DEnergy.entityName)
        { (data) in
            
            guard
                
                let energy:DEnergy = data as? DEnergy
                
            else
            {
                return
            }
            
            energy.defaultValues()
            self.settings?.energy = energy
            self.createStats()
        }
    }
    
    private func createStats()
    {
        DManager.sharedInstance?.createData(
            entityName:DStats.entityName)
        { (data) in
            
            guard
            
                let stats:DStats = data as? DStats
            
            else
            {
                return
            }
            
            self.settings?.stats = stats
            self.sessionLoaded()
        }
    }
    
    private func sessionLoaded()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            DManager.sharedInstance?.save()
            
            if let userId:String = self.settings?.firebaseId
            {
                self.loadFirebaseUser(userId:userId)
            }
            else
            {
                self.createFirebaseUser()
            }
        }
    }
    
    private func loadFirebaseUser(userId:String)
    {
        let path:String = "\(FDb.user)/\(userId)"
        
        FMain.sharedInstance.db.listenOnce(
            path:path,
            nodeType:FDbUserItem.self)
        { (node:FDbProtocol?) in
            
            guard
            
                let user:FDbUserItem = node as? FDbUserItem
            
            else
            {
                return
            }
            
            self.firebaseLoaded(user:user)
        }
    }
    
    private func createFirebaseUser()
    {
        let user:FDbUserItem = FDbUserItem()
        let userJson:Any = user.json()
        
        let userId:String = FMain.sharedInstance.db.createChild(
            path:FDb.user,
            json:userJson)
        settings?.firebaseId = userId
        
        firebaseLoaded(user:user)
    }
    
    private func firebaseLoaded(user:FDbUserItem)
    {
        handler = user.handler
        score = user.score
        active = user.active
        DManager.sharedInstance?.save()
        
        NotificationCenter.default.post(
            name:Notification.sessionLoaded,
            object:nil)
    }
    
    //MARK: public
    
    func loadSession()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.asyncLoadSession()
        }
    }
}
