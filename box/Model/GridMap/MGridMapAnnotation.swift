import UIKit
import MapKit

class MGridMapAnnotation:NSObject, MKAnnotation
{
    private(set) weak var algo:MGridAlgoItem!
    private(set) var coordinate:CLLocationCoordinate2D
    let image:UIImage
    private let kEmpty:String = ""
    
    init(
        algo:MGridAlgoItem,
        image:UIImage)
    {
        self.algo = algo
        self.coordinate = algo.location.coordinate
        self.image = image
        
        super.init()
    }
}
