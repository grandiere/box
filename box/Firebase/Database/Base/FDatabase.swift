import Foundation
import FirebaseDatabase

class FDatabase
{
    enum Node:String
    {
        case user = "user"
        case gallery = "gallery"
    }
    
    private let reference:FIRDatabaseReference
    
    init()
    {
        reference = FIRDatabase.database().reference()
    }
    
    //MARK: public
    
    func createChild(path:String, json:Any) -> String
    {
        let childReference:FIRDatabaseReference = reference.child(path).childByAutoId()
        let childId:String = childReference.key
        childReference.setValue(json)
        
        return childId
    }
    
    func updateChild(path:String, json:Any)
    {
        let childReference:FIRDatabaseReference = reference.child(path)
        childReference.setValue(json)
    }
    
    func removeChild(path:String)
    {
        let childReference:FIRDatabaseReference = reference.child(path)
        childReference.removeValue()
    }
    
    func listenOnce<ModelType:FDatabaseModel>(path:String, modelType:ModelType.Type, completion:@escaping((ModelType?) -> ()))
    {
        let pathReference:FIRDatabaseReference = reference.child(path)
        pathReference.observeSingleEvent(of:FIRDataEventType.value)
        { (snapshot:FIRDataSnapshot) in
            
            guard
                
                let json:Any = snapshot.value
                
            else
            {
                completion(nil)
                
                return
            }
            
            if let _:NSNull = json as? NSNull
            {
                completion(nil)
                
                return
            }
                
            guard
                
                let model:ModelType = ModelType(snapshot:json)
                
            else
            {
                completion(nil)
                
                return
            }
            
            completion(model)
        }
    }

    func listen<ModelType:FDatabaseModel>(eventType:FIRDataEventType, path:String, modelType:ModelType.Type, completion:@escaping((ModelType?) -> ())) -> UInt
    {
        let pathReference:FIRDatabaseReference = reference.child(path)
        let handler:UInt = pathReference.observe(eventType)
        { (snapshot:FIRDataSnapshot) in
            
            guard
                
                let json:Any = snapshot.value
                
            else
            {
                completion(nil)
                
                return
            }
            
            if let _:NSNull = json as? NSNull
            {
                completion(nil)
                
                return
            }
            
            guard
                
                let model:ModelType = ModelType(snapshot:json)
                
            else
            {
                completion(nil)
                
                return
            }
            
            completion(model)
        }
        
        return handler
    }
    
    func stopListening(path:String, handler:UInt)
    {
        let pathReference:FIRDatabaseReference = reference.child(path)
        pathReference.removeObserver(withHandle:handler)
    }
    
    func transaction(path:String, transactionBlock:@escaping((FIRMutableData) -> (FIRTransactionResult)))
    {
        let childReference:FIRDatabaseReference = reference.child(path)
        childReference.runTransactionBlock(transactionBlock)
    }
}
