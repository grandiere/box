import Foundation

class MGridAlgo
{
    private(set) var items:[MGridAlgoItem]
    
    init()
    {
        items = []
    }
    
    //MARK: public
    
    func loadAlgos()
    {
        let itemDefault:MGridAlgoItemHostileBug = MGridAlgoItemHostileBug(
            latitude:19.410595057002922,
            longitude:-99.175156495306979,
            difficulty:1,
            created:1)
        
        items.append(itemDefault)
    }
}
