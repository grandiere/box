import Foundation
import FirebaseDatabase

class FDb
{
    static let user:String = "user"
    static let algoBug:String = "algoBug"
    static let algoVirus:String = "algoVirus"
    static let algoAid:String = "algoAid"
    static let harvest:String = "harvest"
    private let reference:DatabaseReference
    
    init()
    {
        reference = Database.database().reference()
    }
    
    //MARK: public
    
    @discardableResult func createChild(
        path:String,
        json:Any) -> String
    {
        let childReference:DatabaseReference = reference.child(path).childByAutoId()
        let childId:String = childReference.key
        childReference.setValue(json)
        
        return childId
    }
    
    func updateChild(
        path:String,
        json:Any)
    {
        let childReference:DatabaseReference = reference.child(path)
        childReference.setValue(json)
    }
    
    func removeChild(path:String)
    {
        let childReference:DatabaseReference = reference.child(path)
        childReference.removeValue()
    }
    
    func listenOnce(
        path:String,
        nodeType:FDbProtocol.Type,
        completion:@escaping((FDbProtocol?) -> ()))
    {
        let pathReference:DatabaseReference = reference.child(path)
        pathReference.observeSingleEvent(of:DataEventType.value)
        { (snapshot:DataSnapshot) in
            
            var node:FDbProtocol?
            
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
        eventType:DataEventType,
        path:String,
        nodeType:FDbProtocol.Type,
        completion:@escaping((FDbProtocol?) -> ())) -> UInt
    {
        let pathReference:DatabaseReference = reference.child(path)
        let handler:UInt = pathReference.observe(eventType)
        { (snapshot:DataSnapshot) in
            
            var node:FDbProtocol?
            
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
    
    func stopListening(
        path:String,
        handler:UInt)
    {
        let pathReference:DatabaseReference = reference.child(path)
        pathReference.removeObserver(withHandle:handler)
    }
    
    func transaction(
        path:String,
        transactionBlock:@escaping((MutableData) -> (TransactionResult)))
    {
        let childReference:DatabaseReference = reference.child(path)
        childReference.runTransactionBlock(transactionBlock)
    }
}
