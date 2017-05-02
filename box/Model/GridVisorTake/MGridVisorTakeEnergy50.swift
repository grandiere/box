import Foundation

class MGridVisorTakeEnergy50:MGridVisorTakeEnergy
{
    private let kEnergyAmount:Int16 = 50
    
    init()
    {
        super.init(energyAmount:kEnergyAmount)
    }
}
