import Foundation

class MSession
{
    static let sharedInstance:MSession = MSession()
    private(set) var settings:DSettings?
    
    private init()
    {
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
            self.connectFirebase()
        }
    }
    
    private func connectFirebase()
    {
        DManager.sharedInstance?.save()
        self.sessionLoaded()
    }
    
    private func sessionLoaded()
    {
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
