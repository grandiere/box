import Foundation
import MapKit

class MGridMapAnnotation:NSObject, MKAnnotation
{
    private(set) weak var algo:MGridAlgoItem?
    private(set) var coordinate:CLLocationCoordinate2D
    
    init(algo:MGridAlgoItem)
    {
        self.algo = algo
        self.coordinate = algo.location.coordinate
        
        super.init()
    }
}
