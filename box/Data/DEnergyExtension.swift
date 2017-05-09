import Foundation
import CoreData

extension DEnergy
{
    static let kMaxEnergy:Int16 = 100
    private static let kEnergyUpdateRate:Int = 30
    
    //MARK: private
    
    private func updateEnergy()
    {
        let timestamp:TimeInterval = Date().timeIntervalSince1970
        let deltaTimestamp:Int = Int(timestamp - lastDate)
        let energyRecovered:Int = deltaTimestamp / DEnergy.kEnergyUpdateRate
        
        if energyRecovered > 0
        {
            let energy16:Int16 = Int16(energyRecovered)
            var newEnergy:Int16 = lastAmount + energy16
            
            if newEnergy > DEnergy.kMaxEnergy
            {
                newEnergy = DEnergy.kMaxEnergy
            }
            
            amount = newEnergy
            DManager.sharedInstance?.save()
        }
    }
    
    //MARK: public
    
    func tryUpdateEnergy()
    {
        if amount < DEnergy.kMaxEnergy
        {
            updateEnergy()
        }
    }
    
    func defaultValues()
    {
        amount = DEnergy.kMaxEnergy
        lastAmount = amount
        lastDate = Date().timeIntervalSince1970
    }
    
    func percentEnergy() -> Int
    {
        if amount >= DEnergy.kMaxEnergy
        {
            return 100
        }
        else
        {
            updateEnergy()
        }
        
        let floatAmount:Float = Float(amount)
        let percentAmount:Float = floatAmount / Float(DEnergy.kMaxEnergy)
        let intPercent:Int = Int(percentAmount * 100)
        
        return intPercent
    }
    
    func spendEnergy(energyCost:Int16)
    {
        amount -= energyCost
        
        if amount < 0
        {
            amount = 0
        }
        
        lastAmount = amount
        lastDate = NSDate().timeIntervalSince1970
        
        DManager.sharedInstance?.save()
    }
    
    func addEnergy(energyAmount:Int16)
    {
        amount += energyAmount
        lastAmount += energyAmount
        
        if amount > DEnergy.kMaxEnergy
        {
            amount = DEnergy.kMaxEnergy
        }
        
        if lastAmount > DEnergy.kMaxEnergy
        {
            lastAmount = DEnergy.kMaxEnergy
        }
        
        DManager.sharedInstance?.save()
    }
    
    func rechargeEnergy()
    {
        amount = DEnergy.kMaxEnergy
        lastAmount = DEnergy.kMaxEnergy
        
        DManager.sharedInstance?.save()
    }
}
