import Foundation

class MGridVirus
{
    private weak var modelAlgo:MGridAlgo!
    let kEnergyRequired:Int16 = 85
    
    init(modelAlgo:MGridAlgo)
    {
        self.modelAlgo = modelAlgo
    }
}
