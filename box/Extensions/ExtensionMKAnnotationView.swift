import MapKit

extension MKAnnotationView
{
    open class var reusableIdentifier:String
    {
        get
        {
            let classType:AnyClass = object_getClass(self)
            
            return NSStringFromClass(classType)
        }
    }
}
