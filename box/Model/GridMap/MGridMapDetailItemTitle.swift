import Foundation

class MGridMapDetailItemTitle:MGridMapDetailItem
{
    init?(annotation:MGridMapAnnotation)
    {
        let rawTitle:String
        
        if let algoHostile:MGridAlgoItemHostile = annotation.algo as? MGridAlgoItemHostile
        {
            guard
            
                let hostileTitle:String = algoHostile.titleMatch()
            
            else
            {
                return
            }
        }
        else if let algoAid:MGridAlgoItemAid = annotation.algo as? MGridAlgoItemAid
        {
            
        }
        else
        {
            return nil
        }
    }
}
