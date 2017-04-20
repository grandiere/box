import UIKit
import CoreLocation

class MGridAlgoItem
{
    let location:CLLocation
    private(set) var distance:CLLocationDistance?
    private(set) var heading:Float
    var multipliedHeading:Float
    private let kDistanceDivider:Double = 1000
    private let k180:Double = 180
    
    init(
        latitude:Double,
        longitude:Double)
    {
        location = CLLocation(latitude:latitude, longitude:longitude)
        heading = 0
        multipliedHeading = 0
    }
    
    //MARK: private
    
    private func degreesToRadians(degrees:Double) -> Double
    {
        return degrees * Double.pi / k180
    }
    
    private func RadiansToDegrees(_ radians: Double) -> Double {
        return radians * 180 / M_PI
    }
    
    
    private func headingFrom(reference:CLLocation) -> Double
    {
        let lat1 = DegreesToRadians(self.coordinate.latitude)
        let lon1 = DegreesToRadians(self.coordinate.longitude)
        
        let lat2 = DegreesToRadians(destinationLocation.coordinate.latitude);
        let lon2 = DegreesToRadians(destinationLocation.coordinate.longitude);
        
        let dLon = lon2 - lon1
        
        let y = sin(dLon) * cos(lat2);
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
        let radiansBearing = atan2(y, x)
        
        return radiansBearing
    }
    
    func bearingToLocationDegrees(destinationLocation:CLLocation) -> Double{
        return   RadiansToDegrees(bearingToLocationRadian(destinationLocation))
    }
    
    private func getHeading(reference:CLLocationCoordinate2D) -> Float
    {
        let degToRad:Double = Double.pi / k180
        let piReference:Double = reference.latitude * degToRad
        let piLocation:Double = location.coordinate.latitude * degToRad
        let lambdaReference:Double = reference.longitude * degToRad
        let lambdaLocation:Double = location.coordinate.longitude * degToRad
        
        let deltaLambda:Double = lambdaLocation - lambdaReference
        let sinPiReference:Double = sin(piReference)
        let sinPiLocation:Double = sin(piLocation)
        let cosPiReference:Double = cos(piReference)
        let cosPiLocation:Double = cos(piLocation)
        let cosLambda:Double = cos(deltaLambda)
        
        let sumDistance:Double = sinPiReference * sinPiLocation + cosPiReference * cosPiLocation * cosLambda
        let angularDistance:Double = acos(sumDistance)
        let distance = earthRadius * angularDistance
        
        return distance
    }
    
    //MARK: public
    
    final func distanceUser(userLocation:CLLocation)
    {
        distance = location.distance(from:userLocation) / kDistanceDivider
    }
    
    func imageStandby() -> UIImage?
    {
        return nil
    }
    
    func imageTargeted() -> UIImage?
    {
        return nil
    }
    
    func imageDetail() -> UIImage?
    {
        return nil
    }
    
    func detail() -> MGridVisorDetail
    {
        let model:MGridVisorDetail = MGridVisorDetail()
        
        return model
    }
}
