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
    
    func listenOnce(
        path:String,
        nodeType:FDatabaseNodeProtocol.Type,
        completion:@escaping((FDatabaseNodeProtocol?) -> ()))
    {
        let pathReference:FIRDatabaseReference = reference.child(path)
        pathReference.observeSingleEvent(of:FIRDataEventType.value)
        { (snapshot:FIRDataSnapshot) in
            
            var node:FDatabaseNodeProtocol?
            
            guard
                
                let json:Any = snapshot.value
                
            else
            {
                completion(node)
                
                return
            }
            
            if let _:NSNull = json as? NSNull
            {
            }
            else
            {
                node = nodeType.init(snapshot:json)
            }
            
            completion(node)
        }
    }

    func listen(
        eventType:FIRDataEventType,
        path:String,
        nodeType:FDatabaseNodeProtocol.Type,
        completion:@escaping((FDatabaseNodeProtocol?) -> ())) -> UInt
    {
        let pathReference:FIRDatabaseReference = reference.child(path)
        let handler:UInt = pathReference.observe(eventType)
        { (snapshot:FIRDataSnapshot) in
            
            var node:FDatabaseNodeProtocol?
            
            guard
                
                let json:Any = snapshot.value
                
            else
            {
                completion(node)
                
                return
            }
            
            if let _:NSNull = json as? NSNull
            {
            }
            else
            {
                node = nodeType.init(snapshot:json)
            }
            
            completion(node)
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
