import Foundation

class MGridVisorTakeEnergy40:MGridVisorTakeEnergy
{
    private let kEnergyAmount:Int16 = 40
    
    init()
    {
        super.init(energyAmount:kEnergyAmount)
    }
}
