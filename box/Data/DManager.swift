import Foundation
import CoreData

class DManager
{
    static let sharedInstance:DManager? = DManager()
    private let managedObjectContext:NSManagedObjectContext
    private let kModelName:String = "DBox"
    private let kModelExtension:String = "momd"
    private let kSQLiteExtension:String = ".sqlite"
    
    private init?()
    {
        let sqliteFile:String = "\(kModelName)\(kSQLiteExtension)"
        let storeCoordinatorURL:URL = FileManager.appDirectory.appendingPathComponent(
            sqliteFile)
        
        guard
            
            let modelURL:URL = Bundle.main.url(
                forResource:kModelName,
                withExtension:kModelExtension),
            let managedObjectModel:NSManagedObjectModel = NSManagedObjectModel(
                contentsOf:modelURL)
            
        else
        {
            return nil
        }
        
        let persistentStoreCoordinator:NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(
            managedObjectModel:managedObjectModel)
        
        do
        {
            try persistentStoreCoordinator.addPersistentStore(
                ofType:NSSQLiteStoreType,
                configurationName:nil,
                at:storeCoordinatorURL,
                options:nil)
        }
        catch let error
        {
            #if DEBUG
                
                print("coredata: \(error.localizedDescription)")
                
            #endif
        }
        
        managedObjectContext = NSManagedObjectContext(
            concurrencyType:
            NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
    }
    
    //MARK: public
    
    func save(completion:(() -> ())? = nil)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            if self.managedObjectContext.hasChanges
            {
                self.managedObjectContext.perform
                {
                    do
                    {
                        try self.managedObjectContext.save()
                    }
                    catch let error
                    {
                        #if DEBUG
                            
                            print("CoreData: \(error.localizedDescription)")
                            
                        #endif
                    }
                    
                    completion?()
                }
            }
            else
            {
                completion?()
            }
        }
    }
    
    func createData(
        entityName:String,
        completion:@escaping((NSManagedObject?) -> ()))
    {
        managedObjectContext.perform
        {
            if let entityDescription:NSEntityDescription = NSEntityDescription.entity(
                forEntityName:entityName,
                in:self.managedObjectContext)
            {
                let managedObject:NSManagedObject = NSManagedObject(
                    entity:entityDescription,
                    insertInto:self.managedObjectContext)
                
                completion(managedObject)
            }
            else
            {
                completion(nil)
            }
        }
    }
    
    func createDataAndWait(entityName:String) -> NSManagedObject?
    {
        var managedObject:NSManagedObject?
        
        managedObjectContext.performAndWait
        {
            if let entityDescription:NSEntityDescription = NSEntityDescription.entity(
                forEntityName:entityName,
                in:self.managedObjectContext)
            {
                managedObject = NSManagedObject(
                    entity:entityDescription,
                    insertInto:self.managedObjectContext)
            }
        }
        
        return managedObject
    }
    
    func fetchData(
        entityName:String,
        limit:Int = 0,
        predicate:NSPredicate? = nil,
        sorters:[NSSortDescriptor]? = nil,
        completion:@escaping(([NSManagedObject]?) -> ()))
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            let fetchRequest:NSFetchRequest<NSManagedObject> = NSFetchRequest(
                entityName:entityName)
            fetchRequest.predicate = predicate
            fetchRequest.sortDescriptors = sorters
            fetchRequest.fetchLimit = limit
            fetchRequest.returnsObjectsAsFaults = false
            fetchRequest.includesPropertyValues = true
            fetchRequest.includesSubentities = true
            
            self.managedObjectContext.perform
            {
                let results:[NSManagedObject]?
                
                do
                {
                    results = try self.managedObjectContext.fetch(fetchRequest)
                }
                catch
                {
                    results = nil
                }
                
                completion(results)
            }
        }
    }
    
    func delete(data:NSManagedObject, completion:(() -> ())? = nil)
    {
        managedObjectContext.perform
        {
            self.managedObjectContext.delete(data)
            completion?()
        }
    }
    
    func deleteAndWait(data:NSManagedObject)
    {
        managedObjectContext.performAndWait
        {
            self.managedObjectContext.delete(data)
        }
    }
}
