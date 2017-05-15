import Foundation
import CoreLocation

class MGridAlgoFactory
{
    private let coordinateSpan:UInt32
    private let kBugDifficulty:UInt32 = 10
    private let kAidDifficulty:UInt32 = 5
    private let kCoordinateDivider:Double = 10000
    private let kCoordinateSingleSpan:Double = 35
    
    init()
    {
        coordinateSpan = UInt32(kCoordinateSingleSpan + kCoordinateSingleSpan)
    }
    
    private func shouldCreate(difficulty:UInt32) -> Bool
    {
        let random:UInt32 = arc4random_uniform(difficulty)
        
        return random == 0
    }
    
    private func randomCoordinate(coordinate:Double) -> Double
    {
        let rawRandom:UInt32 = arc4random_uniform(coordinateSpan)
        let randomDouble:Double = Double(rawRandom)
        let randomHalf:Double = randomDouble - kCoordinateSingleSpan
        let randomDivided:Double = randomHalf / kCoordinateDivider
        let newCoordinate:Double = coordinate + randomDivided
        
        return newCoordinate
    }
    
    private func latitudeFor(location:CLLocation) -> Double
    {
        let randomized:Double = randomCoordinate(
            coordinate:location.coordinate.latitude)
        
        return randomized
    }
    
    private func longitudeFor(location:CLLocation) -> Double
    {
        let randomized:Double = randomCoordinate(
            coordinate:location.coordinate.longitude)
        
        return randomized
    }
    
    //MARK: public
    
    func releaseVirus(
        userId:String,
        location:CLLocation,
        level:Int)
    {
        let latitude:Double = latitudeFor(location:location)
        let longitude:Double = longitudeFor(location:location)
        let created:TimeInterval = Date().timeIntervalSince1970
        
        let firebaseVirus:FDbAlgoHostileVirusItem = FDbAlgoHostileVirusItem(
            latitude:latitude,
            longitude:longitude,
            created:created,
            level:level,
            userId:userId)
        
        guard
            
            let virusJson:Any = firebaseVirus.json()
            
        else
        {
            return
        }
        
        FMain.sharedInstance.db.createChild(
            path:FDb.algoVirus,
            json:virusJson)
    }
    
    func createBug(
        location:CLLocation,
        force:Bool) -> MGridAlgoItemHostileBug?
    {
        if !force
        {
            if !shouldCreate(difficulty:kBugDifficulty)
            {
                return nil
            }
        }
        
        let level:Int = MSession.sharedInstance.level
        let latitude:Double = latitudeFor(location:location)
        let longitude:Double = longitudeFor(location:location)
        let created:TimeInterval = Date().timeIntervalSince1970
        
        let firebaseBug:FDbAlgoHostileBugItem = FDbAlgoHostileBugItem(
            latitude:latitude,
            longitude:longitude,
            created:created,
            level:level)
        
        guard
            
            let bugJson:Any = firebaseBug.json()
            
        else
        {
            return nil
        }
        
        let bugId:String = FMain.sharedInstance.db.createChild(
            path:FDb.algoBug,
            json:bugJson)
        
        let bug:MGridAlgoItemHostileBug = MGridAlgoItemHostileBug(
            firebaseId:bugId,
            firebaseBug:firebaseBug)
        
        return bug
    }
    
    func createAid(location:CLLocation) -> MGridAlgoItemAid?
    {
        if !shouldCreate(difficulty:kAidDifficulty)
        {
            return nil
        }
        
        let latitude:Double = latitudeFor(location:location)
        let longitude:Double = longitudeFor(location:location)
        let created:TimeInterval = Date().timeIntervalSince1970
        
        let firebaseAid:FDbAlgoAidItem = FDbAlgoAidItem(
            latitude:latitude,
            longitude:longitude,
            created:created)
        
        guard
            
            let aidJson:Any = firebaseAid.json()
            
        else
        {
            return nil
        }
        
        let aidId:String = FMain.sharedInstance.db.createChild(
            path:FDb.algoAid,
            json:aidJson)
        
        let aid:MGridAlgoItemAid = MGridAlgoItemAid(
            firebaseId:aidId,
            firebaseAid:firebaseAid)
        
        return aid
    }
}
