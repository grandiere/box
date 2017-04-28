import Foundation

extension Dictionary
{
    func merge(other:Dictionary) -> Dictionary
    {
        var dictionary:Dictionary = Dictionary()
        let dictKeys:[Key] = Array(keys)
        let otherKeys:[Key] = Array(other.keys)
        
        for dictKey:Key in dictKeys
        {
            guard
                
                let dictElement:Value = self[dictKey]
                
            else
            {
                continue
            }
            
            dictionary[dictKey] = dictElement
        }
        
        for dictKey:Key in otherKeys
        {
            guard
                
                let dictElement:Value = other[dictKey]
                
            else
            {
                continue
            }
            
            dictionary[dictKey] = dictElement
        }
        
        return dictionary
    }
}
