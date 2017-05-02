import Foundation

class MGridVisorTakeEnergy30:MGridVisorTakeEnergy
{
    private let kEnergyAmount:Int16 = 30
    
    init()
    {
        super.init(energyAmount:kEnergyAmount)
    }
}
