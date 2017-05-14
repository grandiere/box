import UIKit

class MGridVisorMatch
{
    private weak var model:MGridAlgoItemHostile!
    private weak var controller:CGridVisorMatch?
    private var timesTried:Int
    private let tryTimes:Int
    private let difficulty:UInt32
    private let minDice:UInt32
    private let kDifficultyDivisor:CGFloat = 3
    private let kAddDifficulty:CGFloat = 1
    private let kMinTryTimes:Int = 1
    
    init(model:MGridAlgoItemHostile, controller:CGridVisorMatch)
    {
        self.model = model
        self.controller = controller
        timesTried = 0
        
        let userLevel:Int = MSession.sharedInstance.level
        var tryTimes:Int = model.level - userLevel
        
        if tryTimes < kMinTryTimes
        {
            tryTimes = kMinTryTimes
        }
        
        self.tryTimes = tryTimes
        
        let rawDifficulty:CGFloat = ceil(CGFloat(model.credits) / kDifficultyDivisor)
        let totalDifficulty:CGFloat = rawDifficulty + kAddDifficulty
        difficulty = UInt32(totalDifficulty)
        
        var minDice:Int = userLevel
        
        if let user:DUser = MSession.sharedInstance.settings?.user
        {
            minDice += Int(user.skill)
            minDice += Int(user.memory)
            minDice += Int(user.network)
            minDice += Int(user.processor)
        }
        
        self.minDice = UInt32(minDice)
    }
    
    //MARK: private
    
    private func rollDices()
    {
        let diceResult:UInt32 = arc4random_uniform(difficulty)
        
        if diceResult > minDice
        {
            controller?.failed()
        }
    }
    
    //MARK: public
    
    func timerTick()
    {
        if timesTried < tryTimes
        {
            timesTried += 1
            rollDices()
        }
        else
        {
            controller?.success()
        }
    }
}
